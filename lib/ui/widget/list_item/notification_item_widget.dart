import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/model/notification.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';

class NotificationItemWidget extends StatelessWidget {
  final AppNotification notification;

  NotificationItemWidget(this.notification);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 101,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Icon(
                Icons.notifications_none,
                color:Color(notification.order != null ? ServiceModel.billColor(ServiceModel.getService(notification.order.serviceId)) : AppColors.purpleColor),
                size: 33,
              ),
              Image(
                image: AssetImage(AppThemeData.imagePath + "bell.png"),
                width: 37,
                height: 11.41,
              ),
            ],
          ),
          SizedBox(
            width: 17.5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                     notification.title,
                      FontWeight.w700,
                      15,
                      notification.order != null
                          ? ServiceModel.billColor(
                          ServiceModel.getService(notification.order.serviceId))
                          : AppColors.purpleColor,
                      TextAlign.center,
                    ),
                    AppText(
                      notification?.createdAt,
                      FontWeight.w300,
                      11,
                      AppColors.grayTextColor,
                      TextAlign.end,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 54,
                  child: AppText(
                  notification.message,
                    FontWeight.w300,
                    12,
                    AppColors.textGrayColor,
                    TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                Divider(
                  height: 1,
                  color: Color(AppColors.borderGray),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
