import 'package:flutter/material.dart';

MaterialColor createMaterialColor(Color color){
  String beres = '';

  List opacityList = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red;
  final int g = color.green;
  final int b = color.blue;

  for(int i = 0; i < 9; i++){
    opacityList.add(0.1 * (i+1));
  }

  opacityList.forEach((opacity) {
    final double ds = 0.5 - opacity;
    swatch[(opacity * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        opacity);

  });
  return MaterialColor(color.value, swatch);
}