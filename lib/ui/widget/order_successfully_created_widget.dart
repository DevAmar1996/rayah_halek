import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/gradient_btn.dart';

class OrderCreatedSuccessfullyWidget extends StatelessWidget {
  final int textColor;
  final List<int> colors;

  OrderCreatedSuccessfullyWidget(this.textColor, this.colors);

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
                AppLocalization.of(context).translate("order_send_successfully"),
                FontWeight.w700,
                15,
                textColor,
                TextAlign.center,
              ),
              AppText(
                AppLocalization.of(context).translate("we_will_reply_soon"),
                FontWeight.w700,
                15,
                AppColors.hintGray,
                TextAlign.center,
              ),
              SizedBox(
                height: 26,
              ),
              GradientButton(
                AppLocalization.of(context).translate("my_order"),
                () {
//                  Navigator.of(context).popUntil(ModalRoute.withName('/main'));
                  Navigator.of(context).pushNamedAndRemoveUntil("/my_order",ModalRoute.withName('/main'));

                },
                colors,
              )
            ],
          ),
        ),
      ),
    );
  }
}
