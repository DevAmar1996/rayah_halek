import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/theme.dart';

import 'component/app_text.dart';
import 'auth_bg.dart';
import 'gradient_btn.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final double padding;
  final bool haveButton;
  final Widget content;
  final List<int> buttonColors;
  final String buttonText;
  final bool isScroll;
  final Function action;
  final String image;
  final List<int> colors;
  final bool showBackButton;
  final bool containFliterIcon;

  HeaderWidget(
    this.title,
    this.padding,
    this.content, {
    this.haveButton = false,
    this.buttonColors,
    this.buttonText = "",
    this.action,
    this.isScroll = false,
    this.image = "",
    this.colors = const [0xD437128D, 0xD49004B7],
    this.showBackButton = true,
    this.containFliterIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(
        AppColors.lightGrayBg,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: !isScroll
            ? NeverScrollableScrollPhysics()
            : AlwaysScrollableScrollPhysics(),
        child: Stack(
          children: [
            AuthBg(
              Container(
                height: 312,
              ),
              image: image,
              colors: colors,
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              padding: EdgeInsets.all(
                20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  !showBackButton
                      ? SizedBox(
                          height: 20,
                        )
                      : SizedBox.shrink(),
                  Row(
                    children: <Widget>[
                      showBackButton
                          ? GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        width: 2,
                      ),
                      AppText(
                        AppLocalization.of(context).translate(title),
                        FontWeight.w800,
                        25,
                        Colors.white.value,
                        TextAlign.center,
                      ),
//                      containFliterIcon
//                          ? Image(
//                              image: AssetImage(
//                                AppThemeData.imagePath + "filter.png",
//                              ),
//                              width: 27,
//                              height: 18,
//                            )
//                          : SizedBox.shrink()
                    ],
                  ),
                  SizedBox(
                    height: 26,
                  ),
//                  isScroll
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          (haveButton ? (32 + 48) : 0) -
                          142,
                    ),
                    child: IntrinsicHeight(
                      child: Container(
                        decoration: AppThemeData.roundedBoxWithShadow(),
                        padding: EdgeInsets.all(padding),
                        child: content,
                      ),
                    ),
                  ),
//                      : Expanded(
//                          child: Container(
//                            decoration: AppThemeData.roundedBoxWithShadow(),
//                            padding: EdgeInsets.all(padding),
//                            child: content,
//                          ),
//                        ),
                  haveButton
                      ? SizedBox(
                          height: 16,
                        )
                      : SizedBox.shrink(),
                  haveButton
                      ? Container(
//                          padding: EdgeInsetsDirectional.only(
//                            end: 16,
//                            start: 16,
//                          ),
                          child: GradientButton(
                              AppLocalization.of(context).translate(buttonText),
                              () {
                            action();
                          }, buttonColors),
                        )
                      : SizedBox.shrink(),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
