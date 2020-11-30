import 'package:flutter/material.dart';

class AppTextStyle {
  final FontWeight weight;
  final double fontSize;
  final int color;

  AppTextStyle(this.weight, this.fontSize, this.color);

  TextStyle getTextStyle() {
    return TextStyle(
      fontFamily: 'DIN',
      fontWeight: weight,
      fontSize: fontSize,
      color: Color(color),
      height: 1.2,
    );
  }
}
