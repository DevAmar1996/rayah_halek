import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/ui/widget/component/solid_button.dart';

import '../../gradient_btn.dart';

class ProviderLastWidget extends StatelessWidget {
  final String status;
  final String price;
  final int shadowColor;
  final List<int> colors;
  final Function() makeOffer;
  final  Function() rejectOrder;
  final Function() completeOrder;

  ProviderLastWidget(this.status,this.price, this.shadowColor, this.colors, this.makeOffer,
      this.rejectOrder, this.completeOrder);

  @override
  Widget build(BuildContext context) {
    return status == "2" && price == null
        ? Column(
            children: [
              containerWithShadow(
                GradientButton(
                  AppLocalization.of(context).translate("make_offer"),
                  makeOffer,
                  this.colors,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SolidButton("reject_order", rejectOrder)
            ],
          )
        : SizedBox();
  }

  Container containerWithShadow(Widget child) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Color(shadowColor).withOpacity(0.2), blurRadius: 15)
        ],
      ),
      child: child,
    );
  }
}
