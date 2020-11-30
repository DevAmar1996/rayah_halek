import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/text_Style.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';

import 'app_localization.dart';

class AppThemeData {
  static String imagePath = "assets/photo/";
  static String drawerImagePath = "assets/photo/drawer/";

  static TextStyle largeTitle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 40,
      fontFamily: "DIN",
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle subTitle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontFamily: "DIN",
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle formTitle(Color color) {
    return TextStyle(
      color: color,
      fontSize: 18,
      fontFamily: "DIN",
      fontWeight: FontWeight.w800,
    );
  }

  static TextStyle hintText(int color) {
    return TextStyle(
      color: Color(color),
      fontSize: 15,
      fontFamily: "DIN",
      fontWeight: FontWeight.w800,
    );
  }

  static InputDecoration inputDecoration(String text) {
    return InputDecoration(
      labelText: text,
      labelStyle: hintText(AppColors.transparentGray),
      isDense: true,
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.none,
          color: Color(
            AppColors.transparentWhite,
          ),
          width: 0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.none,
          color: Color(
            AppColors.transparentWhite,
          ),
          width: 0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.none,
          color: Color(
            AppColors.transparentWhite,
          ),
          width: 0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(
          style: BorderStyle.none,
          color: Color(
            AppColors.transparentWhite,
          ),
          width: 0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(
          style: BorderStyle.none,
          color: Color(
            AppColors.transparentWhite,
          ),
          width: 0,
        ),
      ),
      errorStyle: errorStyle(),
    );
  }

  static TextStyle errorStyle() {
    return AppTextStyle(FontWeight.w300, 0, AppColors.redColor).getTextStyle();
  }

  static OutlineInputBorder grayOne = OutlineInputBorder(
    borderSide: BorderSide(
      style: BorderStyle.solid,
      color: Color(AppColors.borderGray),
      width: 1,
    ),
  );
  static OutlineInputBorder errOne = OutlineInputBorder(
    borderSide: BorderSide(
      style: BorderStyle.solid,
      color: Colors.red,
      width: 1,
    ),
  );

  static InputDecoration whiteInputDecoration(String text, int focusColor) {
    return InputDecoration(
      labelText: text,
      labelStyle: hintText(
        AppColors.borderGray,
      ),
      isDense: true,
      disabledBorder: grayOne,
      enabledBorder: grayOne,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Color(focusColor),
          width: 1,
        ),
      ),
      errorBorder: errOne,
      focusedErrorBorder: grayOne,
      errorStyle: errorStyle(),
    );
  }

  static InputDecoration whiteInputDecorationWithoutLabel(
      String text, int focusColor) {
    return InputDecoration(
      hintText: text,
      hintStyle: hintText(
        AppColors.hintGray,
      ),
      isDense: true,
      disabledBorder: grayOne,
      enabledBorder: grayOne,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Color(focusColor),
          width: 1,
        ),
      ),
      errorBorder: errOne,
      focusedErrorBorder: grayOne,
      errorStyle: errorStyle(),
    );
  }

  static TextStyle textFieldContentTextStyle(int color) {
    return TextStyle(
      color: Color(color),
      fontSize: 15,
      fontFamily: 'DIN',
      fontWeight: FontWeight.w500,
    );
  }

  static BoxDecoration roundedBoxWithShadow() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(
          15,
        ),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x12000000),
          blurRadius: 10,
          offset: Offset(0, 0),
        )
      ],
    );
  }

  static BoxDecoration serviceDetailBoxDecoration(
      {double borderRadius = 7,
      int borderColor = 0xFFE4E9ED,
      double borderWidth = 1,
      int color = 0x00000000}) {
    return BoxDecoration(
      color: Color(color),
      border: Border.all(color: Color(borderColor), width: borderWidth),
      borderRadius: BorderRadius.all(
        Radius.circular(
          borderRadius,
        ),
      ),
    );
  }

  static BoxDecoration modalBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(
          15,
        ),
        topLeft: Radius.circular(
          15,
        ),
      ),
    );
  }

  static LinearGradient getHorizGradient(List<int> colors) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      // repeats the gradient over the canvas
      colors: [
        Color(colors[0]),
        Color(colors[1]),
      ],
    );
  }

  static void showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: AppText(
            AppLocalization.of(context).translate("warning"),
            FontWeight.w800,
            17,
            Colors.black.value,
            TextAlign.center,
          ),
          content: AppText(
            AppLocalization.of(context).translate("should_login_to_continue"),
            FontWeight.w400,
            15,
            Colors.black.value,
            TextAlign.center,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: AppText(AppLocalization.of(context).translate("cancel"),
                  FontWeight.w300, 14, Colors.red.value, TextAlign.center),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: AppText(
                  AppLocalization.of(context).translate("login"),
                  FontWeight.w300,
                  14,
                  Colors.blueAccent.value,
                  TextAlign.center),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .pushNamed("/login");
              },
            ),

          ],
        );
      },
    );
  }
}
