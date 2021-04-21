// ignore: import_of_legacy_library_into_null_safe
import 'package:after_layout/after_layout.dart';
import 'package:ensiklopedia_islam/model/history_dao.dart';
import 'package:ensiklopedia_islam/model/history_detail.dart';
import 'package:ensiklopedia_islam/model/history_detail_dao.dart';
import 'package:ensiklopedia_islam/page/widget/history_item_view.dart';
import 'package:ensiklopedia_islam/model/history_header.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

StringBuffer stringBuffer = new StringBuffer();
class HistoryTabView extends StatefulWidget {
  //final bool isScrolling;
  final PageStorageKey key;
  final HistoryDetailDao historyDetailDao;
  final HistoryDao historyDao;

  HistoryTabView(this.key, this.historyDetailDao, this.historyDao)
      : super(key: key);

  @override
  HistoryTabViewState createState() {

    return HistoryTabViewState(historyDetailDao);
  }
}

class HistoryTabViewState extends State<HistoryTabView>
    with AfterLayoutMixin<HistoryTabView>,
        AutomaticKeepAliveClientMixin<HistoryTabView> {

  ExpandableController? expandableController;
  HistoryDetailDao historyDetailDao;
  HistoryTabViewState(this.historyDetailDao);

  bool initFlag = false;

  @override
  void afterFirstLayout(BuildContext context) async {
    print("AFTER FIRST LAYOUT");
    //expandableController.expanded = this.page.widget.isScrolling;
  }

  @override
  void initState() {
    expandableController = ExpandableController();
    super.initState();
  }


  @override
  void didChangeDependencies() {

  }

  @override
  bool get wantKeepAlive => true;

  @protected
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: historyDetailDao.findAllHistoryDetailsGroupById(context.watch<HistoryHeader>().historyId),
            builder: (BuildContext context,
                AsyncSnapshot<List<HistoryDetail>> historyDetail) {
              int length = historyDetail.data != null ? historyDetail.data!.length : 0;
              return ExpandableTheme(
                data: const ExpandableThemeData(
                  iconColor: Colors.blue,
                ),
                child: ListView.separated(
                  key: PageStorageKey('history'),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox.shrink(
                      //height: 2
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return HistoryItemView(index: index, desc: historyDetail.data![index].desc);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
