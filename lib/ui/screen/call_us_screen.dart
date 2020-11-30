import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/ui/widget/component/CustomProgressDialog.dart';
import 'package:rayahhalekapp/ui/widget/component/error_dialog.dart';
import 'package:rayahhalekapp/ui/widget/header_widget.dart';
import 'package:rayahhalekapp/ui/widget/component/text_field.dart';
import 'package:rayahhalekapp/vm/contact_us_vm.dart';

class CallUsScreen extends StatefulWidget {
  @override
  _CallUsScreenState createState() => _CallUsScreenState();
}

class _CallUsScreenState extends State<CallUsScreen> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _titleFocusNode = new FocusNode();
  FocusNode _messageFocusNode = new FocusNode();

  TextEditingController _title = new TextEditingController();
  TextEditingController _message = new TextEditingController();
  final bool isProvider = Helper.isProvider;
  final Service service = Helper.service;

  ContactUsViewModel contactUsViewModel = ContactUsViewModel();

  @override
  Widget build(BuildContext context) {
    return HeaderWidget(
      "call_us",
      12,
      Form(
        key: _formKey,
        child: IntrinsicHeight(
          child: Column(
            children: [
              AppTextField(
                AppLocalization.of(context).translate("subject_title"),
                TextInputType.text,
                _titleFocusNode,
                null,
                _title,
                "",
                isLight: true,
                padding: 0,
              ),
              SizedBox(
                height: 8,
              ),
              AppTextField(
                AppLocalization.of(context).translate("message_hint"),
                TextInputType.text,
                _messageFocusNode,
                null,
                _message,
                AppLocalization.of(context).translate("message_require"),
                isLight: true,
                height: 200,
                isMultiLine: true,
              ),
            ],
          ),
        ),
      ),
      isScroll: true,
      haveButton: true,
      buttonColors: isProvider
          ? ServiceModel.getButtonColors(Helper.service)
          : [
              (AppColors.purpleTextColor),
              (AppColors.purpleTextColor2),
            ],
      image: isProvider ? ServiceModel.getImageBg(service) : "",
      colors: isProvider
          ? ServiceModel.getImageColors(service)
          : [0xD437128D, 0xD49004B7],
      buttonText: "send",
      action: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          CustomProgressDialog pr = CustomProgressDialog(context, "...", () {});
          pr.showDialog().then(
                  (value) async {
                try {
                  await contactUsViewModel.contactUs(
                      _title.text, _message.text);
                  pr.hideDialog();
                  AppDialog.showMe(
                    context,
                    AppLocalization.of(context).translate(
                        "call_us_accepted_success"),
                    isError: false,
                  );
                } catch (err) {
                  AppDialog.showMe(
                      context, err.toString().replaceAll("Exception:", ""));
                }
              }
          );
        }
      }
    );
  }
}
