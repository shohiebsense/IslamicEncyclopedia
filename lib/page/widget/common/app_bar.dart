import 'package:ensiklopedia_islam/page/about_page.dart';
import 'package:ensiklopedia_islam/style/color.dart';
import 'package:ensiklopedia_islam/style/text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class EnsiklopediaIslamAppBar extends StatelessWidget {
  String? title;

  EnsiklopediaIslamAppBar({this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: COLOR_DEFAULT,
      title: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 24),
          child: title == null
              ? TEXT_TOOLBAR_TITLE_DEFAULT
              : Text(
                  title!,
                  style: TEXT_STYLE_DEFAULT,
                ),
        ),
      ),
      actions: title != 'Credits'
          ? [
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
            ]
          : [],
    );
  }
}
