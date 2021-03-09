import 'package:ensiklopedia_islam/style/color.dart';
import 'package:ensiklopedia_islam/style/text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class EnsiklopediaIslamAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: COLOR_DEFAULT,
      title: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 16.0),
          child: TEXT_TOOLBAR_TITLE_DEFAULT,
        ),
      ),
    );
  }
}
