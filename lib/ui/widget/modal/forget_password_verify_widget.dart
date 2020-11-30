import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rayahhalekapp/api/app_api.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/ui/widget/component/CustomProgressDialog.dart';
import 'package:rayahhalekapp/ui/widget/component/error_dialog.dart';
import 'package:rayahhalekapp/ui/widget/modal/new_password_widget.dart';
import 'package:rayahhalekapp/ui/widget/component/text_field.dart';
import 'package:rayahhalekapp/vm/verify_password_vm.dart';

import '../component/app_text.dart';
import '../gradient_btn.dart';

class ForgetPasswordVerifyWidget extends StatefulWidget {
  String phone;

  ForgetPasswordVerifyWidget(this.phone);

  @override
  _ForgetPasswordVerifyWidgetState createState() =>
      _ForgetPasswordVerifyWidgetState();
}

class _ForgetPasswordVerifyWidgetState extends State<ForgetPasswordVerifyWidget>
    implements VerifyPasswordProtocol {
  final _formKey = GlobalKey<FormState>();
  FocusNode _firstCodeFocusNode = new FocusNode();
  FocusNode _secondCodeFocusNode = new FocusNode();
  FocusNode _thirdCodeFocusNode = new FocusNode();
  FocusNode _fourthCodeFocusNode = new FocusNode();

  TextEditingController _firstCode = new TextEditingController();
  TextEditingController _secondCode = new TextEditingController();
  TextEditingController _thirdCode = new TextEditingController();
  TextEditingController _fourthCode = new TextEditingController();

  var borderRadius = BorderRadius.only(
    topRight: Radius.circular(
      15,
    ),
    topLeft: Radius.circular(
      15,
    ),
  );

  VerifyPasswordVM _verifyPasswordVM;

  CustomProgressDialog pr;
  var count = 40;
  Timer timer;

  void initVm() {
    _verifyPasswordVM = VerifyPasswordVM(this);
  }

  @override
  void initState() {
    super.initState();
    initVm();
    setupTimer();
  }

  void setupTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        count -= 1;
        if (count == 0) {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: Container(
        height: 430,
        padding: EdgeInsetsDirectional.only(
          top: 15,
          start: 16,
          end: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.white,
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    AppLocalization.of(context)
                        .translate("forget_password_title"),
                    FontWeight.w800,
                    18,
                    AppColors.purpleTextColor2,
                    TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Center(
                  child: AppText(
                    "00:" +  (count > 9 ? count.toString() : "0$count") ,
                    FontWeight.w400,
                    40,
                    AppColors.purpleTextColor2,
                    TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Center(
                  child: AppText(
                    AppLocalization.of(context).translate("enter_verify_code"),
                    FontWeight.w700,
                    15,
                    AppColors.textGrayColor,
                    TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 31,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 51,
                      child: AppTextField(
                        "",
                        TextInputType.number,
                        _firstCodeFocusNode,
                        _secondCodeFocusNode,
                        _firstCode,
                        "",
                        isLight: true,
                        isCenter: true,
                        maxLength: 1,
                        height: 75,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 51,
                      child: AppTextField(
                        "",
                        TextInputType.number,
                        _secondCodeFocusNode,
                        _thirdCodeFocusNode,
                        _secondCode,
                        "",
                        isLight: true,
                        isCenter: true,
                        maxLength: 1,
                        height: 75,
//
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 51,
                      child: AppTextField(
                        "",
                        TextInputType.number,
                        _thirdCodeFocusNode,
                        _fourthCodeFocusNode,
                        _thirdCode,
                        "",
                        isLight: true,
                        isCenter: true,
                        maxLength: 1,
                        height: 75,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 51,
                      child: AppTextField(
                        "",
                        TextInputType.number,
                        _fourthCodeFocusNode,
                        null,
                        _fourthCode,
                        "",
                        isLight: true,
                        isCenter: true,
                        maxLength: 1,
                        height: 75,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                GradientButton(
                  AppLocalization.of(context).translate("next"),
                  () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      pr = CustomProgressDialog(context, "", () {});
                      pr.showDialog().then((value) {
                        _verifyPasswordVM.verifyCode(
                            widget.phone,
                            _firstCode.text +
                                _secondCode.text +
                                _thirdCode.text +
                                _fourthCode.text);
                      });
                    }
                  },
                  [
                    (AppColors.purpleTextColor),
                    (AppColors.purpleTextColor2),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    if (count == 0) {
                      pr = CustomProgressDialog(context, "", () {});
                      await pr.showDialog();
                      await _verifyPasswordVM.resetCode(
                        widget.phone,
                      );
                      pr.hideDialog();
                      AppDialog.showMe(
                          context,
                          AppLocalization.of(context)
                              .translate("resend_code_success"),
                          isError: false);
                      setState(() {
                        count = 40;
                        this.setupTimer();
                      });
                    }
                  },
                  child: Center(
                    child: AppText(
                      AppLocalization.of(context).translate("resend"),
                      FontWeight.w800,
                      15,
                      count == 0
                          ? AppColors.purpleTextColor2
                          : AppColors.borderGray,
                      TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didFail(String message) {
    pr.hideDialog();
    AppDialog.showMe(context, message);
  }

  @override
  void didSuccess() {
    pr.hideDialog();
    Navigator.of(context).pop();
    showModalBottomSheet(
      context: context,
      builder: (context) => NewPasswordWidget(
          widget.phone,
          _firstCode.text +
              _secondCode.text +
              _thirdCode.text +
              _fourthCode.text),
      isScrollControlled: true,
      isDismissible: false,
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
