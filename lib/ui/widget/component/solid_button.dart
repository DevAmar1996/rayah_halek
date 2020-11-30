import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/theme.dart';

import 'app_text.dart';

class SolidButton extends StatelessWidget {
  final String text;
  final Function() action;
  SolidButton(this.text,this.action);
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: action,
      child: Container(
        height: 40,
        decoration: AppThemeData.serviceDetailBoxDecoration(
            borderRadius: 8, borderColor: AppColors.hintGray, borderWidth: 1),
        child: Center(
          child: AppText(
            AppLocalization.of(context).translate(text),
            FontWeight.w700,
            15,
            AppColors.hintGray,
            TextAlign.center,
          ),
        ),
      ),
    );
  }
}
