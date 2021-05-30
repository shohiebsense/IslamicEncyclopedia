import 'package:ensiklopedia_islam/model/history.dart';
import 'package:ensiklopedia_islam/model/history_dao.dart';
import 'package:ensiklopedia_islam/model/history_detail.dart';
import 'package:ensiklopedia_islam/model/history_detail_dao.dart';
import 'package:ensiklopedia_islam/model/history_detail_header.dart';
import 'package:ensiklopedia_islam/page/about_page.dart';
import 'package:ensiklopedia_islam/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

List<HistoryDetail> historyDetailList = [];

class HistoryDetailPageArgs {
  int historyId;

  String period;
  String name;
  String summary;
  int index;
  List<HistoryDetail> historyDetailList;
  final HistoryDao historyDao;
  final HistoryDetailDao historyDetailDao;

  HistoryDetailPageArgs(
      this.historyId,
      this.period,
      this.name,
      this.summary,
      this.index,
      this.historyDetailList,
      this.historyDetailDao,
      this.historyDao);
}

class HistoryDetailPage extends StatefulWidget {
  static const routeName = '/historyDetail';
  HistoryDetailPageArgs historyDetailPageArgs;

  HistoryDetailPage({Key? key, required this.historyDetailPageArgs})
      : super(key: key);

  @override
  _HistoryDetailPageState createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  final HideNavbar hiding = HideNavbar();

  List<HistoryDetail>? periodList;
  PageController? _pageController;
  int pageIndex = 0;
  int currentPeriodIndex = 0;
  List<Widget> pageList = [];
  int pageListLength = 0;

  @override
  void initState() {
    super.initState();
    historyDetailList = widget.historyDetailPageArgs.historyDetailList;
    widget.historyDetailPageArgs.historyDetailDao
        .findAllPeriods()
        .then((value) {
      for (int i = 0; i < value.length; i++) {
        var element = value[i];
        if (element.historyId == widget.historyDetailPageArgs.historyId) {
          currentPeriodIndex = i;
          print("current period index $currentPeriodIndex");
        }
      }
      periodList = value;
    });

    pageIndex = this.widget.historyDetailPageArgs.index;
    _pageController =
        PageController(initialPage: this.widget.historyDetailPageArgs.index);
    _pageController!.addListener(() {
      setState(() {
        pageIndex = _pageController!.page!.toInt();
      });
    });

    context.read<HistoryDetailHeader>().toggleCurrentTitle(
        widget.historyDetailPageArgs.period +
            ' - ' +
            widget.historyDetailPageArgs.name,
        widget.historyDetailPageArgs.summary,
        402,
        22,
        5,
        3);

    setState(() {
      var pageList = buildPageList();
      pageListLength = pageList.length;
      this.pageList = pageList;
    });
    print(historyDetailList.length);
  }

  double getHeight(BuildContext context) {
    int length = context.watch<HistoryDetailHeader>().summary.length;
    if (length < 260) {
      return MediaQuery.of(context).size.height * 0.47;
    } else if (length > 260 && length < 320) {
      return MediaQuery.of(context).size.height * 0.6;
    } else if (length > 320 && length < 350) {
      return MediaQuery.of(context).size.height * 0.6;
    }
    return MediaQuery.of(context).size.height * 0.75;
  }

  get headerSliverBuilder => (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              /*flexibleSpace: FlexibleSpaceBar(
                background: imageList[0],
              ),*/
              backgroundColor: COLOR_DEFAULT,
              title: Text(context.watch<HistoryDetailHeader>().name),
              forceElevated: innerBoxIsScrolled,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AboutPage.routeName,
                      );
                    },
                    child: Icon(Icons.info),
                  ),
                )
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                LayoutBuilder(builder: (context, constraints) {
                  var pageNumber = pageIndex + 1;
                  return Stack(
                    children: [
                      SizedBox(
                        height: getHeight(context),
                        width: MediaQuery.of(context).size.width,
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              COLOR_DEFAULT_75, BlendMode.darken),
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: imageList[context
                                .watch<HistoryDetailHeader>()
                                .headerPicIndex],
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 24),
                                child: Center(
                                  child: SmoothPageIndicator(
                                      controller: _pageController,
                                      count: pageListLength,
                                      effect: ScrollingDotsEffect(
                                        activeStrokeWidth: 2.6,
                                        activeDotScale: .4,
                                        radius: 8,
                                        spacing: 10,
                                      )),
                                ),
                              ),
                              Center(
                                child: Text(
                                  pageNumber.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: context
                                            .watch<HistoryDetailHeader>()
                                            .name,
                                        style: TextStyle(
                                          fontSize: 23,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextSpan(text: '\n\n'),
                                      TextSpan(
                                          text: context
                                              .watch<HistoryDetailHeader>()
                                              .summary,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            letterSpacing: 0.6,
                                          )),
                                    ])),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          //todo sliver
        ];
      };

  @override
  Widget build(BuildContext context) {
    return getWholePage(context);
  }

  List<Widget> buildPageList() {
    List<Widget> pageList = [];
    for (int i = 0; i < historyDetailList.length; i++) {
      HistoryDetail historyDetail = historyDetailList[i];
      pageList.add(getSingleHistoryDetailPage(historyDetail));
    }
    return pageList;
  }

  void navigateToNewPeriod() {
    print("current period ${currentPeriodIndex}");
    HistoryDetail historyDetail = periodList![currentPeriodIndex];
    print("historyDetail " + historyDetail.historyId.toString());
    Future<History?> history = widget.historyDetailPageArgs.historyDao
        .findHistoryById(historyDetail.historyId);
    history.then((value) {
      print("value " + value!.name!);
      context.read<HistoryDetailHeader>().toggleCurrentTitle(
          historyDetail.period + ' - ' + value.name!,
          value.summary!,
          value.id,
          0,
          2,
          5);

      this
          .widget
          .historyDetailPageArgs
          .historyDetailDao
          .findAllHistoryDetailsGroupById(historyDetail.historyId)
          .then((value) {
        historyDetailList = value;
        setState(() {
          pageList = buildPageList();
        });
        return value;
      });
    });
  }

  void _onNavBarTapped(BuildContext context, int bottomNavPosition) async {
    if (bottomNavPosition == 0) {
      if (_isPeriodFirstIndex() && _isFirstPage()) {
        return;
      }

      if (_isFirstPage()) {
        currentPeriodIndex--;
        navigateToNewPeriod();
        _pageController!.animateToPage(pageListLength - 1,
            curve: Curves.easeIn, duration: Duration(milliseconds: 250));
        return;
      }

      _pageController!.animateToPage(this.pageIndex - 1,
          curve: Curves.easeIn, duration: Duration(milliseconds: 250));
    } else {
      if (_isPeriodLastIndex() && _isLastPage()) {
        return;
      }

      if (_isLastPage()) {
        //navigate to next period
        currentPeriodIndex++;
        navigateToNewPeriod();
        _pageController!.animateToPage(0,
            curve: Curves.easeIn, duration: Duration(milliseconds: 250));
        return;
      }

      _pageController!.animateToPage(this.pageIndex + 1,
          curve: Curves.easeIn, duration: Duration(milliseconds: 250));
    }
  }

  bool isToRight(int index) {
    return index > this.pageIndex;
  }

  bool _isPeriodLastIndex() {
    //todo change to length
    return 7 == currentPeriodIndex;
  }

  bool _isPeriodFirstIndex() {
    return currentPeriodIndex == 0;
  }

  bool _isFirstPage() {
    return pageIndex == 0;
  }

  bool _isLastPage() {
    return pageIndex == getLastIndex();
  }

  int getLastIndex() {
    return widget.historyDetailPageArgs.historyDetailList.length - 1;
  }

  Widget getWholePage(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: hiding.visible,
        builder: (context, bool value, child) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: value ? kBottomNavigationBarHeight : 0.0,
            child: Wrap(
              children: [
                BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.black,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.arrow_back,
                        color:
                            _isPeriodFirstIndex() ? Colors.grey : Colors.black,
                      ),
                      label: '',
                      activeIcon: _isPeriodFirstIndex()
                          ? Icon(
                              Icons.arrow_back,
                              color: Colors.grey,
                            )
                          : Icon(Icons.arrow_back, color: Colors.black),
                      backgroundColor:
                          _isPeriodFirstIndex() ? disableColor : activeColor,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.arrow_forward,
                          color: _isPeriodLastIndex()
                              ? Colors.grey
                              : Colors.black),
                      label: '',
                      activeIcon: _isPeriodLastIndex()
                          ? Icon(
                              Icons.arrow_forward,
                              color: Colors.grey,
                            )
                          : Icon(Icons.arrow_forward, color: Colors.black),
                      backgroundColor:
                          _isPeriodLastIndex() ? disableColor : activeColor,
                    ),
                  ],
                  onTap: (int index) {
                    _onNavBarTapped(context, index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom:  MediaQuery.of(context).viewInsets.bottom),
        child: NestedScrollView(
          headerSliverBuilder: headerSliverBuilder,
          controller: hiding.controller,
          body: Column(
            children: [
              Expanded(
                //dont add padding here. bottom navigation is affected
                child: getContentPage(context),
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }

  /*Widget getSingleHistoryDetailPage(HistoryDetail historyDetail) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: true,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10 ,0),
                  child: Text(
                    historyDetail.desc,
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }*/

  Widget getSingleHistoryDetailPage(HistoryDetail historyDetail) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10 ,0),
          child: Text(
            historyDetail.desc,
            style: TextStyle(
              fontSize: 18,
              letterSpacing: 0.6,
            ),
          ),
        ),
    );
  }

  Widget getContentPage(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      children: pageList,
    );
    //children: [Container(), Container()]);
  }

  var imageList = [
    Image.asset('assets/bg_${1}-min.jpg'),
    Image.asset('assets/bg_${2}-min.jpg'),
    Image.asset('assets/bg_${3}-min.jpg'),
    Image.asset('assets/bg_${4}-min.jpg'),
    Image.asset('assets/bg_${5}-min.jpg'),
    Image.asset('assets/bg_${6}-min.jpg'),
    Image.asset('assets/bg_${1}-min.jpg'),
    Image.asset('assets/bg_${7}-min.jpg'),
  ];
}

class HideNavbar {
  final ScrollController controller = ScrollController();
  final ValueNotifier<bool> visible = ValueNotifier<bool>(true);

  HideNavbar() {
    visible.value = true;
    controller.addListener(
      () {
        if (controller.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (visible.value) {
            visible.value = false;
          }
        }
        if (controller.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!visible.value) {
            visible.value = true;
          }
        }

        if (controller.position.atEdge && controller.position.pixels != 0) {
          visible.value = true;
        }
      },
    );
  }

  void dispose() {
    controller.dispose();
    visible.dispose();
  }
}
