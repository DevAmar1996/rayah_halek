import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/ui/widget/component/error_dialog.dart';

class AppTextField extends StatefulWidget {
  final String hintText;
  final TextInputType textType;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final TextEditingController secondController;

  final FocusNode nextFocus;
  final String errMessage;

  final bool isLight;

  final bool isCenter;

  final int maxLength;

  final int height;

  final int focusColor;
  final int textColor;
  final bool isMultiLine;
  final double padding;
  final String initialText;
  final bool isEnabled;
  final int borderWidth;
  final Function(String) onChange;

   AppTextField(this.hintText, this.textType, this.focusNode, this.nextFocus,
      this.textEditingController, this.errMessage,
      {this.isLight = false,
      this.isCenter = false,
      this.maxLength,
      this.height = 48,
      this.focusColor = 0xFF36128C,
      this.textColor,
      this.isMultiLine = false,
      this.padding = 5,
      this.initialText = null,
      this.isEnabled = true,
      this.onChange,
        this.borderWidth = 1,
        this.secondController});

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  var startEditing = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      print("hello");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(widget.padding),
      height: widget.height.toDouble(),
      decoration: BoxDecoration(
        color: Color(AppColors.transparentWhite),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          width: widget.isLight ? 1 : 0,
          color: Color(
            widget.isLight
                ? (Colors.transparent.value)
                : AppColors.transparentWhite,
          ),
        ),
      ),
      child: TextFormField(
        onChanged: (val) {
          if (val.length == 1 && widget.maxLength == 1) {
            widget.focusNode.unfocus();
            if (widget.nextFocus != null) {
              FocusScope.of(context).requestFocus(widget.nextFocus);
            }
          }
          widget.onChange(val);
        },
        enableInteractiveSelection: widget.isEnabled,
        enabled: widget.isEnabled,
        initialValue: widget.initialText,
        minLines: widget.isMultiLine ? 5 : null,
        maxLines: widget.isMultiLine ? 10 : 1,
        textAlign: widget.isCenter ? TextAlign.center : TextAlign.start,
        focusNode: widget.focusNode,
        controller: widget.textEditingController,
        maxLength: widget.maxLength,
        decoration: widget.isLight
            ? (widget.isMultiLine
                ? AppThemeData.whiteInputDecorationWithoutLabel(
                    widget.hintText, widget.focusColor)
                : AppThemeData.whiteInputDecoration(
                    widget.hintText, widget.focusColor))
            : AppThemeData.inputDecoration(widget.hintText),
        style: AppThemeData.textFieldContentTextStyle(
          widget.textColor != null ? widget.textColor : Colors.white.value,
        ),
        obscureText: (widget.hintText ==
                AppLocalization.of(context).translate("password") ||
            widget.hintText ==
                AppLocalization.of(context).translate("confirm_new_password") ||
            widget.hintText ==
                AppLocalization.of(context).translate("new_password")),
        onFieldSubmitted: (s) {
          widget.focusNode.unfocus();
          if (widget.nextFocus != null) {
            FocusScope.of(context).requestFocus(widget.nextFocus);
          }
        },
        validator: (value) {
          if (widget.hintText ==
              AppLocalization.of(context).translate("confirm_new_password")) {
            if (widget.textEditingController.text !=
                widget.secondController.text) {
              AppDialog.showMe(context,
                  AppLocalization.of(context).translate("password_not_equal"));
              return widget.errMessage;
            }
          }

          if (value.trim() == "") {
            widget.focusNode.unfocus();
            return widget.errMessage;
          }
          return null;
        },
        textInputAction: widget.nextFocus != null
            ? TextInputAction.next
            : TextInputAction.done,
        keyboardType: widget.textType,
      ),
    );
  }
}
