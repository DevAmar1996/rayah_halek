import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/model/order.dart';
import 'package:rayahhalekapp/model/user.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/provider_image.dart';

import 'container_with_title.dart';

class OrderUserDetailWidget extends StatelessWidget {
  final int textColor;
  final int titleColor;
  final int imageColor;
  final User user;
  final Function() call;

  OrderUserDetailWidget(
      this.titleColor, this.textColor, this.imageColor, this.user, this.call);

  @override
  Widget build(BuildContext context) {
    print(this.user);
    return ContainerWithTitle(
        "provider",
        Container(
          height: 79,
          padding: EdgeInsets.only(left: 11, right: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ProviderImage(
                    textColor,
                    path: user.avatar == null
                        ? ""
                        : (Helper.imageUrl + user.avatar),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        user.name,
                        FontWeight.w700,
                        15,
                        textColor,
                        TextAlign.start,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      AppText(
                        user.phone,
                        FontWeight.w500,
                        15,
                        AppColors.hintGray,
                        TextAlign.start,
                      ),
                    ],
                  )
                ],
              ),
              GestureDetector(
                onTap: call,
                child: Image(
                  width: 18,
                  height: 18,
                  color: Color(imageColor),
                  image: AssetImage(
                    AppThemeData.imagePath + "call.png",
                  ),
                ),
              )
            ],
          ),
        ),
        titleColor);
  }
}
