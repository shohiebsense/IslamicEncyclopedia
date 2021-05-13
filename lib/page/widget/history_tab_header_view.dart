import 'dart:math';

import 'package:ensiklopedia_islam/model/history.dart';
import 'package:ensiklopedia_islam/model/history_header.dart';
import 'package:ensiklopedia_islam/style/color.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

@immutable
class HistoryTabHeaderView extends StatefulWidget {
  bool innerBoxIsScrolled;

  HistoryTabHeaderView(this.innerBoxIsScrolled);

  @override
  _HistoryTabHeaderViewState createState() => _HistoryTabHeaderViewState();
}

class _HistoryTabHeaderViewState extends State<HistoryTabHeaderView> {
  List<Image> imageList = [];
  int randomNumber = 1 + Random().nextInt(7);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned.fill(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: imageList[randomNumber],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: '${context.watch<HistoryHeader>().name}',
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                    TextSpan(text: '\n\n'),
                    TextSpan(
                        text: '${context.watch<HistoryHeader>().summary}',
                        style: TextStyle(fontSize: 20, color: Colors.white))
                  ])),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    imageList = [
      Image.asset(
          'assets/bg_${1}-min.jpg'),
      Image.asset(
          'assets/bg_${2}-min.jpg'),
      Image.asset(
          'assets/bg_${3}-min.jpg'),
      Image.asset(
          'assets/bg_${4}-min.jpg'),
      Image.asset(
          'assets/bg_${5}-min.jpg'),
      Image.asset(
          'assets/bg_${6}-min.jpg'),
      Image.asset(
          'assets/bg_${1}-min.jpg'),
      Image.asset(
          'assets/bg_${7}-min.jpg'),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(imageList[randomNumber].image, context);
  }
}
