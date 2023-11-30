// @dart=2.12
import 'package:after_layout/after_layout.dart';
import 'package:ensiklopedia_islam/model/biography_dao.dart';
import 'package:ensiklopedia_islam/model/history_dao.dart';
import 'package:ensiklopedia_islam/model/history_detail_dao.dart';
import 'package:ensiklopedia_islam/page/tab/prophet_tab_view.dart';
import 'package:ensiklopedia_islam/page/tab/sahabah_tab_view.dart';
import 'package:ensiklopedia_islam/page/tab/ulama_tab_view.dart';
import 'package:ensiklopedia_islam/page/widget/common/app_bar.dart';
import 'package:ensiklopedia_islam/page/widget/common/bottom_navbar_view.dart';
import 'package:ensiklopedia_islam/page/widget/history_header_timeline_view.dart';
import 'package:ensiklopedia_islam/style/color.dart';
import 'package:flutter/material.dart';

import 'tab/history_tab_view.dart';
import 'widget/history_tab_header_view.dart';

class HomePage extends StatefulWidget {
  final BiographyDao biographyDao;
  final HistoryDetailDao historyDetailDao;
  final HistoryDao historyDao;

  const HomePage({required this.historyDetailDao, required this.historyDao, required this.biographyDao});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, AfterLayoutMixin<HomePage> {
  late TabController tabController;
  var _scrollController = ScrollController();
  bool isInnerBoxScrolled = false;
  bool isScrolling = false;
  bool isScrollingDown = false;
  bool flagScrolling = true;
  late String tabTitle;

  PageStorageKey historyStorageKey = PageStorageKey('history');
  PageStorageKey prophetStorageKey = PageStorageKey('prophet');
  PageStorageKey ulamaStorageKey = PageStorageKey('ulama');
  PageStorageKey sahabahStorageKey = PageStorageKey('sahabah');

  GlobalKey<HistoryTabViewState> key = GlobalKey();
  GlobalKey<HistoryTabViewState> key2 = GlobalKey();

  @override
  _HomePageState() {
    tabController = TabController(vsync: this, length: 4);
  }

  @override
  void initState() {
    super.initState();
    tabTitle = "Sejarah";
  }

  void onCurrentIndexChanged(int position) {
    tabController.animateTo(position);
  }

  Future<HistoryDetailDao> getDao() async {
    return this.widget.historyDetailDao;
  }

  List<Widget> _generateHeader(bool innerBoxIsScrolled) {
    switch (tabController.index) {
      case 0:
        return [
          EnsiklopediaIslamAppBar(
            title: tabTitle,
          ),
          HistoryHeaderTimelineView(
              this.widget.historyDao, this.widget.historyDetailDao, () {}),
          HistoryTabHeaderView(innerBoxIsScrolled)
        ];
      //case 1: return ProphetTabHeaderView(innerBoxIsScrolled);
    }
    return [
      EnsiklopediaIslamAppBar(
        title: tabTitle,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDao(),
      builder:
          (BuildContext context, AsyncSnapshot<HistoryDetailDao> snapshot) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: COLOR_DEFAULT,
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
                        Column(children: _generateHeader(innerBoxIsScrolled)),
                      ],
                    ),
                  ),
                  // _generateHeader(innerBoxIsScrolled),
                ];
              },
              body: TabBarView(
                controller: tabController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  HistoryTabView(historyStorageKey,
                      this.widget.historyDetailDao, this.widget.historyDao),
                  ProphetTabView(prophetStorageKey, this.widget.biographyDao),
                  UlamaTabView(ulamaStorageKey, this.widget.biographyDao),
                  SahabahTabView(sahabahStorageKey, this.widget.biographyDao),
                ], //,
              ),
            ),
            bottomNavigationBar: BottomNavBarView((int index) {
              setState(() {
                /*if (tabController.previousIndex == index) {
                  // _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                  return;
                }*/
                switch (index) {
                  case 0:
                    {
                      tabTitle = 'Sejarah';
                    }
                    break;
                  case 1:
                    {
                      tabTitle = 'Nabi';
                    }
                    break;
                  case 2:
                    {
                      tabTitle = 'Sahabat';
                    }
                    break;
                  case 3:
                    {
                      tabTitle = 'Ulama';
                    }
                    break;
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
            WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
                  //   key.currentState.expandableController.expanded = false;
                }));
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
                  isScrolling = true;
                  //  key.currentState.expandableController.expanded = true;
                }));
          }
        }
      });
  }
}
