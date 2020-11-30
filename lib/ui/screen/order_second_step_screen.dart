import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/model/service_data.dart';
import 'package:rayahhalekapp/provider/attachment_model.dart';
import 'package:rayahhalekapp/provider/order_detail_model.dart';
import 'package:rayahhalekapp/provider/picker_model.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/component/error_dialog.dart';
import 'package:rayahhalekapp/ui/widget/header_widget.dart';
import 'package:rayahhalekapp/ui/widget/service_detail_widget.dart';
import 'package:rayahhalekapp/ui/widget/service_prick_attacment_widget.dart';
import 'package:rayahhalekapp/ui/widget/time_date_widget.dart';
import 'package:rayahhalekapp/vm/order_second_step_vm.dart';

class OrderSecondStepScreen extends StatefulWidget {
  final Service service;
  final ServiceData serviceData;

  OrderSecondStepScreen(this.service,this.serviceData);

  @override
  _OrderSecondStepScreenState createState() => _OrderSecondStepScreenState();
}

class _OrderSecondStepScreenState extends State<OrderSecondStepScreen> {
  var selectedDateType = -1;
  var selectedDate = "";
  String detail = "";
  ServiceDetailWidget serviceDetailWidget;

  OrderSecondStepVm _orderSecondStepVm;
  List<File> files = [];

  void iniVm() {
    _orderSecondStepVm = OrderSecondStepVm();
  }

  @override
  void initState() {
    super.initState();
    serviceDetailWidget = ServiceDetailWidget(
      ServiceModel.textColor(widget.service),
    );
    iniVm();
  }

  @override
  Widget build(BuildContext context) {
    return HeaderWidget(
      "order_detail",
      16,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.service != Service.JOKER
              ? Row(
                  children: <Widget>[
                    Image.network(
                      Helper.imageUrl +  widget.serviceData.image,
                      color: Color(
                        ServiceModel.textColor(widget.service),
                      ),
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    AppText(
                      widget.serviceData.title,
                      FontWeight.w800,
                      18,
                      ServiceModel.textColor(widget.service),
                      TextAlign.start,
                    ),
                  ],
                )
              : SizedBox.shrink(),
          widget.service != Service.JOKER
              ? SizedBox(
                  height: 13.5,
                )
              : SizedBox.shrink(),
          widget.service != Service.JOKER
              ? Divider(
                  height: 1,
                  color: Color(
                    AppColors.borderGray,
                  ),
                )
              : SizedBox.shrink(),
          Consumer<PickerModel>(
            builder: (context, model, child) {
              selectedDateType = model.timeType ?? -1;
              selectedDate = model.time ?? "";
              return TimeAndDateWidget(
                  ServiceModel.textColor(widget.service),
                  ServiceModel.getButtonColors(widget.service),
                  model.timeType == 2,
                  model.timeType == 1,
                  selectedDate);
            },
          ),
          widget.service != Service.BARBER ? Consumer<OrderDetailModel>(
            builder: (context, model, child) {
              detail = model.detail ?? "";
              serviceDetailWidget.detail = detail;
              return serviceDetailWidget;
            },
          ) : SizedBox.shrink(),
          widget.service != Service.BARBER ? Consumer<AttachmentModel>(
            builder: (context, model, child) {
              files = model.file;
              return ServicePickAttachmentWidget(
                ServiceModel.textColor(widget.service),
              );
            },
          ) : SizedBox.shrink()
        ],
      ),
      action: () {
        if (selectedDateType == -1 ||
            (selectedDateType == 2 && selectedDate == "")) {
          AppDialog.showMe(
              context, AppLocalization.of(context).translate("time_err"));
          return;
        }
        _orderSecondStepVm.save(selectedDateType, selectedDate, detail, files);
        ServiceModel.whatToDoAfterDetail(widget.service, context)();
      },
      isScroll: true,
      image: ServiceModel.getImageBg(widget.service),
      haveButton: true,
      buttonColors: ServiceModel.getButtonColors(widget.service),
      buttonText: "continue",
      colors: ServiceModel.getImageColors(widget.service),
    );
  }
}
