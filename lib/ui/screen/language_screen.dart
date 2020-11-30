import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/helper/UtilSharedPreferences.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/provider/language_model.dart';
import 'package:rayahhalekapp/ui/widget/header_widget.dart';
import 'package:rayahhalekapp/ui/widget/component/radio_btn_with_text.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final List<String> titles = ["اللغة العربية", "English"];
  final bool isProvider = Helper.isProvider;
  final Service service = Helper.service;
  var selectedPosition = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(UtilSharedPreferences.getInt("selected_language") == null){
      selectedPosition = 0;
    }else{
      selectedPosition =  UtilSharedPreferences.getInt("selected_language");
    }
  }
  @override
  Widget build(BuildContext context) {
    return HeaderWidget(
      "language",
      16,
      Column(
        children: List.generate(
          2,
          (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedPosition = index;
                });
              },
              child: Container(
                height: 103,
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsetsDirectional.only(start: 16),
                decoration: AppThemeData.serviceDetailBoxDecoration(),
                child: RadioButtonWithText(
                  isProvider
                      ? ServiceModel.textColor(service)
                      : AppColors.purpleTextColor,
                  titles[index],
                  index == selectedPosition,
                  fontSize: 18,
                  size: 31,
                ),
              ),
            );
          },
        ),
      ),
      haveButton: true,
      action: () {
        if(selectedPosition != -1){
          UtilSharedPreferences.setInt("selected_language", selectedPosition);
          Provider.of<LanguageModel>(context,listen: false).change(selectedPosition);
        }
        Navigator.of(context).pop();
      },
      buttonText: "change_language",
      buttonColors: isProvider
          ? ServiceModel.getButtonColors(Helper.service)
          : [
              (AppColors.purpleTextColor),
              (AppColors.purpleTextColor2),
            ],
      image: isProvider ? ServiceModel.getImageBg(service) : "",
      colors: isProvider
          ? ServiceModel.getImageColors(service)
          : [0xD437128D, 0xD49004B7],
    );
  }
}
