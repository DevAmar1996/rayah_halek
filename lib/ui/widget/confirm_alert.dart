import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';

import 'component/app_text.dart';



class ConfirmAlert {


  static void showMe(BuildContext context, String message,Function() confirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: AppText(
          AppLocalization.of(context).translate("warning"),
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
                AppLocalization.of(context).translate("cancel"),
                FontWeight.w300,
                14,
                Colors.red.value,
                TextAlign.center),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: AppText(
                AppLocalization.of(context).translate("ok"),
                FontWeight.w300,
                14,
                Colors.blueAccent.value,
                TextAlign.center),
            onPressed: () {
              confirm();
            },
          ),

        ],
      ),
    );
  }
}
