import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/api/api_request.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/model/user.dart';
import 'package:rayahhalekapp/provider/user_model.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/user_image.dart';

class AppDrawerHeader extends StatelessWidget {
  final bool isProvider = Helper.isProvider;
   Service service = Helper.service;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(builder: (context, model, child) {
      if(model.user  !=  null){
        service = Helper.service;
      }
      User user = model.user ?? Helper.user;
      return Container(
        height: 196 + MediaQuery.of(context).padding.top,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: AppThemeData.getHorizGradient(
            isProvider
                ? ServiceModel.getImageColors(service)
                : [0xFF36128C, 0xFF9004B7],
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              8,
            ),
            bottomRight: Radius.circular(
              8,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserImage(
                  100,
                  100,
                  user != null
                      ? Helper.imageUrl + user.avatar
                      : ""),
              SizedBox(
                height: 9,
              ),
              AppText(user?.name ?? "", FontWeight.w500, 15, Colors.white.value,
                  TextAlign.center),
              SizedBox(
                height: 10,
              ),
              AppText(user?.phone ?? "", FontWeight.w500, 10,
                  Colors.white.value, TextAlign.center),
            ],
          ),
        ),
      );
    });
  }
}
