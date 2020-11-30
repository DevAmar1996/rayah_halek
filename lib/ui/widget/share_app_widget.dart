import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/model/app_config.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/gradient_btn.dart';
import 'package:rayahhalekapp/vm/share_app_vm.dart';

class ShareAppWidget extends StatelessWidget {
  final List<String> images = [
    "gmail.png",
    "snapshat.png",
    "instagram.png",
    "twitter.png",
    "face.png"
  ];
  final bool isProvider = Helper.isProvider;
  final Service service = Helper.service;
  final AppConfig appConfig;
  final ShareAppVM shareAppVM = ShareAppVM();
  ShareAppWidget(this.appConfig);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppThemeData.modalBoxDecoration(),
      height: 308,
      padding: EdgeInsets.only(top: 28, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText(
            AppLocalization.of(context).translate("share_app2"),
            FontWeight.w700,
            20,
            AppColors.purpleTextColor,
            TextAlign.center,
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                5,
                (index) {
                  return GestureDetector(
                    onTap: (){
                      share(index);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Image(
                        image: AssetImage(
                          AppThemeData.imagePath + images[index],
                        ),
                        width: 30,
                        height: 24,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          GradientButton(
            AppLocalization.of(context).translate("ok"),
            () {
              Navigator.of(context).pop();
            },
            isProvider
                ? ServiceModel.getButtonColors(service)
                : [
                    (AppColors.purpleTextColor),
                    (AppColors.purpleTextColor2),
                  ],
          )
        ],
      ),
    );

  }

  void share(int index){
    if(index == 0){
      shareAppVM.shareViaEmail(appConfig.email);
    }else if(index == 1){
      shareAppVM.shareIn(appConfig.snapchat);
    }else if(index == 2){
      shareAppVM.shareIn(appConfig.instagram);
    }else if(index == 3){
      shareAppVM.shareIn(appConfig.twitter);
    }else if(index == 4){
      shareAppVM.shareIn(appConfig.facebook);
    }
  }
}
