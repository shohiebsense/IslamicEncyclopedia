// @dart=2.9

import 'package:ensiklopedia_islam/model/biography_dao.dart';
import 'package:ensiklopedia_islam/model/history_dao.dart';
import 'package:ensiklopedia_islam/model/history_detail_dao.dart';
import 'package:ensiklopedia_islam/page/about_page.dart';
import 'package:ensiklopedia_islam/page/biography_detail_page.dart';
import 'package:ensiklopedia_islam/page/home_page.dart';
import 'package:ensiklopedia_islam/style/color.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:provider/provider.dart';
import 'database.dart';
import 'model/history.dart';
import 'model/history_header.dart';


//emulator @API24 -no-boot-anim -cpu-delay 0
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  IEDatabase.init();
  final database = await $FloorIEDatabase
      .databaseBuilder('IE.db')
      .build();


  final biographyDao = database.biographyDao;
  final historyDao = database.historyDao;
  final historyDetailDao = database.historyDetailDao;


  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HistoryHeader(),)

      ],
      child: MyApp(
          biographyDao, historyDao, historyDetailDao)));
}

class MyApp extends StatelessWidget {
  // This page.widget is the root of your application.
  final BiographyDao biographyDao;
  final HistoryDao historyDao;
  final HistoryDetailDao historyDetailDao;


  MyApp(this.biographyDao, this.historyDao, this.historyDetailDao);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {BiographyDetailPage.routeName : (context) => BiographyDetailPage(), AboutPage.routeName : (context) => AboutPage()} ,
      theme: ThemeData(
        scaffoldBackgroundColor: COLOR_DEFAULT,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'PTSerif'
      ),
      home:
      HomePage(historyDetailDao: historyDetailDao, historyDao: historyDao, biographyDao: biographyDao,)
    );
  }
}

class Log {
  static void print(String text){
    print('\x1B[31m$text\x1B[0m');
  }
}