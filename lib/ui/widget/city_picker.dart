import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/model/city.dart';
import 'package:rayahhalekapp/provider/city_model.dart';
import 'package:rayahhalekapp/provider/picker_model.dart';

import 'component/app_text.dart';
import 'component/picker_text_field.dart';

class CityPicker extends StatefulWidget {
  final List<City> cities;
  final int borderColor;
  final int borderWidth;
  final double height;
  final int textColor;
  final int hintColor;
  final int selectedIndex;
  final String initText;
  final bool isEditable;

  CityPicker(this.cities, this.selectedIndex, this.hintColor,
      {this.borderColor = 0xFFFFFFFF,
      this.borderWidth = 0,
      this.height = 48,
      this.textColor = 0xFFFFFFFF,
      this.initText = "",
      this.isEditable = true,});

  @override
  _CityPickerState createState() => _CityPickerState();
}

class _CityPickerState extends State<CityPicker> {
  var initText = "";
  var selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    print(widget.selectedIndex);
    selectedIndex = widget.selectedIndex;
    initText = widget.initText;
  }

  @override
  Widget build(BuildContext context) {
    print(selectedIndex);
    if (initText == "")
      initText = selectedIndex != -1 && widget.cities != null
          ? widget.cities[selectedIndex].name
          : "";
    return PickerTextField(
      widget.isEditable ? doAction : (){},
      initText == "" || initText == null
          ? AppLocalization.of(context).translate("city")
          : initText,
      widget.cities != null,
      borderColor: widget.borderColor,
      borderWidth: widget.borderWidth,
      height: widget.height,
      textColor: initText == "" ? widget.hintColor : widget.textColor,
    );
  }

  void doAction() async {
    if (widget.cities != null) {
      int _selectedItemIndex = selectedIndex == -1 ? 0 : selectedIndex;
      final FixedExtentScrollController scrollController =
          new FixedExtentScrollController(initialItem: _selectedItemIndex);
      var text = await showModalBottomSheet(
        context: context,
        builder: (context) => ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8), topLeft: Radius.circular(8)),
          child: Container(
            height: 200,
            child: Column(
              children: [
                Container(
                  height: 40,
                  padding: EdgeInsetsDirectional.only(
                    start: 10,
                    end: 10,
                  ),
                  color: CupertinoColors.white,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          print(selectedIndex);
                          if (selectedIndex == -1) {
                            selectedIndex = 0;
                          }
                          print(selectedIndex);
                          Navigator.of(context)
                              .pop(widget.cities[selectedIndex].name);
                          Provider.of<CityModel>(context, listen: false).change(
                              widget.cities[selectedIndex].id, selectedIndex);
                        },
                        child: AppText(
                          "إختر",
                          FontWeight.w300,
                          18,
                          AppColors.purpleColor,
                          TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Color(
                    AppColors.bgGrayColor,
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    scrollController: scrollController,
                    itemExtent: 40,
                    magnification: 1.0,
                    squeeze: 1.2,
                    backgroundColor: CupertinoColors.white,
                    onSelectedItemChanged: (index) {
                      selectedIndex = index;
                    },
                    children: List.generate(widget.cities.length, (index) {
                      return Container(
                        height: 120,
                        child: Center(
                          child: AppText(
                            widget.cities[index].name,
                            FontWeight.w500,
                            17,
                            AppColors.purpleTextColor,
                            TextAlign.center,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      setState(
        () {
          Provider.of<CityModel>(context, listen: false)
              .change(widget.cities[selectedIndex].id, selectedIndex);
          initText = text;
        },
      );
    }
  }
}
