import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';

import 'app_text.dart';

class AppDialog {
  final String message;

  AppDialog(this.message);

  static void showMe(BuildContext context, String message,
      {bool isError = true,Function onClickOk}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: AppText(
          isError ? AppLocalization.of(context).translate("err") : "",
          FontWeight.w800,
          17,
          Colors.black.value,
          TextAlign.center,
        ),
        content: AppText(
          message,
          FontWeight.w400,
          15,
          Colors.black.value,
          TextAlign.center,
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: AppText(
                AppLocalization.of(context).translate("ok"),
                FontWeight.w300,
                14,
                isError ? Colors.red.value : Colors.blueAccent.value,
                TextAlign.center),
            onPressed: () {
              Navigator.pop(context);
              if (onClickOk != null)
              onClickOk();
            },
          ),
        ],
      ),
    );
  }
}
