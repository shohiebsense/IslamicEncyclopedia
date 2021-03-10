import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class HistoryHeaderView extends StatelessWidget {
  int number;

  HistoryHeaderView(this.number);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/bg_history_header.jpg",
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth,
        ),
        Text(
          number.toString().toPersianDigit(),
          style: TextStyle(fontSize: 36),
        )
      ],
    );
  }
}
