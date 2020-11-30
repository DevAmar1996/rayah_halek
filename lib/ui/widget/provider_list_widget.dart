import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';

class ProviderListWidget extends StatelessWidget {
  final int textColor;
  final bool isSelected;

  final String name;

  ProviderListWidget(this.textColor, this.isSelected, this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppThemeData.serviceDetailBoxDecoration(
          borderRadius: 8,
          borderColor: isSelected ? textColor : AppColors.borderGray),
      padding: EdgeInsetsDirectional.only(
        start: 13,
      ),
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            name,
            FontWeight.w400,
            15,
            isSelected ? textColor : AppColors.hintGray,
            TextAlign.start,
          ),
          isSelected
              ? Container(
                  margin: EdgeInsetsDirectional.only(
                    end: 16,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 20,
                    color: Color(0xFF37B476),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
