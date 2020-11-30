import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/model/order.dart';
import 'package:rayahhalekapp/model/provider.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/model/user.dart';
import 'package:rayahhalekapp/provider/order_model.dart';
import 'package:rayahhalekapp/ui/screen/order_details_screen.dart';
import 'package:rayahhalekapp/ui/screen/provider_list_screen.dart';
import 'package:rayahhalekapp/ui/widget/component/CustomProgressDialog.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/component/error_dialog.dart';
import 'package:rayahhalekapp/ui/widget/confirm_alert.dart';
import 'package:rayahhalekapp/ui/widget/container_with_title.dart';
import 'package:rayahhalekapp/ui/widget/detail_last_widget.dart';
import 'package:rayahhalekapp/ui/widget/order_provider_info.dart';
import 'package:rayahhalekapp/vm/order_detail_vm.dart';

class CustomerOrderDetailsScreen extends StatefulWidget {
  final int section;
  final int orderId;

  CustomerOrderDetailsScreen(this.section, this.orderId);

  @override
  _CustomerOrderDetailsScreenState createState() =>
      _CustomerOrderDetailsScreenState();
}

class _CustomerOrderDetailsScreenState
    extends State<CustomerOrderDetailsScreen> {
  OrderDetailVm _orderDetailVm;
  Service service;
  CustomProgressDialog pr;

  void initVm() {
    _orderDetailVm = OrderDetailVm();
  }

  @override
  void initState() {
    super.initState();
    initVm();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _orderDetailVm.getOrderDetails(widget.orderId),
      builder: (context, snapshot) {
        Order order = snapshot.data;
        print(order);
        if (order != null) {
          service = ServiceModel.getService(order.serviceId);
        }
        return OrderDetailsScreen(
          widget.section,
          service,
          OrderUserDetailWidget(
            AppColors.purpleTextColor,
            ServiceModel.textColor(service),
            AppColors.purpleTextColor,
            order?.provider,
            () {
              _orderDetailVm.launchCaller(order.provider.phone);
            },
          ),
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
                    child: order?.status != "1" && order != null
                        ? AppText(
                            order?.price == null
                                ? AppLocalization.of(context)
                                .translate("not_priced")
                                : ((order?.price ?? " ") +
                                    " " +
                                    AppLocalization.of(context)
                                        .translate("R.s")),
                            FontWeight.w500,
                            order?.price == null ? 13 : 20,
                            AppColors.hintGray,
                            TextAlign.start,
                          )
                        : AppText(
                            AppLocalization.of(context)
                                .translate("provider_reject_order"),
                            FontWeight.w500,
                            13,
                            AppColors.hintGray,
                            TextAlign.start,
                          ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  order?.status == "2" || order?.status == "1"
                      ? GestureDetector(
                          onTap: () async {
                            ProviderData provider =
                                await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProviderListScreen(
                                  isForChange: true,
                                  service:
                                      ServiceModel.getService(order.serviceId),
                                ),
                              ),
                            );
                            if (provider != null) {
                              pr = CustomProgressDialog(context, "", () {});
                              await pr.showDialog();
                              try {
                                await _orderDetailVm.changeProvider(
                                    order.id, provider.id);
                                pr.hideDialog();
                                setState(() {
                                  order.provider =
                                      User.fromJson(provider.toJson());
                                });
                                Provider.of<OrderModel>(context,listen: false).changeProvider(order);
                              } catch (err) {
                                pr.hideDialog();
                                AppDialog.showMe(
                                    context,
                                    err
                                        .toString()
                                        .replaceAll("Exception:", ""));
                              }
                            }
                          },
                          child: AppText(
                            AppLocalization.of(context)
                                .translate("search_for_another_provider"),
                            FontWeight.w500,
                            13,
                            AppColors.purpleTextColor,
                            TextAlign.end,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            AppColors.purpleTextColor,
          ),
          DetailLastWidget(
              order?.status, order?.price, ServiceModel.getButtonColors(service),
              () {
            ConfirmAlert.showMe(
              context,
              AppLocalization.of(context).translate("cancel_order_confirm"),
              () {
                cancelOrder(context, order);
              },
            );
          }, () {
            completeOrder(context, order);
          },(){
            acceptOffer(context, order);
          }),
          snapshot.data as Order,
          buttonColors: [
            0xFF9004B7,
            0xFF36128C,
          ],
          bgColors: [0xD437128D, 0xD49004B7],
          textColor: 0xFF9004B7,
          image: "",
        );
      },
    );
  }

  Future cancelOrder(BuildContext context, Order order) async {
    Navigator.of(context).pop();
    pr = CustomProgressDialog(context, "", () {});
    await pr.showDialog();
    await _orderDetailVm.cancelOrder(widget.orderId);
    Provider.of<OrderModel>(context, listen: false).didCancel(order);
    pr.hideDialog();
    AppDialog.showMe(
        context, AppLocalization.of(context).translate("cancel_success"),
        isError: false, onClickOk: () {
      Navigator.of(context).pop(2);
    });
  }

  Future completeOrder(BuildContext context, Order order) async {
    pr = CustomProgressDialog(context, "", () {});
    await pr.showDialog();
    await _orderDetailVm.completeOrder(widget.orderId);
    Provider.of<OrderModel>(context, listen: false).didComplete(order);
    pr.hideDialog();
    AppDialog.showMe(context, AppLocalization.of(context).translate("complete_success"),isError: false,onClickOk: (){
      Navigator.of(context).pop(2);
    });
  }
  Future acceptOffer(BuildContext context, Order order) async {
    pr = CustomProgressDialog(context, "", () {});
    await pr.showDialog();
    await _orderDetailVm.acceptOffer(widget.orderId);
    Provider.of<OrderModel>(context, listen: false).didActive(order);
    pr.hideDialog();
    AppDialog.showMe(context, AppLocalization.of(context).translate("offer_accept_success"),isError: false,onClickOk: (){
      Navigator.of(context).pop(1);
    });
  }
}
