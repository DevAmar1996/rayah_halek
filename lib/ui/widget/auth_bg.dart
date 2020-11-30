import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/theme.dart';

class AuthBg extends StatelessWidget {
  final Widget contentWidget;
  final String image;

  final int borderRadius;

  final List<int> colors;

  AuthBg(this.contentWidget,
      {this.image = "",
      this.borderRadius = 0,
      this.colors = const [0xD437128D, 0xD49004B7]});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            AppThemeData.imagePath + (image == "" ? "splash_bg.png" : image),
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius.toDouble()),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius.toDouble()),
          ),
          gradient: AppThemeData.getHorizGradient(colors),
        ),
        child: contentWidget,
      ),
    );
  }
}
