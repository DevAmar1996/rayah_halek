import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/header_widget.dart';
import 'package:rayahhalekapp/ui/widget/share_app_widget.dart';
import 'package:rayahhalekapp/vm/about_us_vm.dart';

class AboutAppScreen extends StatefulWidget {
  @override
  _AboutAppScreenState createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  final bool isProvider = Helper.isProvider;
  final Service service = Helper.service;
  AboutUsViewModel aboutUsViewModel = AboutUsViewModel();


  _AboutAppScreenState(){
    aboutUsViewModel.getAppConfig();
  }
  @override
  Widget build(BuildContext context) {

    return HeaderWidget(
        "about_app",
        16,
        AppText(
          "نموذج نص من المفترض أن يكون هنا يوضح آلية  عمل التطبيق ويوضح المعنى المراد إيصاله والهدف  نموذج نص من المفترض أن يكون هنا يوضح آلية  عمل التطبيق ويوضح المعنى المراد إيصاله والهدف المرجو تحقيقه  نموذج نص من المفترض أن يكون هنا يوضح آلية  عمل التطبيق ويوضح المعنى المراد إيصاله والهدف المرجو تحقيقه  نموذج نص من المفترض أن يكون هنا يوضح آلية  عمل التطبيق ويوضح المعنى المراد إيصاله والهدف المرجو تحقيقه  نموذج نص من المفترض أن يكون هنا يوضح آلية  عمل التطبيق ويوضح المعنى المراد إيصاله والهدف المرجو تحقيقه  نموذج نص من المفترض أن يكون هنا يوضح آلية  عمل التطبيق ويوضح المعنى المراد إيصاله والهدف المرجو تحقيقه المرجو تحقيقه ",
          FontWeight.w400,
          15,
          AppColors.hintGray,
          TextAlign.start,
        ),
        haveButton: true,
        buttonColors: isProvider
            ? ServiceModel.getButtonColors(Helper.service)
            : [
                (AppColors.purpleTextColor),
                (AppColors.purpleTextColor2),
              ],
        buttonText: "share_app",
        image: isProvider ? ServiceModel.getImageBg(service) : "",
        colors: isProvider
            ? ServiceModel.getImageColors(service)
            : [0xD437128D, 0xD49004B7],
        action: () {
       if(aboutUsViewModel.appConfig != null) {
         showModalBottomSheet(
             context: context, builder: (context) => ShareAppWidget(aboutUsViewModel.appConfig));
       }
    });

  }
}
