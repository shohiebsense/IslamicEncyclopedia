import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class HistoryHeaderView extends StatelessWidget {
  int number;

  HistoryHeaderView(this.number);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            number.toString().toPersianDigit(),
            style: TextStyle(fontSize: 48, color: Colors.white),
          )
        ],
      ),
    );
  }
}
