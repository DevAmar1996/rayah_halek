import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/theme.dart';

import '../component/app_text.dart';

class ModalHeader extends StatelessWidget {
  final borderRadius = BorderRadius.only(
    topRight: Radius.circular(
      15,
    ),
    topLeft: Radius.circular(
      15,
    ),
  );

  final Widget modelContent;
  final String title;
  final double height;
  final int textColor;

  ModalHeader(this.modelContent, this.title, this.height, {this.textColor});

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: Container(
        height: height,
        padding: EdgeInsetsDirectional.only(
          top: 15,
          start: 16,
          end: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,

          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image(
                image: AssetImage(
                  AppThemeData.imagePath + "close.png",
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: AppText(
                  AppLocalization.of(context).translate(title),
                  FontWeight.w800,
                  18,
                  textColor == null ? AppColors.purpleTextColor2 : textColor,
                  TextAlign.center),
            ),
            SizedBox(
              height: 25,
            ),
            this.modelContent,
          ],
        ),
      ),
    );
  }
}
