// @dart=2.9
import 'package:after_layout/after_layout.dart';
import 'package:ensiklopedia_islam/model/history_dao.dart';
import 'package:ensiklopedia_islam/model/history_detail_dao.dart';
import 'package:ensiklopedia_islam/page/tab/prophet_tab_header_view.dart';
import 'package:ensiklopedia_islam/page/tab/prophet_tab_view.dart';
import 'package:ensiklopedia_islam/page/widget/common/app_bar.dart';
import 'package:ensiklopedia_islam/page/widget/common/bottom_navbar_view.dart';
import 'package:ensiklopedia_islam/page/widget/history_header_timeline_view.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timelines/timelines.dart';

import 'tab/history_tab_view.dart';
import 'tab/history_tab_header_view.dart';

class HomePage extends StatefulWidget {
  final HistoryDetailDao historyDetailDao;
  final HistoryDao historyDao;

  const HomePage({this.historyDetailDao, this.historyDao});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, AfterLayoutMixin<HomePage> {
  TabController tabController;
  var _scrollController = ScrollController();
  bool isInnerBoxScrolled = false;
  bool isScrolling = false;
  bool isScrollingDown = false;
  bool flagScrolling = true;

  PageStorageKey historyStorageKey = PageStorageKey('history');
  PageStorageKey prophetStorageKey = PageStorageKey('prophet');

  GlobalKey<HistoryTabViewState> key = GlobalKey();
  GlobalKey<HistoryTabViewState> key2 = GlobalKey();



  @override
  _HomePageState() {
    tabController = TabController(vsync: this, length: 1);
  }

  @override
  void initState() {
    super.initState();
  }

  void onCurrentIndexChanged(int position) {
    tabController.animateTo(position);
  }

  Future<HistoryDetailDao> getDao() async {
    return this.widget.historyDetailDao;
  }

  Widget _generateHeader(bool innerBoxIsScrolled) {
    switch (tabController.index) {
      case 0:
        return HistoryTabHeaderView(innerBoxIsScrolled);
      //case 1: return ProphetTabHeaderView(innerBoxIsScrolled);
    }
    return HistoryTabHeaderView(innerBoxIsScrolled);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDao(),
      builder:
          (BuildContext context, AsyncSnapshot<HistoryDetailDao> snapshot) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: NestedScrollView(
              controller: _scrollController,
              //physics: ScrollPhysics(),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                // These are the slivers that show up in the "outer" scroll view.
                return <Widget>[
                  SliverList(
                    delegate: new SliverChildListDelegate(
                      <Widget>[
                        Column(
                          children: [
                            EnsiklopediaIslamAppBar(),
                            _generateHeader(innerBoxIsScrolled),
                            HistoryHeaderTimelineView(this.widget.historyDao,
                                this.widget.historyDetailDao, () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // _generateHeader(innerBoxIsScrolled),
                ];
              },
              body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    HistoryTabView(historyStorageKey, this.widget.historyDetailDao, this.widget.historyDao),
                  ] //ProphetTabView(prophetStorageKey, this.widget.historyDetailDao)],
                  ),
            ),
            bottomNavigationBar: BottomNavBarView((int index) {
              setState(() {
                if (tabController.previousIndex == index) {
                  // _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                  return;
                }
                tabController.index = index;
              });
            }),
          ),
        );
      },
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels > 30) {
          WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
                // key.currentState.expandableController.expanded = true;
              }));
        }

        if (_scrollController.position.atEdge) {
          if (_scrollController.position.pixels == 0) {
            WidgetsBinding.instance?.addPostFrameCallback((_) => setState(() {
                  //   key.currentState.expandableController.expanded = false;
                }));
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) => setState(() {
                  isScrolling = true;
                  //  key.currentState.expandableController.expanded = true;
                }));
          }
        }
      });
  }
}
