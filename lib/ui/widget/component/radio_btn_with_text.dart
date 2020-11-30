import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/component/radio_btn.dart';

class RadioButtonWithText extends StatefulWidget {
  final int activeColor;
  final String text;
  final bool isSelected;
  final double size;
  final double fontSize;

  RadioButtonWithText(this.activeColor, this.text, this.isSelected,
      {this.size = 26, this.fontSize = 13});

  @override
  _RadioButtonWithTextState createState() => _RadioButtonWithTextState();
}

class _RadioButtonWithTextState extends State<RadioButtonWithText> {
  @override
  Widget build(BuildContext context) {
    return Row(
//      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RadioButton(widget.size, widget.isSelected, widget.activeColor),
        SizedBox(
          width: 10,
        ),
        new AppText(
            widget.text,
            FontWeight.w500,
            widget.fontSize,
            !widget.isSelected ? AppColors.hintGray : widget.activeColor,
            TextAlign.center),
      ],
    );
  }
}
