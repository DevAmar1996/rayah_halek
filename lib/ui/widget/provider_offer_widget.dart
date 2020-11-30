import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/model/order.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/model/user.dart';
import 'package:rayahhalekapp/ui/screen/payment_screen.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/gradient_btn.dart';
import 'package:rayahhalekapp/ui/widget/provider_image.dart';

class ProviderOfferWidget extends StatefulWidget {
  final Order order;
  final User user;

  ProviderOfferWidget(this.order,this.user);

  @override
  _ProviderOfferWidgetState createState() => _ProviderOfferWidgetState();
}

class _ProviderOfferWidgetState extends State<ProviderOfferWidget> {
  Service service;
@override
  void initState() {
    super.initState();
    service = ServiceModel.getService(widget.order.serviceId);
  }
  @override
  Widget build(BuildContext context) {
//    return Material(
//      type: MaterialType.transparency,
//      child: Center(
//        child: Container(
//          height: 360,
//          width: MediaQuery.of(context).size.width * 0.7,
//          padding: EdgeInsets.only(left: 14, right: 14, top: 14),
//          decoration: AppThemeData.serviceDetailBoxDecoration(
//              borderRadius: 15, color: Colors.red.value),
////          child: Column(
////            children: [
////              Align(
////                alignment: AlignmentDirectional.topStart,
////                child: GestureDetector(
////                  onTap: () {
////                    Navigator.of(context).pop();
////                  },
////                  child: Image(
////                    image: AssetImage(
////                      AppThemeData.imagePath + "close.png",
////                    ),
////                  ),
////                ),
////              ),
////              SizedBox(
////                height: 8,
////              ),
////              Center(
////                child: ProviderImage(
////                  ServiceModel.textColor(service),
////                  path: Helper.imageUrl + widget.user.avatar,
////                ),
////              ),
////              SizedBox(
////                height: 3,
////              ),
////              AppText(
////                widget.user.name,
////                FontWeight.w700,
////                18,
////                ServiceModel.textColor(service),
////                TextAlign.center,
////              ),
////              SizedBox(
////                height: 3,
////              ),
////              AppText(
////                widget.user.phone,
////                FontWeight.w500,
////                15,
////                AppColors.hintGray,
////                TextAlign.center,
////              ),
////              SizedBox(
////                height: 12,
////              ),
////              Divider(
////                height: 1,
////                color: Color(AppColors.borderGray),
////              ),
////              SizedBox(
////                height: 12,
////              ),
////              AppText(
////                AppLocalization.of(context).translate("required_price"),
////                FontWeight.w700,
////                15,
////                AppColors.hintGray,
////                TextAlign.center,
////              ),
////              SizedBox(
////                height: 10,
////              ),
////              AppText(
////                widget.order.price + AppLocalization.of(context).translate("R.S"),
////                FontWeight.w700,
////                25,
////                ServiceModel.textColor(service),
////                TextAlign.center,
////              ),
////              SizedBox(
////                height: 23,
////              ),
////              Container(
////                decoration: BoxDecoration(
////                  boxShadow: [
////                    BoxShadow(
////                        color:
////                            Color(ServiceModel.getShadowColor(service))
////                                .withOpacity(0.2),
////                        blurRadius: 15),
////                  ],
////                ),
////                child: GradientButton(
////                  AppLocalization.of(context).translate("accept"),
////                  () {
////                    Navigator.of(context).push(MaterialPageRoute(
////                        builder: (context) => PaymentScreen(service)));
////                  },
////                  ServiceModel.getButtonColors(service),
////                ),
////              ),
////              SizedBox(
////                height: 15,
////              ),
////              Container(
////                padding: EdgeInsets.only(
////                  left: 4,
////                  right: 4,
////                ),
////                child: Row(
////                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                  children: [
////                    AppText(
////                      AppLocalization.of(context)
////                          .translate("another_provider2"),
////                      FontWeight.w600,
////                      15,
////                      AppColors.hintGray,
////                      TextAlign.start,
////                    ),
//////                  ),
//////                  FlatButton(
//////                    onPressed: () {},
////                    AppText(
////                      AppLocalization.of(context).translate("cancel"),
////                      FontWeight.w600,
////                      15,
////                      AppColors.hintGray,
////                      TextAlign.end,
//////                    ),
////                    ),
////                  ],
////                ),
////              )
////            ],
////          ),
//        ),
//      ),
//    );
  return Container(color: Colors.red,);
  }
}
