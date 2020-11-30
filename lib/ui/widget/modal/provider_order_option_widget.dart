import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/model/service.dart';

import 'package:rayahhalekapp/ui/widget/component/error_dialog.dart';
import 'package:rayahhalekapp/ui/widget/modal/options_widget.dart';

class ProviderOrderOptionWidget extends StatelessWidget {
  final Service service;

  ProviderOrderOptionWidget(this.service);

  @override
  Widget build(BuildContext context) {
    return OptionsWidget(
      [
        AppLocalization.of(context).translate("search_for_near_one"),
        AppLocalization.of(context).translate("choose_one")
      ],
      ServiceModel.textColor(service),
      ServiceModel.getButtonColors(service),
      AppLocalization.of(context).translate("way_to_choose_provides"),
      (index) {
        if(index == -1){
          AppDialog.showMe(context, AppLocalization.of(context).translate("provider_display_err"));
          return;
        }
        Navigator.of(context).pushNamed(
            index == 0 ? "/provider_map" : "/provider_list",
            arguments: service);
      },
    );
  }
}
