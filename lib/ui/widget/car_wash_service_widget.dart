import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/model/service_data.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/general_service.dart';

import 'component/custom_network_image.dart';

class CarWashServiceWidget extends GeneralServiceWidget {
  final ServiceData serviceData;
  CarWashServiceWidget(isSelected,this.serviceData) : super(isSelected);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 157,
      margin: EdgeInsets.only(
        left: 16,
        right: 17,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            8,
          ),
        ),
        border: Border.all(
          color: Color(
            AppColors.borderGray,
          ),
          width: 1,
        ),
        gradient: isSelected
            ? LinearGradient(
                colors: [Color(0xFF386994), Color(0xFF6FC1BB)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              ),
      ),
      child: Container(
        padding: EdgeInsetsDirectional.only(
          start: 16,
          end: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            CustomNetworkImage(
              Helper.imageUrl + serviceData.image,
              !isSelected ? AppColors.iconGreenColor : Colors.white.value,
              AppColors.iconGreenColor,
              60.75,
              36,
            ),
            SizedBox(
              width: 26,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppText(
                 serviceData.title,
                  FontWeight.w800,
                  16,
                  !isSelected ? AppColors.iconGreenColor : Colors.white.value,
                  TextAlign.start,
                ),
                SizedBox(
                  height: 8,
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: AppText(
                     serviceData.description,
                      FontWeight.w400,
                      13,
                      !isSelected
                          ? AppColors.grayTextColor
                          : Colors.white.value,
                      TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
