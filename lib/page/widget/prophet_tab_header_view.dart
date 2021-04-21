
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

@immutable
class ProphetTabHeaderView extends StatelessWidget {
  bool innerBoxIsScrolled;

   ProphetTabHeaderView(this.innerBoxIsScrolled);

  @override
  Widget build(BuildContext context) {
    return  SliverOverlapAbsorber(
      handle:
      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver: SliverAppBar(
        backgroundColor: HexColor("#1F1F1F"),
        expandedHeight: 250.0,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'NabiIslam',
                  style: TextStyle(fontSize: 27),
                ),
                TextSpan(text: '\n\n'),
                TextSpan(
                    text:
                    'Dolor Lipsum',
                    style: TextStyle(fontSize: 24))
              ]),
            ),
          ),
        ),
        forceElevated: innerBoxIsScrolled,
      ),
    );
  }
}
