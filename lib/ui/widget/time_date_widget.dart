import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/provider/picker_model.dart';
import 'package:rayahhalekapp/ui/widget/pick_date_widget.dart';
import 'package:rayahhalekapp/ui/widget/component/radio_btn_with_text.dart';

import 'component/app_text.dart';

class TimeAndDateWidget extends StatefulWidget {
  final int textColor;
  final List<int> colors;
  final bool isLater;
  final bool isNow;
  final String date;

  TimeAndDateWidget(
      this.textColor, this.colors, this.isLater, this.isNow, this.date);

  @override
  _TimeAndDateWidgetState createState() => _TimeAndDateWidgetState();
}

class _TimeAndDateWidgetState extends State<TimeAndDateWidget> {
  var isNow = false;
  var isLater = false;
  var selectedDate = "";

  @override
  void initState() {
    super.initState();
    isLater = widget.isLater ?? false;
    isNow = widget.isNow ?? false;
    selectedDate = widget.date ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 7.5,
        ),
        AppText(
          AppLocalization.of(context).translate("service_time_date"),
          FontWeight.w500,
          15,
          widget.textColor,
          TextAlign.start,
        ),
        SizedBox(
          height: 15,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isNow = !isNow;
              isLater = isNow ? false : isLater;
              Provider.of<PickerModel>(context, listen: false)
                  .changeTimeType(isLater ? 2 : (isNow ? 1 : -1));
            });
          },
          child: RadioButtonWithText(widget.textColor,
              AppLocalization.of(context).translate("now"), isNow),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
//                            crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLater = !isLater;
                      isNow = isLater ? false : isNow;
                      Provider.of<PickerModel>(context, listen: false)
                          .changeTimeType(isLater ? 2 : (isNow ? 1 : -1));
                    });
                  },
                  child: RadioButtonWithText(
                    widget.textColor,
                    AppLocalization.of(context).translate("later"),
                    isLater,
                  ),
                ),
                SizedBox(
                  height: (isLater && selectedDate != "") ? 8 : 0,
                ),
                (isLater && selectedDate != "")
                    ? AppText(
                        selectedDate,
                        FontWeight.w500,
                        11,
                        AppColors.hintGray,
                        TextAlign.center,
                      )
                    : SizedBox()
              ],
            ),
            isLater
                ? GestureDetector(
                    onTap: () async {
                      String date = await showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              PickDateWidget(widget.textColor, widget.colors));
                      setState(() {
                        selectedDate = date != null ? date : "";
                        Provider.of<PickerModel>(context, listen: false)
                            .changeTime(selectedDate);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      height: 48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          border: Border.all(color: Color(widget.textColor))),
                      child: Center(
                        child: AppText(
                          AppLocalization.of(context)
                              .translate("enter_date_time"),
                          FontWeight.w500,
                          13,
                          widget.textColor,
                          TextAlign.center,
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
        SizedBox(
          height: 14,
        ),
        Divider(
          height: 1,
          color: Color(
            AppColors.borderGray,
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
