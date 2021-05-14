import 'dart:math';

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

// ignore: must_be_immutable
class HistoryHeaderTimelineView extends StatelessWidget {
  //final Function(int position) onTimelineTapped;
  //HistoryTimelineView(this.onTimelineTapped);
  final HistoryDao historyDao;
  final HistoryDetailDao historyDetailDao;
  Function onTimelineChanged;
  late Future<List<HistoryDetail>> periodList;

  HistoryHeaderTimelineView(this.historyDao, this.historyDetailDao,
      this.onTimelineChanged){
    periodList = historyDetailDao.findAllPeriods();
  }



  void onTimelineItemTapped(BuildContext context, int index,
      List<HistoryDetail> historyList) {
    int historyId = historyList[index].historyId;
    int randomIndex = 1 + Random().nextInt(6);

    historyDao.findHistoryById(historyId).then((value) {
      context.read<HistoryHeader>()
          .toggleCurrentTitle(
          value!.name!, value.summary!, value.id, index, randomIndex);
    });
  }

  Future<List<HistoryDetail>> getAllPeriods(BuildContext context) async {
    return periodList.then((value) {
      onTimelineItemTapped(context, 0, value);
      return value;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      color: COLOR_DEFAULT,
      height: 150,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: StatefulWrapper(
          onInit: (){
            getAllPeriods(context);
          },
          child: FutureBuilder(
              future: periodList,
              builder: (BuildContext context,
                  AsyncSnapshot<List<HistoryDetail>> historyList) {
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
                              onTimelineItemTapped(context, index,
                                  historyList.data!);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(historyList.data![index].period,
                                style: TextStyle(color: Colors.white,),

                              ),
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
                        onPressed: () {
                          onTimelineItemTapped(context, index, historyList.data!);
                        },
                        shape: CircleBorder(),
                        fillColor: (index == context.watch<HistoryHeader>().headerIndex
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
      ),
    );
  }
}

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;

  const StatefulWrapper({required this.onInit, required this.child});

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    if(widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
