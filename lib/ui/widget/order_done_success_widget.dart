import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/theme.dart';

import 'component/app_text.dart';

class OrderDoneSuccessWidget extends StatelessWidget {
  final int textColor;

  OrderDoneSuccessWidget(this.textColor);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 290.0,
          decoration: AppThemeData.serviceDetailBoxDecoration(
              borderRadius: 15, color: Colors.white.value),
          padding: EdgeInsets.only(
            left: 21,
            right: 21,
            top: 16,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 102,
                    height: 102,
                    decoration: BoxDecoration(
                      color: Color(textColor),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Image(
                    image: AssetImage(AppThemeData.imagePath + "like.png"),
                  ),
                ],
              ),
              SizedBox(
                height: 23,
              ),
              AppText(
                AppLocalization.of(context)
                    .translate("order_done_successfully"),
                FontWeight.w700,
                15,
                AppColors.purpleTextColor,
                TextAlign.center,
              ),
              SizedBox(
                height: 7,
              ),
              AppText(
                AppLocalization.of(context)
                    .translate("provider_will_arrive_soon"),
                FontWeight.w700,
                15,
                AppColors.purpleTextColor2,
                TextAlign.center,
              ),
              SizedBox(
                height: 26,
              ),

              Center(
                child: FlatButton(
                  onPressed: (){
                    Navigator.of(context).pushNamedAndRemoveUntil("/my_order",ModalRoute.withName('/main'));
                  },
                  child:  AppText(
                    AppLocalization.of(context)
                        .translate("my_order"),
                    FontWeight.w700,
                    15,
                    AppColors.hintGray,
                    TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
