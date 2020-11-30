import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/model/order.dart';

import 'component/app_text.dart';
import 'container_with_title.dart';

class OrderDetailWidget extends StatelessWidget {
  final int textColor;
  final Order order;

  OrderDetailWidget(this.textColor, this.order);

  @override
  Widget build(BuildContext context) {
    return ContainerWithTitle(
        "service_detail",
        Container(
          padding: EdgeInsets.only(bottom: 12, left: 8, right: 8, top: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              order.serviceDetail == null
                  ? SizedBox.shrink()
                  : AppText(
                      order.serviceDetail.title,
                      FontWeight.w500,
                      15,
                      AppColors.hintGray,
                      TextAlign.start,
                    ),
              SizedBox(
                height: order.serviceDetail == null ? 0 : 7,
              ),
              order.serviceDetail == null
                  ? SizedBox.shrink()
                  : Divider(
                      height: 1,
                      color: Color(
                        AppColors.dividerGrayColor,
                      ).withOpacity(
                        0.15,
                      ),
                    ),
              SizedBox(
                height: 4,
              ),
              AppText(
                order.createdAt,
                FontWeight.w500,
                15,
                AppColors.hintGray,
                TextAlign.start,
              ),
              SizedBox(
                height: 7,
              ),
              Divider(
                height: 1,
                color: Color(
                  AppColors.dividerGrayColor,
                ).withOpacity(
                  0.15,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              order.city != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: AppText(
                            (order.city.name) +
                                (order.district == null ? "" : " - ") +
                                (order.district ?? "") +
                                (order.buildingNumber == null ? "" : " - ") +
                                (order.buildingNumber == null
                                    ? ""
                                    : (AppLocalization.of(context)
                                            .translate("building_number") +
                                        " " +
                                        order.buildingNumber)) +
                                (order.apartmentNumber == null ? "" : " - ") +
                                (order.apartmentNumber == null
                                    ? ""
                                    : (AppLocalization.of(context)
                                            .translate("apartment_number") +
                                        " " +
                                        order.apartmentNumber)) +
                                (order.apartmentNumber ?? ""),
                            FontWeight.w500,
                            13,
                            AppColors.hintGray,
                            TextAlign.start,
                          ),
                        ),
                        Icon(
                          Icons.room,
                          color: Color(AppColors.hintGray),
                          size: 17,
                        )
                      ],
                    )
                  : SizedBox.shrink(),
              SizedBox(
                height: 7,
              ),
              Divider(
                height: 1,
                color: Color(
                  AppColors.dividerGrayColor,
                ).withOpacity(
                  0.15,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              order.details == null
                  ? SizedBox.shrink()
                  : AppText(
                      order.details ?? "",
                      FontWeight.w500,
                      13,
                      AppColors.hintGray,
                      TextAlign.start,
                    ),
            ],
          ),
        ),
        textColor);
  }
}
