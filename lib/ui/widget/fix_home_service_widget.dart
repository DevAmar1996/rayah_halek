import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/model/service_data.dart';
import 'package:rayahhalekapp/ui/widget/general_service.dart';

import 'component/app_text.dart';
import 'component/custom_network_image.dart';

class FixHomeServiceWidget extends GeneralServiceWidget {
  final ServiceData service;

  FixHomeServiceWidget(isSelected, this.service) : super(isSelected);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Color(
            AppColors.lightGrayBorder,
          ),
        ),
        gradient: isSelected
            ? LinearGradient(
                colors: [Color(0xFFF67D16), Color(0xFFFA9C13)],
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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomNetworkImage(
              Helper.imageUrl + service.image,
              !isSelected ? AppColors.orangeIconColor : Colors.white.value,
              AppColors.orangeIconColor,
              47,
              47,
            ),
            SizedBox(
              height: 16,
            ),
            AppText(
              service.title,
              FontWeight.w500,
              15,
              !isSelected ? AppColors.hintGray : Colors.white.value,
              TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
