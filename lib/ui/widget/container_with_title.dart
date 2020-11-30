import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';

class ContainerWithTitle extends StatelessWidget {
  final Widget child;
  final String title;
  final int textColor;
  ContainerWithTitle(this.title, this.child,this.textColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: AppThemeData.serviceDetailBoxDecoration(
        borderRadius: 8,
        borderColor: AppColors.bgGrayColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsetsDirectional.only(
              start: 10,
              top: 5,
            ),
            width: MediaQuery.of(context).size.width,
            height: 31,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  5,
                ),
              ),
              color: Color(0xFFF7F8FA),
            ),
            child: AppText(
              AppLocalization.of(context).translate(title),
              FontWeight.w500,
              15,
              textColor,
              TextAlign.start,
            ),
          ),
          child
        ],
      ),
    );
  }
}
