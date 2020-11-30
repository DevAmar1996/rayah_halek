import 'package:flutter/cupertino.dart';
import 'package:rayahhalekapp/helper/colors.dart';

class RadioButton extends StatelessWidget {
  final double size;
  final bool isSelected;
  final int activeColor;
  RadioButton(this.size,this.isSelected,this.activeColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Color(AppColors.borderGray), width: 1),
      ),
      child: isSelected
          ? Center(
        child: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(activeColor),
          ),
        ),
      )
          : SizedBox(),
    );
  }
}
