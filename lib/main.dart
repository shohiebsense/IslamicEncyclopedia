import 'package:ensiklopedia_islam/page/home_page.dart';
import 'package:ensiklopedia_islam/utils.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This page.widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color(0xFF1B1B1B)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'PTSerif'
      ),
      home:
      HomePage()
    );
  }
}

