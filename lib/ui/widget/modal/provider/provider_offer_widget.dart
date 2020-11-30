import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/ui/widget/component/text_field.dart';
import 'package:rayahhalekapp/ui/widget/gradient_btn.dart';
import '../modal_header.dart';

class ProviderOfferWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _priceFocusNode = new FocusNode();
  final TextEditingController _price = new TextEditingController();

  ProviderOfferWidget();

  @override
  Widget build(BuildContext context) {
    return ModalHeader(
      GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppTextField(
                AppLocalization.of(context).translate("price"),
                TextInputType.number,
                _priceFocusNode,
                null,
                _price,
                "",
                isLight: true,
                height: 55,
                focusColor: ServiceModel.textColor(
                  Helper.service,
                ),
                textColor: ServiceModel.textColor(
                  Helper.service,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GradientButton(
                AppLocalization.of(context).translate("ok"),
                () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    Navigator.of(context).pop(_price.text);
                  }
                },
                ServiceModel.getButtonColors(
                  Helper.service,
                ),
              )
            ],
          ),
        ),
      ),
      "set_offer",
      270,
      textColor: ServiceModel.textColor(
        Helper.service,
      ),
    );
  }
}
