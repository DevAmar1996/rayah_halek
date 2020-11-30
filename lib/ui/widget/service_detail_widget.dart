import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/provider/order_detail_model.dart';

import 'package:rayahhalekapp/ui/widget/component/text_field.dart';

import 'component/app_text.dart';

class ServiceDetailWidget extends StatefulWidget {
  final int textColor;
  String detail;

  ServiceDetailWidget(this.textColor);

  @override
  _ServiceDetailWidgetState createState() => _ServiceDetailWidgetState();
}

class _ServiceDetailWidgetState extends State<ServiceDetailWidget> {
  FocusNode _detailFocusNode = new FocusNode();

  TextEditingController _detail = new TextEditingController();


  @override
  void initState() {
    super.initState();
    _detail.text = widget.detail;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppText(
            AppLocalization.of(context).translate("service_detail"),
            FontWeight.w500,
            15,
            widget.textColor,
            TextAlign.start,
          ),
          SizedBox(
            height: 10,
          ),
          AppTextField(
            AppLocalization.of(context).translate("details_hint"),
            TextInputType.text,
            _detailFocusNode,
            null,
            _detail,
            AppLocalization.of(context).translate("details_required"),
            isLight: true,
            height: 140,
            focusColor: widget.textColor,
            isMultiLine: true,
            textColor: widget.textColor,
            onChange: (_) {
              Provider.of<OrderDetailModel>(context, listen: false)
                  .changeDetail(_detail.text);
            },
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
