
import 'dart:math';

import 'package:ensiklopedia_islam/model/biography.dart';
import 'package:ensiklopedia_islam/page/widget/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class BiographyDetailArgs {
  int index;
  Biography biography;
  BiographyDetailArgs(this.index, this.biography);
}

class BiographyDetailPage extends StatelessWidget {
  static const routeName = '/biographyDetail';

  var imageList = [
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
  var randomNumber  = 1 + Random().nextInt(6);


  @override
  Widget build(BuildContext context) {
    final BiographyDetailArgs biographyDetailArgs = ModalRoute.of(context)!.settings.arguments as BiographyDetailArgs;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            EnsiklopediaIslamAppBar(title: biographyDetailArgs.biography.name,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: FittedBox(
                fit: BoxFit.cover,
                child: imageList[randomNumber],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: biographyDetailArgs.index,
                  child: Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text((biographyDetailArgs.index + 1)
                          .toString()
                          .toPersianDigit()),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      biographyDetailArgs.biography.story,
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
