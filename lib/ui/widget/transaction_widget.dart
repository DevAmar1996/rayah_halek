import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';

class TransactionWidget extends StatelessWidget {
  final int textColor;

  TransactionWidget(this.textColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172.66,
      decoration: AppThemeData.serviceDetailBoxDecoration(),
      padding: EdgeInsets.only(top: 6, left: 10, right: 10),
      margin: EdgeInsets.only(
        bottom: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: AppText(
                "165 R.S", FontWeight.w500, 25, textColor, TextAlign.center),
          ),
          SizedBox(
            height: 9,
          ),
          Divider(
            height: 1,
            color: Color(AppColors.dividerGrayColor).withOpacity(0.15),
          ),
          SizedBox(
            height: 9,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage(AppThemeData.imagePath + "visa.png"),
                width: 29,
                height: 23,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText("ماستر كارد", FontWeight.w700, 15,
                      AppColors.purpleTextColor2, TextAlign.center),
                  SizedBox(
                    height: 12,
                  ),
                  AppText("**** **** **** **** 4564", FontWeight.w700, 12,
                      AppColors.textGrayColor, TextAlign.center),
                  SizedBox(
                    height: 12,
                  ),
                  AppText("05.2020", FontWeight.w700, 12,
                      AppColors.textGrayColor, TextAlign.center),
                ],
              )
            ],
          ),
          SizedBox(
            height: 9,
          ),
          Divider(
            height: 1,
            color: Color(AppColors.dividerGrayColor).withOpacity(0.15),
          ),
          SizedBox(
            height: 9,
          ),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Color(AppColors.hintGray),
                size: 21,
              ),
              SizedBox(
                width: 18,
              ),
              AppText("20.07.2020 - 10:30 PM", FontWeight.w800, 15,
                  AppColors.hintGray, TextAlign.center),
            ],
          )
        ],
      ),
    );
  }
}
