import 'package:ensiklopedia_islam/main.dart';
import 'package:ensiklopedia_islam/model/history.dart';
import 'package:ensiklopedia_islam/model/history_dao.dart';
import 'package:ensiklopedia_islam/model/history_detail.dart';
import 'package:ensiklopedia_islam/model/history_detail_dao.dart';
import 'package:ensiklopedia_islam/model/history_header.dart';
import 'package:ensiklopedia_islam/style/color.dart';
import 'package:ensiklopedia_islam/style/icon_moon.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timelines/timelines.dart';
import 'package:provider/provider.dart';

class HistoryHeaderTimelineView extends StatefulWidget {
  //final Function(int position) onTimelineTapped;
  //HistoryTimelineView(this.onTimelineTapped);
  final HistoryDao historyDao;
  final HistoryDetailDao historyDetailDao;
  Function onTimelineChanged;

  HistoryHeaderTimelineView(this.historyDao, this.historyDetailDao,
      this.onTimelineChanged);

  @override
  _HistoryHeaderTimelineViewState createState() =>
      _HistoryHeaderTimelineViewState(historyDetailDao);
}

class _HistoryHeaderTimelineViewState extends State<HistoryHeaderTimelineView> {
  int currentPosition = 0;
  HistoryDetailDao historyDetailDao;

  _HistoryHeaderTimelineViewState(this.historyDetailDao);


  @override
  void initState() {
    super.initState();
  }

  Future<List<HistoryDetail>> findAllHistoryDetailsById() {
    Future<List<HistoryDetail>> value = historyDetailDao
        .findAllHistoryDetailsGroupById(context
        .watch<HistoryHeader>()
        .historyId);


    return value;
  }


  void onTimelineTapped(List<HistoryDetail> historyList, int index){

    int historyId = historyList[currentPosition].historyId;

    this.widget.historyDao.findHistoryById(historyId).then((
        value) {
      context.read<HistoryHeader>()
          .toggleCurrentTitle(
          value!.name!, value.summary!, value.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: COLOR_DEFAULT,
      height: 150,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FutureBuilder(
            future: historyDetailDao.findAllPeriods(),
            builder: (BuildContext context,
                AsyncSnapshot<List<HistoryDetail>> historyList) {
              if(historyList.hasData){
                onTimelineTapped(historyList.data!, currentPosition);
              }
              return !historyList.hasData ? Container() :
              FixedTimeline.tileBuilder(
                theme: TimelineThemeData(
                  direction: Axis.horizontal,
                  connectorTheme: ConnectorThemeData(
                    space: 33.0,
                    thickness: 5.0,
                  ),
                ),
                builder: TimelineTileBuilder.connected(
                  contentsAlign: ContentsAlign.alternating,
                  contentsBuilder: (context, index) =>
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: InkWell(
                          splashColor: Colors.grey.withAlpha(30),
                          onTap: () {
                            setState(() {
                              currentPosition = index;

                              onTimelineTapped(historyList.data!, index);


                              //this.page.widget.onTimelineTapped(currentPosition);
                              //print('Card Tapped');
                              //print("current POSITION $currentPosition");
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(historyList.data![index].period, style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                  connectorBuilder: (_, index, type) =>
                      DecoratedLineConnector(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.green,
                              Colors.white,
                            ],
                          ),
                        ),
                      ),
                  indicatorBuilder: (context, index) {
                    return RawMaterialButton(
                      constraints: BoxConstraints.expand(width: 42, height: 42),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {},
                      shape: CircleBorder(),
                      fillColor: (index == currentPosition
                          ? Colors.green
                          : HexColor("#1F1F1F")),
                      child: Icon(
                        MoonIcon.moon,
                        color: Colors.white,
                        size: 22.0,
                      ),
                    );
                  },
                  itemCount: historyList.data!.length,
                ),
              );
            }
        ),
      ),
    );
  }
}
