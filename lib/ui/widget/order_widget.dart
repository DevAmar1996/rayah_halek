import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/model/order.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/ui/screen/customer_orders_detail_screen.dart';
import 'package:rayahhalekapp/ui/screen/provider/provider_order_detail_screen.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/gradient_btn.dart';
import 'package:rayahhalekapp/ui/widget/user_image.dart';

class OrderWidget extends StatelessWidget {
  final Order order;
  final int section;
  final bool isProvider;
  final Function(int) moveTo;

  Service service;

  OrderWidget(this.order, this.section, {this.isProvider = false,this.moveTo}) {
    this.service = ServiceModel.getService(this.order.serviceId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      decoration: AppThemeData.serviceDetailBoxDecoration(
        borderRadius: 8,
        borderColor: AppColors.bgGrayColor,
      ),
      child: Column(
        children: [
          isProvider
              ? SizedBox.shrink()
              : Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(AppColors.bgGrayColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        8,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        color: Color(ServiceModel.textColor(service)),
                        image: AssetImage(
                          AppThemeData.imagePath +
                              ServiceModel.getImage(service),
                        ),
                        width: 23.5,
                        height: 23.5,
                      ),
                      SizedBox(
                        width: 13.44,
                      ),
                      AppText(
                        AppLocalization.of(context)
                            .translate(ServiceModel.getTitle(service)),
                        FontWeight.w700,
                        15,
                        ServiceModel.textColor(service),
                        TextAlign.center,
                      ),
                    ],
                  ),
                ),
          SizedBox(
            height: 9,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 7,
              right: 7,
            ),
            child: Column(
              children: [
                service != Service.JOKER
                    ? Row(
                        children: [
                          Icon(
                            Icons.image,
                            color: Color(ServiceModel.textColor(service)),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          AppText(
                            order.serviceDetail.title,
                            FontWeight.w800,
                            15,
                            AppColors.hintGray,
                            TextAlign.start,
                          )
                        ],
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: service != Service.JOKER ? 9 : 0,
                ),
                service != Service.JOKER
                    ? Divider(
                        height: 1,
                        color: Color(
                          AppColors.dividerGrayColor,
                        ).withOpacity(
                          0.15,
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: service != Service.JOKER ? 9 : 0,
                ),
                order?.provider != null ?   Row(
                  children: [
                    UserImage(
                      21,
                      21,
                      (order?.provider?.avatar  == null  ? ""  : ( Helper.imageUrl + order?.provider?.avatar ?? "")),
                      color: ServiceModel.textColor(
                        service,
                      ),
                      padding: 1,
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    AppText(
                      order.provider?.name ?? "",
                      FontWeight.w500,
                      15,
                      AppColors.hintGray,
                      TextAlign.start,
                    )
                  ],
                ) : SizedBox.shrink(),
                SizedBox(
                  height:  order?.provider != null ? 9 : 0,
                ),
                order?.provider != null ?   Divider(
                  height: 1,
                  color: Color(
                    AppColors.dividerGrayColor,
                  ).withOpacity(
                    0.15,
                  ),
                ) : SizedBox.shrink(),
                SizedBox(
                  height: 9,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Color(
                        ServiceModel.textColor(service),
                      ),
                      size: 21,
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    AppText(
                      order.createdAt,
                      FontWeight.w500,
                      15,
                      AppColors.hintGray,
                      TextAlign.start,
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          GradientButton(
            AppLocalization.of(context).translate("order_detail"),
            () async{
           int page = await  Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => isProvider
                      ? ProviderOrderDetailScreen(section, order.id)
                      : CustomerOrderDetailsScreen(section, order.id),
                ),
              );
             print(page);
             this.moveTo(page);
            },
            ServiceModel.getButtonColors(service),
            height: 40,
          )
        ],
      ),
    );
  }
}
