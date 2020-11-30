import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/model/provider.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/provider_image.dart';

class ProviderWidget extends StatelessWidget {
  final int textColor;
  final ProviderData provider;
  Function() pressOtherProvider;

  ProviderWidget(this.textColor, this.provider, this.pressOtherProvider);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppThemeData.roundedBoxWithShadow(),
      margin: EdgeInsets.all(
        16,
      ),
      padding: EdgeInsetsDirectional.only(top: 12, start: 12, end: 11),
      height: 107,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              ProviderImage(
                textColor,
                path: Helper.imageUrl + provider.avatar,
              ),
              SizedBox(
                width: 11,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(provider.name, FontWeight.w700, 18, textColor,
                      TextAlign.start),
                  SizedBox(
                    height: 3,
                  ),
                  AppText(
                    provider.phone,
                    FontWeight.w400,
                    15,
                    AppColors.hintGray,
                    TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: pressOtherProvider,
            child: AppText(
              AppLocalization.of(context).translate("another_provider"),
              FontWeight.w400,
              13,
              AppColors.hintGray,
              TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
