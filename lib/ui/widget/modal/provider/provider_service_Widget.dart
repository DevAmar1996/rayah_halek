import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/provider/picker_model.dart';
import 'package:rayahhalekapp/ui/widget/component/radio_btn_with_img.dart';
import 'package:rayahhalekapp/ui/widget/gradient_btn.dart';
import 'package:rayahhalekapp/ui/widget/modal/modal_header.dart';

class ProviderService extends StatefulWidget {
  final int lastSelectedPosition ;
  ProviderService(this.lastSelectedPosition);
  @override
  _ProviderServiceState createState() => _ProviderServiceState();
}

class _ProviderServiceState extends State<ProviderService> {
  List<Service> services = [
    Service.FIX_HOME,
    Service.BARBER,
    Service.CAR_WATCH,
    Service.JOKER,
  ];
  var selectedPosition = -2;

  @override
  void initState() {
    super.initState();
    selectedPosition  = widget.lastSelectedPosition;
  }

  @override
  Widget build(BuildContext context) {
    return ModalHeader(
      Column(
        children: List.generate(
          5,
          (index) {
            return index < services.length
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPosition = index;
                        if (selectedPosition == 0)
                          Helper.service = Service.FIX_HOME;
                        else if (selectedPosition == 1)
                          Helper.service = Service.CAR_WATCH;
                        else if (selectedPosition == 2)
                          Helper.service = Service.BARBER;
                        else if (selectedPosition == 3)
                          Helper.service = Service.BARBER;
                      });
                    },
                    child: Container(
                      padding: EdgeInsetsDirectional.only(
                        end: 20,
                        start: 10,
                      ),
                      margin: EdgeInsets.only(bottom: 16),
                      child: RadioButtonWithImage(
                          ServiceModel.getImage(
                            services[index],
                          ),
                          ServiceModel.getTitle(
                            services[index],
                          ),
                          ServiceModel.billColor(
                            services[index],
                          ),
                          selectedPosition == index),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 16),
                    child: GradientButton(
                      AppLocalization.of(context).translate("ok"),
                      () {
                        Provider.of<PickerModel>(context, listen: false)
                            .changeService(selectedPosition + 1,selectedPosition >= 0 ? ServiceModel.getTitle(
                          services[selectedPosition],
                        ): "");
                        Navigator.of(context).pop();
                      },
                      [
                        (AppColors.purpleTextColor),
                        (AppColors.purpleTextColor2),
                      ],
                    ),
                  );
          },
        ),
      ),
      "which_service_you_provide",
      1000,
    );
  }
}
