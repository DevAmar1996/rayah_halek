import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';

class ServiceWidget extends StatelessWidget {
  final int color;
  final String name;
  final String icon;

  ServiceWidget(this.color, this.name, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10,
      ),
      decoration: AppThemeData.roundedBoxWithShadow(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
//              width: 64,
//              height: 64,
              image: AssetImage(AppThemeData.imagePath + icon),
            ),
            SizedBox(
              height: 16,
            ),
            AppText(
              name,
              FontWeight.w700,
              20,
              color,
              TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
