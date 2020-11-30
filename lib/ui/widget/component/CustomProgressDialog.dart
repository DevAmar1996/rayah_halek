import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rayahhalekapp/helper/text_Style.dart';

class CustomProgressDialog {
  final BuildContext context;
  ProgressDialog pr;
  final String message;
  final Function didHide;

  CustomProgressDialog(this.context, this.message, this.didHide,      ) {
    pr = ProgressDialog(context, isDismissible: false,type:  ProgressDialogType.Normal);
    setupDialog();
  }

  void setupDialog() {
    pr.style(
      message: message,
      backgroundColor: Colors.white,
      progressTextStyle: AppTextStyle(FontWeight.w400, 16, 0xFF000000).getTextStyle(),
      messageTextStyle: AppTextStyle(FontWeight.w400, 16, 0xFF000000).getTextStyle(),);
  }

  Future<void> showDialog() async {
    await pr.show();
    return null;
  }

  void hideDialog() async {
    await pr.hide();
  }
}
