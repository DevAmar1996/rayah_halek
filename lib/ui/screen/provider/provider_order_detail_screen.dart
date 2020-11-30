import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/model/order.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/provider/order_model.dart';
import 'package:rayahhalekapp/ui/screen/order_details_screen.dart';
import 'package:rayahhalekapp/ui/widget/component/CustomProgressDialog.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/component/error_dialog.dart';
import 'package:rayahhalekapp/ui/widget/component/text_field.dart';
import 'package:rayahhalekapp/ui/widget/container_with_title.dart';
import 'package:rayahhalekapp/ui/widget/modal/provider/provider_last_widget.dart';
import 'package:rayahhalekapp/ui/widget/modal/provider/provider_offer_widget.dart';
import 'package:rayahhalekapp/ui/widget/order_provider_info.dart';
import 'package:rayahhalekapp/vm/order_detail_vm.dart';

class ProviderOrderDetailScreen extends StatefulWidget {
  final int section;

  final int orderId;

  ProviderOrderDetailScreen(this.section, this.orderId);

  @override
  _ProviderOrderDetailScreenState createState() =>
      _ProviderOrderDetailScreenState();
}

class _ProviderOrderDetailScreenState extends State<ProviderOrderDetailScreen> {
  Order order;
  OrderDetailVm _orderDetailVm;
  Service service;
  CustomProgressDialog pr;
  FocusNode priceFocusNode = FocusNode();

  TextEditingController _price = TextEditingController();

  void initVm() {
    _orderDetailVm = OrderDetailVm();
  }

  @override
  void initState() {
    super.initState();
    initVm();
  }

  String enteredPrice;

  var price;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _orderDetailVm.getOrderDetails(widget.orderId),
      builder: (context, snapshot) {
        Order order = snapshot.data;
        if (order != null) {
          service = ServiceModel.getService(order.serviceId);
          print(order.price);
          price = order.price;
        }
        return OrderDetailsScreen(
          widget.section,
          service,
          OrderUserDetailWidget(
              AppColors.hintGray,
              ServiceModel.textColor(Helper.service),
              0xFF008200,
              order?.provider,
              () {}),
          Column(
            children: [
              ContainerWithTitle(
                "service_price",
                Container(
                  height: 62,
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
//                          child: AppText(
//                            price == null
//                                ? (enteredPrice == null
//                                    ? AppLocalization.of(context)
//                                        .translate("enter_price")
//                                    : (enteredPrice.toString() +
//                                        " " +
//                                        AppLocalization.of(context)
//                                            .translate("R.s")))
//                                : (price +
//                                    " " +
//                                    AppLocalization.of(context)
//                                        .translate("R.s")),
//                            FontWeight.w500,
//                            widget.section == 0 ? 13 : 20,
//                            AppColors.hintGray,
//                            TextAlign.start,
//                          ),

                          child: Container(
                        width: 200,
                        child: AppTextField(
                          price == null
                              ? AppLocalization.of(context)
                                  .translate("enter_price")
                              : "",
                          TextInputType.number,
                          priceFocusNode,
                          null,
                          price == null ? _price : null,
                          "",
                          textColor: AppColors.purpleColor,
                          isCenter: true,
                          isEnabled: price == null,
                          initialText: price != null
                              ? (price +
                                  " " +
                                  AppLocalization.of(context).translate("R.s"))
                              : null,
                        ),
                      )),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
                AppColors.hintGray,
              ),
              SizedBox(
                height: 14,
              ),
//              widget.section == 0
//                  ? SizedBox.shrink()
//                  : Row(
//                      children: [
//                        Icon(
//                          Icons.check,
//                          color: Color(0xFF37B476),
//                          size: 16,
//                        ),
//                        SizedBox(
//                          width: 18,
//                        ),
//                        AppText(
//                          AppLocalization.of(context).translate("priced"),
//                          FontWeight.w500,
//                          14,
//                          0xFF37B476,
//                          TextAlign.start,
//                        ),
//                      ],
//                    ),
            ],
          ),
          order?.status != "5"
              ? ProviderLastWidget(
                  order?.status,
                  order?.price,
                  ServiceModel.textColor(service),
                  ServiceModel.getButtonColors(service), () async {
                  bool added = await addOffer();
                  if (added) {
                    setState(() {
                      price = enteredPrice;
                    });
                  }
                }, () {
                  rejectOrder(order);
                }, () {})
              : SizedBox.shrink(),
          order,
          buttonColors: ServiceModel.getButtonColors(Helper.service),
          image: ServiceModel.getImageBg(Helper.service),
          bgColors: ServiceModel.getImageColors(Helper.service),
          textColor: AppColors.hintGray,
        );
      },
    );
  }

  Future<void> setupPreRequestRequirement(bool shouldPop) async {
    if (shouldPop) Navigator.of(context).pop();
    pr = CustomProgressDialog(context, "", () {});
    await pr.showDialog();
    return;
  }

  Future<bool> addOffer() async {
    try {
      if (_price.text == "") {
        AppDialog.showMe(
          context,
          AppLocalization.of(context).translate("enter_offer_price"),
        );
        return false;
      }
      await setupPreRequestRequirement(false);
      await _orderDetailVm.addOffer(widget.orderId, enteredPrice);
      pr.hideDialog();
      AppDialog.showMe(
          context, AppLocalization.of(context).translate("offer_add_success"),
          isError: false);

      return true;
    } catch (err) {
      pr.hideDialog();
      AppDialog.showMe(context, err.toString().replaceAll("Exception:", ""));
      return false;
    }
  }

  Future rejectOrder(Order order) async {
    pr = CustomProgressDialog(context, "", () {});
    await pr.showDialog();
    await _orderDetailVm.rejectOrder(widget.orderId);
    Provider.of<OrderModel>(context, listen: false).didCancel(order);
    pr.hideDialog();
    AppDialog.showMe(
        context, AppLocalization.of(context).translate("reject_success"),
        isError: false, onClickOk: () {
      Navigator.of(context).pop(2);
    });
  }

//  Future completeOrder(Order order) async {
//    pr = CustomProgressDialog(context, "", () {});
//    await pr.showDialog();
//    await _orderDetailVm.rejectOrder(widget.orderId);
//    Provider.of<OrderModel>(context, listen: false).didComplete(order);
//    pr.hideDialog();
//    Navigator.of(context).pop();
//  }
}
