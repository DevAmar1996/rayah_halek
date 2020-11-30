import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/header_widget.dart';

class PaymentWayScreen extends StatefulWidget {
  @override
  _PaymentWayScreenState createState() => _PaymentWayScreenState();
}

class _PaymentWayScreenState extends State<PaymentWayScreen> {
  final bool isProvider = Helper.isProvider;
  final Service service = Helper.service;
  @override
  Widget build(BuildContext context) {
    return HeaderWidget(
      "paying_method",
      16,
      Align(
        alignment: AlignmentDirectional.topCenter,
        child: Container(
          height: 103,
          decoration: AppThemeData.serviceDetailBoxDecoration(),
          padding: EdgeInsets.only(top
               : 16,left: 10, right: 10),
          margin: EdgeInsets.only(
            bottom: 16,
          ),
          child: Center(
            child: Row(
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
          ),
        ),
      ),
      image: isProvider ? ServiceModel.getImageBg(service) : "",
      colors: isProvider
          ? ServiceModel.getImageColors(service)
          : [0xD437128D, 0xD49004B7],
    );
  }
}
