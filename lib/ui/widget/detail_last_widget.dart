import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/ui/widget/component/solid_button.dart';
import 'package:rayahhalekapp/vm/order_detail_vm.dart';

import 'component/app_text.dart';
import 'gradient_btn.dart';

class DetailLastWidget extends StatelessWidget {
  final String status;
  final String price;
  final List<int> colors;
  final Function() cancel;
  final Function() complete;
  final Function() acceptOffer;

  DetailLastWidget(
      this.status, this.price, this.colors, this.cancel, this.complete,this.acceptOffer);

  @override
  Widget build(BuildContext context) {
    if (price == null) {
      return SolidButton("cancel_order", cancel);
    } else if (status == "2" && price != null) {
      return GradientButton(
        AppLocalization.of(context).translate("accept_offer"),
        acceptOffer,
        this.colors,
      );
    }if (status == "3") {
      return GradientButton(
        AppLocalization.of(context).translate("order_completed"),
        complete,
        this.colors,
      );
    }
    return SizedBox();
  }
}
