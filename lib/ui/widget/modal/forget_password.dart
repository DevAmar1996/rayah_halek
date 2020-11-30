import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/ui/widget/component/CustomProgressDialog.dart';
import 'package:rayahhalekapp/ui/widget/component/error_dialog.dart';

import 'package:rayahhalekapp/ui/widget/modal/forget_password_verify_widget.dart';
import 'package:rayahhalekapp/ui/widget/gradient_btn.dart';
import 'package:rayahhalekapp/ui/widget/modal/modal_header.dart';
import 'package:rayahhalekapp/ui/widget/component/text_field.dart';
import 'package:rayahhalekapp/vm/forget_passwoed_vm.dart';

class ForgetPasswordWidget extends StatefulWidget {
  @override
  _ForgetPasswordWidgetState createState() => _ForgetPasswordWidgetState();
}

class _ForgetPasswordWidgetState extends State<ForgetPasswordWidget>
    implements ForgetPasswordProtocol {
  final _formKey = GlobalKey<FormState>();
  FocusNode _mobileFocusNode = new FocusNode();

  TextEditingController _mobile = new TextEditingController();

  ForgetPasswordVm _forgetPasswordVm;

  CustomProgressDialog pr;

  void initVm() {
    _forgetPasswordVm = ForgetPasswordVm(this);
  }

  @override
  void initState() {
    super.initState();
    initVm();
  }

  @override
  Widget build(BuildContext context) {
    return ModalHeader(
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppTextField(
                  AppLocalization.of(context).translate("mobile_number"),
                  TextInputType.number,
                  _mobileFocusNode,
                  null,
                  _mobile,
                  "",
                  isLight: true,
                  height: 55,
                  textColor: AppColors.purpleColor,
                ),
                SizedBox(
                  height: 30,
                ),
                GradientButton(AppLocalization.of(context).translate("next"),
                    () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    pr = CustomProgressDialog(context, "", () {});
                    pr.showDialog().then((value) {
                      _forgetPasswordVm.forgetPassword(
                        _mobile.text,
                      );
                    },);
                  }
                }, [(AppColors.purpleTextColor), (AppColors.purpleTextColor2)])
              ],
            ),
          ),
        ),
        "forget_password",
        300);
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
      builder: (context) => ForgetPasswordVerifyWidget(_mobile.text),
      isScrollControlled: true,
      isDismissible: false,
    );
  }
}
