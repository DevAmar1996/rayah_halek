import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/gradient_btn.dart';
import 'package:rayahhalekapp/helper/text_Style.dart';
import 'package:intl/intl.dart';

class PickDateWidget extends StatefulWidget {
  final int textColor;
  final List<int> colors;

  PickDateWidget(this.textColor, this.colors);

  @override
  _PickDateWidgetState createState() => _PickDateWidgetState();
}

class _PickDateWidgetState extends State<PickDateWidget> {
  var date =  new DateFormat.yMMMMEEEEd("ar")
      .format(DateTime.now())
      .toString();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 487,
      padding: EdgeInsetsDirectional.only(
        top: 15,
        start: 16,
        end: 16,
        bottom: 16,
      ),
      decoration: AppThemeData.modalBoxDecoration(),
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
            height: 8,
          ),
          Center(
            child: AppText(
              AppLocalization.of(context).translate("enter_date_time_service"),
              FontWeight.w700,
              18,
              widget.textColor,
              TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: AppText(
              date,
              FontWeight.w400,
              18,
              AppColors.hintGray,
              TextAlign.center,
            ),
          ),
          SizedBox(
            height: 22,
          ),
          Container(
            height: 150,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: AppTextStyle(
                    FontWeight.w400,
                    14,
                    (AppColors.hintGray),
                  ).getTextStyle(),
                ),
              ),
              child: CupertinoDatePicker(
                onDateTimeChanged: (dateTime) {
                  setState(() {
                    date = new DateFormat.yMMMMEEEEd("ar")
                        .format(dateTime)
                        .toString();
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 22,
          ),
          GradientButton(
            AppLocalization.of(context).translate("continue"),
            () {
              Navigator.of(context).pop(date);
            },
            widget.colors,
          ),
        ],
      ),
    );
  }
}
