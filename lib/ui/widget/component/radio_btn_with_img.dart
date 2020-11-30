import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/component/radio_btn.dart';

class RadioButtonWithImage extends StatelessWidget {
  final String image;
  final String title;
  final int textColor;
  final bool isSelected;

  RadioButtonWithImage(this.image, this.title, this.textColor, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image(
              image: AssetImage(AppThemeData.imagePath + image),
              width: 23,
              height: 23,
              color: Color(textColor),
            ),
            SizedBox(
              width: 16,
            ),
            AppText(
              AppLocalization.of(context).translate(title),
              FontWeight.w700,
              15,
              textColor,
              TextAlign.start,
            ),
          ],
        ),
        RadioButton(
          26,
          isSelected,
          textColor,
        ),
      ],
    );
  }
}
