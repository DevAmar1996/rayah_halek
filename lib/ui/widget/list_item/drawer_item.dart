import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/model/service.dart';

import '../component/app_text.dart';

class DrawerItem extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String icon;
  final bool islLastOne;
  final bool isProvider = Helper.isProvider;
  final Service service = Helper.service;

  DrawerItem(this.title, this.icon, this.onTap, this.islLastOne);

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 18,
          left: 16,
          right: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image(
                      image: AssetImage(icon),
                      color: Color(isProvider
                          ? ServiceModel.textColor(service)
                          : AppColors.purpleTextColor),
                      width: 16,
                      height: 14,
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    AppText(
                      AppLocalization.of(context).translate(title),
                      FontWeight.w500,
                      15,
                      isProvider
                          ? ServiceModel.textColor(service)
                          : AppColors.purpleTextColor,
                      TextAlign.start,
                    )
                  ],
                ),
//                title == "orders"
//                    ? AppText(
//                        "3",
//                        FontWeight.w500,
//                        15,
//                        isProvider
//                            ? AppColors.redColor
//                            : AppColors.purpleTextColor,
//                        TextAlign.start,
//                      )
//                    : SizedBox()
              ],
            ),
            !islLastOne
                ? Divider(
                    height: 1,
                    color: Color(0x2B707070),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
