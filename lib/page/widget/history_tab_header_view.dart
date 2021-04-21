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
  double _height = 250;

  Future<void> aaa() async {}

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: COLOR_DEFAULT,
          child: Stack(
            children: [
              SizedBox.fromSize(
                size: Size(
                  constraints.maxWidth,
                  constraints.minHeight,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: '${context.watch<HistoryHeader>().name}',
                      style: TextStyle(fontSize: 27),
                    ),
                    TextSpan(text: '\n\n'),
                    TextSpan(
                        text: '${context.watch<HistoryHeader>().summary}',
                        style: TextStyle(fontSize: 24))
                  ])),
                ),
              ),
              SizedBox(height: 4,)
            ],
          ),
        );
      },
    );
  }
}
