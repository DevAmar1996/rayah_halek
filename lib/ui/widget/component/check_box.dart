import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/provider/checkBox_model.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';

class CheckBox extends StatefulWidget {
  final String text;

  CheckBox(this.text);

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool isSelected = false;
  var borderRadius = BorderRadius.all(
    Radius.circular(
      4,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          Provider.of<CheckBoxModel>(context,listen: false).change(isSelected);
        });
      },
      child: Row(
        children: <Widget>[
          Container(
            width: 21,
            height: 21,
            padding: EdgeInsets.all(
              3,
            ),
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(
                width: 1,
                color: Colors.white,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: isSelected ? Colors.white : Colors.transparent,
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Flexible(
            child: AppText(
              widget.text,
              FontWeight.w400,
              13,
              Colors.white.value,
              TextAlign.start,
            ),
          )
        ],
      ),
    );
  }
}
