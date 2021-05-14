import 'dart:math';

import 'package:ensiklopedia_islam/model/biography.dart';
import 'package:ensiklopedia_islam/page/widget/common/app_bar.dart';
import 'package:ensiklopedia_islam/style/text.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';



class AboutPage extends StatelessWidget {
  static const routeName = '/about';

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
  var randomNumber = 1 + Random().nextInt(6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            EnsiklopediaIslamAppBar(
              title: 'Credits',
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: FittedBox(
                fit: BoxFit.cover,
                child: imageList[randomNumber],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: '\nIcon\n', style: TEXT_STYLE_BLACK),
                  TextSpan(text: 'Dinosoftlabs'),
                  TextSpan(text: '\nUnsplash\n',style: TEXT_STYLE_BLACK),
                  TEXT_UNSPLASH_CREDIT,
                  TextSpan(text: '\nSejarah\n',style: TEXT_STYLE_BLACK),
                  TEXT_REF_HISTORY,
                  TextSpan(text: '\nBiografi\n',style: TEXT_STYLE_BLACK),
                  TEXT_REF_BIOGRAPHY,
                  TextSpan(text: 'Content Team\n',style: TEXT_STYLE_BLACK),
                  TEXT_CONTENT_TEAM_CREDIT,
                  TextSpan(text: '\n\nSpecial Thanks: @anszrina\n',style: TEXT_STYLE_BLACK),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
