import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';

class NormalButton extends StatelessWidget {
  final String text;
  final Function action;

  const NormalButton(
    this.text,
    this.action,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      onPressed: action,
      color: Colors.white,
      height: 48,
      minWidth: MediaQuery.of(context).size.width,
      textColor: Color(
        AppColors.purpleTextColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: AppText(
        text,
        FontWeight.w600,
        18,
        AppColors.purpleTextColor,
        TextAlign.center,
      ),
    );
  }
}
