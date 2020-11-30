import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/header_widget.dart';

class PaymentScreen extends StatefulWidget {
  final Service service;

  PaymentScreen(this.service);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final bool isProvider = Helper.isProvider;
  final Service service = Helper.service;
  @override
  Widget build(BuildContext context) {
  return HeaderWidget(
    "payment_method",
    16,
     Container(
      decoration: AppThemeData.roundedBoxWithShadow(),
      padding: EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          decoration: AppThemeData.serviceDetailBoxDecoration(),
          height: 63,
          child: Row(
            children: [
              SizedBox(
                width: 17,
              ),
              Icon(
                Icons.credit_card,
                color: Color(
                  AppColors.purpleTextColor2,
                ),
              ),
              SizedBox(
                width: 17,
              ),
              AppText(
                AppLocalization.of(context)
                    .translate("payment_method"),
                FontWeight.w800,
                14,
                AppColors.purpleTextColor2,
                TextAlign.center,
              ),
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
