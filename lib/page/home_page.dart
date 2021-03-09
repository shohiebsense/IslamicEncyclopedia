import 'package:after_layout/after_layout.dart';
import 'package:ensiklopedia_islam/page/widget/common/app_bar.dart';
import 'package:ensiklopedia_islam/page/widget/common/bottom_navbar_view.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timelines/timelines.dart';

import 'card_page.dart';
import 'widget/history_body_view.dart';
import 'widget/history_timeline_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, AfterLayoutMixin<HomePage> {
  TabController tabController;
  var _scrollController = ScrollController();
  bool isScrolling = false;
  bool isScrollingDown = false;
  bool flagScrolling = true;

  GlobalKey<Card1State> key = GlobalKey();
  GlobalKey<Card1State> key2 = GlobalKey();

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: NestedScrollView(
          controller: _scrollController,
          physics: ScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverList(
                delegate: new SliverChildListDelegate(
                  <Widget>[
                    Column(
                      children: [
                        EnsiklopediaIslamAppBar(),
                        HistoryTimelineView(() {
                          tabController.animateTo(1);
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              HistoryBodyView(innerBoxIsScrolled)
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: [Card1(key), Card1(key2)],
          ),
        ),
        bottomNavigationBar: BottomNavBarView(() {

        }),
      ),
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
