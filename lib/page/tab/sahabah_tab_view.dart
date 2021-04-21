// ignore: import_of_legacy_library_into_null_safe
import 'package:after_layout/after_layout.dart';
import 'package:ensiklopedia_islam/model/biography.dart';
import 'package:ensiklopedia_islam/model/biography_dao.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

const loremIpsum = "Kisah Nabi";

List<String> paragraphList = loremIpsum.split(". ");
StringBuffer stringBuffer = new StringBuffer();

class SahabahTabView extends StatefulWidget {
  //final bool isScrolling;
  final PageStorageKey key;
  final BiographyDao biographyDao;

  SahabahTabView(this.key, this.biographyDao) : super(key: key);

  @override
  SahabahTabViewState createState() => SahabahTabViewState();
}

class SahabahTabViewState extends State<SahabahTabView>
    with AfterLayoutMixin<SahabahTabView> {
  ExpandableController? expandableController;
  bool initFlag = false;
  List<Biography> biographyList = [];

  @override
  void afterFirstLayout(BuildContext context) async {
    //expandableController.expanded = this.page.widget.isScrolling;
  }

  Future<BiographyDao> getDao() async {
    return await new Future(() => this.widget.biographyDao);
  }

  Future<List<Biography>> getList() async {
    return getDao().then((value) {
      return value.findAllSahabah().then((value) {
        biographyList = value;

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
    return FutureBuilder(
      future: getList(),
      builder:
          (BuildContext context, AsyncSnapshot<List<Biography>> biographyList) {
        return ExpandableTheme(
          data: const ExpandableThemeData(
            iconColor: Colors.blue,
          ),
          child: ListView.separated(
            key: PageStorageKey('sahabah'),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: this.biographyList.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 1,
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
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          tapBodyToExpand: true,
                          tapBodyToCollapse: false,
                        ),
                        collapsed: SizedBox(
                          height: 110,
                          child: Row(
                            children: [
                              //HistoryHeaderView(index+1),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                    margin: EdgeInsets.all(12),
                                    width: 30,
                                    height: 30,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(4),
                                          bottomRight: Radius.circular(4),
                                          topLeft: Radius.circular(4),
                                          topRight: Radius.circular(4)),
                                      child: Container(
                                        color: Colors.greenAccent,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text((index + 1)
                                              .toString()
                                              .toPersianDigit()),
                                        ),
                                      ),
                                    )),
                              ),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(8.0, 16, 8,8),
                                      child: Text(
                                        biographyList.data![index].name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        biographyList.data![index].story,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        expanded: Text.rich(TextSpan(
                            text: this.biographyList[index].story,
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
                              theme:
                                  const ExpandableThemeData(crossFadePoint: 0),
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
