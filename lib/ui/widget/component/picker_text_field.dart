import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';

class PickerTextField extends StatelessWidget {
  final Function() onTap;
  final String initText;
  final bool isLoaded;
  final int borderColor;
  final int borderWidth;
  final double height;
  final int textColor;

  PickerTextField(this.onTap, this.initText, this.isLoaded,
      {this.borderColor = 0xFFFFFFFF, this.borderWidth = 0,this.height = 48,this.textColor = 0xFFFFFFFF});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            height: height,
            decoration: BoxDecoration(
                color: Color(AppColors.transparentWhite),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                border: Border.all(color: Color(this.borderColor),width: this.borderWidth.toDouble())),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: AppText(initText, FontWeight.w500, 15, textColor,
                  TextAlign.left),
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.only(
              end: 5,
            ),
            child: isLoaded
                ? Icon(
                    Icons.arrow_drop_down,
                    color:Color(textColor).withOpacity(0.6),
                    size: 25,
                  )
                : CupertinoActivityIndicator(),
          )
        ],
      ),
    );
  }
}
