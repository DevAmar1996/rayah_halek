import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/header_widget.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final bool isProvider = Helper.isProvider;
  final Service service = Helper.service;

  @override
  Widget build(BuildContext context) {
    return HeaderWidget(
      "privacy_policy",
      16,
      AppText(
          "نموذج نص من المفترض أن يكون هنا يوضح آلية  عمل التطبيق ويوضح المعنى المراد إيصاله"
          " والهدف  نموذج نص من المفترض أن يكون هنا يوضح آلية  عمل التطبيق ويوضح المعنى المراد "
          "إيصاله والهدف المرجو تحقيقه  نموذج نص من المفترض أن يكون هنا يوضح آلية  عمل التطبيق "
          "ويوضح المعنى المراد إيصاله والهدف المرجو تحقيقه  نموذج نص من المفترض أن يكون هنا يوضح "
          "آلية  عمل التطبيق ويوضح المعنى المراد إيصاله والهدف المرجو تحقيقه  نموذج نص من المفترض "
          "أن يكون هنا يوضح آلية  عمل التطبيق ويوضح المعنى المراد إيصاله والهدف المرجو تحقيقه "
          " نموذج نص من المفترض أن يكون هنا يوضح آلية  عمل التطبيق ويوضح المعنى المراد إيصاله"
          " والهدف المرجو تحقيقه المرجو تحقيقه   نموذج نص من المفترض أن يكون هنا يوضح آلية "
          " عمل التطبيق ويوضح المعنى المراد إيصاله والهدف المرجو تحقيقه المرجو تحقيقه ",
          FontWeight.w400,
          15,
          AppColors.hintGray,
          TextAlign.start),
      image: isProvider ? ServiceModel.getImageBg(service) : "",
      colors: isProvider
          ? ServiceModel.getImageColors(service)
          : [0xD437128D, 0xD49004B7],
    );
  }
}
