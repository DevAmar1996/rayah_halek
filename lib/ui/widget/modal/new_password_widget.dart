import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/ui/widget/component/CustomProgressDialog.dart';
import 'package:rayahhalekapp/ui/widget/component/error_dialog.dart';
import 'package:rayahhalekapp/ui/widget/component/text_field.dart';
import 'package:rayahhalekapp/vm/reset_password_vm.dart';

import '../component/app_text.dart';
import '../gradient_btn.dart';

class NewPasswordWidget extends StatefulWidget {
  final String phone;
  final String code;

  NewPasswordWidget(this.phone, this.code);

  @override
  _NewPasswordWidgetState createState() => _NewPasswordWidgetState();
}

class _NewPasswordWidgetState extends State<NewPasswordWidget>
    implements ResetPasswordProtocol {
  final _formKey = GlobalKey<FormState>();
  FocusNode _newPasswordFocusNode = new FocusNode();
  FocusNode _confirmNewPasswordFocusNode = new FocusNode();

  TextEditingController _newPassword = new TextEditingController();
  TextEditingController _confirmNewPassword = new TextEditingController();

  var borderRadius = BorderRadius.only(
    topRight: Radius.circular(
      15,
    ),
    topLeft: Radius.circular(
      15,
    ),
  );

  ResetPasswordVm _resetPasswordVm;

  CustomProgressDialog pr;

  void initVm() {
    _resetPasswordVm = ResetPasswordVm(this);
  }

  @override
  void initState() {
    super.initState();
    initVm();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: Container(
        height: 347,
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
                      AppLocalization.of(context).translate("new_password"),
                      FontWeight.w800,
                      18,
                      AppColors.purpleTextColor2,
                      TextAlign.center),
                ),
                SizedBox(
                  height: 35,
                ),
                AppTextField(
                  AppLocalization.of(context).translate("new_password"),
                  TextInputType.text,
                  _newPasswordFocusNode,
                  _confirmNewPasswordFocusNode,
                  _newPassword,
                 '',
                  isLight: true,
                  height: 55,

                  secondController: _confirmNewPassword,
                ),
                SizedBox(
                  height: 10,
                ),
                AppTextField(
                  AppLocalization.of(context).translate("confirm_new_password"),
                  TextInputType.text,
                  _confirmNewPasswordFocusNode,
                  null,
                  _confirmNewPassword,
                  '',
                  isLight: true,
                  height: 55,

                  secondController: _newPassword,
                ),
                SizedBox(
                  height: 30,
                ),
                GradientButton(
                  AppLocalization.of(context).translate("next"),
                  () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      pr = CustomProgressDialog(context, "", () {});
                      pr.showDialog().then((value) {
                        _resetPasswordVm.resetPassword(
                            widget.phone, widget.code, _newPassword.text);
                      });
                    }
                  },
                  [(AppColors.purpleTextColor), (AppColors.purpleTextColor2)],
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
    Navigator.of(context).pushNamed("/login");
  }
}
