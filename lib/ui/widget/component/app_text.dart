import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:rayahhalekapp/helper/text_Style.dart';

class AppText extends StatelessWidget {
  final String text;
  final FontWeight weight;
  final double fontSize;
  final int color;
  final TextAlign align;

  AppText(this.text,this.weight,this.fontSize,this.color,this.align );


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      overflow: TextOverflow.visible,
      style:AppTextStyle(weight,fontSize,color).getTextStyle(),
    );
  }
}
