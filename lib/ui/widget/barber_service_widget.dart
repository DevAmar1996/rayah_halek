import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/model/service_data.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/component/custom_network_image.dart';
import 'package:rayahhalekapp/ui/widget/general_service.dart';

class BarberServiceWidget extends GeneralServiceWidget {
  final ServiceData serviceData;

  BarberServiceWidget(isSelected, this.serviceData) : super(isSelected);

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
                colors: [Color(0xFF2A3845), Color(0xFF3D4D63)],
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
              Helper.imageUrl + serviceData.image,
              !isSelected ? AppColors.boldBlue : Colors.white.value,
              ServiceModel.textColor(
                  ServiceModel.getService(serviceData.serviceId)),
              39,
              53,
            ),
            SizedBox(
              height: 5.5,
            ),
            AppText(
              serviceData.title,
              FontWeight.w800,
              16,
              !isSelected ? AppColors.boldBlue : Colors.white.value,
              TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.74,
              child: AppText(
                serviceData.description,
                FontWeight.w400,
                13,
                !isSelected ? AppColors.grayTextColor : Colors.white.value,
                TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
