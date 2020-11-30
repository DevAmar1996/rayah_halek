import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/ui/screen/service_first_step_screen.dart';
import 'package:rayahhalekapp/ui/widget/auth_bg.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/service_widget.dart';

import 'order_second_step_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  var services = [
    Service.FIX_HOME,
    Service.BARBER,
    Service.CAR_WATCH,
    Service.JOKER
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          AuthBg(
            Container(
              width: MediaQuery.of(context).size.width,
              height: 312,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: AppBar().preferredSize.height + 40.2,
                left: 16,
                right: 16,
                bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppText(
                  AppLocalization.of(context)
                      .translate("choose_your_service"),
                  FontWeight.w400,
                  25,
                  Colors.white.value,
                  TextAlign.start,
                ),
                SizedBox(
                  height: 16,
                ),
                AppText(
                  AppLocalization.of(context).translate("sample"),
                  FontWeight.w500,
                  15,
                  Colors.white.value,
                  TextAlign.start,
                ),
                SizedBox(
                  height: 28,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        15,
                      ),
                    ),
                    child: Container(
                      height: 342,
                      width: 342,
//                    padding: EdgeInsets.only(bottom: 10),
                      margin: EdgeInsets.only(bottom: 10),
                      color: Colors.transparent,
                      child: Center(
                        child: GridView.count(
                          padding: EdgeInsets.all(0),
                          crossAxisCount: 2,
                          mainAxisSpacing: 17,
                          crossAxisSpacing: 17,
                          shrinkWrap: true,
                          childAspectRatio: 1,
                          physics: new NeverScrollableScrollPhysics(),
                          children: List.generate(4, (index) {
                            return GestureDetector(
                              onTap: () {
                                if (index != 3)
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ServiceFirstStepScreen(
                                                  services[index])));
//                                else
//                                  Navigator.of(context).push(
//                                      MaterialPageRoute(
//                                          builder: (context) =>
//                                              OrderSecondStepScreen(
//                                                  services[index])));
                              },
                              child: ServiceWidget(
                                ServiceModel.getColor(services[index]),
                                AppLocalization.of(context).translate(
                                    ServiceModel.getTitle(services[index])),
                                ServiceModel.getImage(
                                  services[index],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 17,
                ),
                AuthBg(
                  Container(
                    padding: EdgeInsetsDirectional.only(
                      start: 22,
                      bottom: 18,
                    ),
                    alignment: AlignmentDirectional.bottomStart,
                    height: MediaQuery.of(context).size.height * 0.21,
                    child: AppText(
                      AppLocalization.of(context)
                          .translate("special_service"),
                      FontWeight.w400,
                      15,
                      Colors.white.value,
                      TextAlign.start,
                    ),
                  ),
                  image: "home_feature_bg.png",
                  borderRadius: 15,
                  colors: [0x789004B7, 0x7836128C],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
