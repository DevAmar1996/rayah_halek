import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/ui/widget/component/radio_btn_with_text.dart';

import '../component/app_text.dart';
import '../gradient_btn.dart';

class OptionsWidget extends StatefulWidget {
  final List<String> options;
  final List<int> colors;
  final int textColor;
  final String title;
  final Function(int) next;

  OptionsWidget(
      this.options, this.textColor, this.colors, this.title, this.next);

  @override
  _OptionsWidgetState createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
  var selectedPosition = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 318,
      padding: EdgeInsetsDirectional.only(
        top: 15,
        start: 16,
        end: 16,
      ),
      decoration: AppThemeData.modalBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image(
              image: AssetImage(
                AppThemeData.imagePath + "close.png",
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Center(
            child: AppText(
              widget.title,
              FontWeight.w700,
              18,
              widget.textColor,
              TextAlign.center,
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Container(
            height: 75,
            child: ListView.builder(
              itemCount: widget.options.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        selectedPosition = index;
                      },
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: RadioButtonWithText(widget.textColor,
                        widget.options[index], selectedPosition == index),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 29,
          ),
          GradientButton(
            AppLocalization.of(context).translate("continue"),
            (){

              widget.next(selectedPosition);
            },
            widget.colors,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
