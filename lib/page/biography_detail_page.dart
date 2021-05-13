
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


  @override
  Widget build(BuildContext context) {
    final BiographyDetailArgs biographyDetailArgs = ModalRoute.of(context)!.settings.arguments as BiographyDetailArgs;
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
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
              child: Text(
                biographyDetailArgs.biography.story,
                style: TextStyle(
                  fontSize: 18
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
