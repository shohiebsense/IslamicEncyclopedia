// ignore: import_of_legacy_library_into_null_safe
import 'package:after_layout/after_layout.dart';
import 'package:ensiklopedia_islam/model/history_detail.dart';
import 'package:ensiklopedia_islam/model/history_detail_dao.dart';
import 'package:ensiklopedia_islam/page/widget/history_item_header_view.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

const loremIpsum = "Kisah Nabi";

List<String> paragraphList = loremIpsum.split(". ");
StringBuffer stringBuffer = new StringBuffer();

class ProphetTabView extends StatefulWidget {
  //final bool isScrolling;
  final PageStorageKey key;
  final HistoryDetailDao historyDetailDao;
  ProphetTabView(this.key, this.historyDetailDao) : super(key: key);

  @override
  ProphetTabViewState createState() => ProphetTabViewState();
}

class ProphetTabViewState extends State<ProphetTabView> with AfterLayoutMixin<ProphetTabView> {
  ExpandableController? expandableController;
  bool initFlag = false;
   List<HistoryDetail> historyDetail = [];
   
  @override
  void afterFirstLayout(BuildContext context) async {
    //expandableController.expanded = this.page.widget.isScrolling;
  }

  Future<HistoryDetailDao> getDao() async{
     return await new Future(() => this.widget.historyDetailDao);
  }

  Future<List<HistoryDetail>> getList() async {
     return getDao().then((value)  {
       return value.findAllHistoryDetails().then((value) {
         historyDetail = value;
         print("CALLED, LENGTH ${value.length} ${historyDetail[0]}");

         return value;
       });
     });
  }

  @override
  void initState() {
    super.initState();
    if (expandableController == null) {
      expandableController = ExpandableController();
    }

  }

  @override
  Widget build(BuildContext context) {
   /* print("paragraph length  =>> ${paragraphList.length}");
    for (int i = 0; i < paragraphList.length; i++) {
      stringBuffer.write(paragraphList[i]);
      if (i % 2 == 0) {
        stringBuffer.write(".\n\n");
      } else {
        stringBuffer.write(". ");
      }
    }*/

    return FutureBuilder(
      future: getList(),
      builder: (BuildContext context, AsyncSnapshot<List<HistoryDetail>> historyDetail) {
        return ExpandableTheme(
          data: const ExpandableThemeData(
            iconColor: Colors.blue,
          ),
          child: ListView.separated(
            key: PageStorageKey('prophet'),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: this.historyDetail.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                //height: 2
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.zero,
                child: ExpandableNotifier(
                  //controller: expandableController,
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: ScrollOnExpand(
                      scrollOnExpand: true,
                      scrollOnCollapse: false,
                      child: ExpandablePanel(
                        theme: const ExpandableThemeData(
                          headerAlignment: ExpandablePanelHeaderAlignment.center,
                          tapBodyToExpand: true,
                          tapBodyToCollapse: false,
                        ),
                        collapsed: SizedBox(
                          height: 310,
                          child: Column(
                            children: [
                              HistoryHeaderView(index+1),
                              Padding(
                                padding: index == 0 ? const EdgeInsets.fromLTRB(8.0, 0, 8.0,8.0) : EdgeInsets.all(8.0),
                                child: Text(
                                  historyDetail.data![index].desc,
                                  softWrap: true,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 21.5,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        expanded: Text.rich(TextSpan(
                            text: this.historyDetail[index].desc,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21.5,
                                fontWeight: FontWeight.w600))),
                        builder: (_, collapsed, expanded) {
                          return Padding(
                            padding:
                            EdgeInsets.only(left: 0, right: 0, bottom: 0),
                            child: Expandable(
                              // controller: expandableController,
                              collapsed: collapsed,
                              expanded: expanded,
                              theme: const ExpandableThemeData(crossFadePoint: 0),

                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
