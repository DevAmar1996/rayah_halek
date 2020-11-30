import 'package:flutter/material.dart';

import 'component/app_text.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final Function action;
  final List<int> colors;
  final double height;

  GradientButton(this.text, this.action, this.colors, {this.height = 48});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          colors :  [
            Color(
              colors[0],
            ),
            Color(
              colors[1],
            )
          ],
          begin: Alignment.centerLeft,

          end: Alignment.centerRight,

        ),
      ),
      child: MaterialButton(
        elevation: 0,
        onPressed: action,
        color: Colors.transparent,
        height: 48,
        minWidth: MediaQuery.of(context).size.width,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: AppText(
          text,
          FontWeight.w800,
          18,
          Colors.white.value,
          TextAlign.center,
        ),
      ),
    );
  }
}
