import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/model/notification.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/ui/widget/header_widget.dart';
import 'package:rayahhalekapp/ui/widget/list_item/notification_item_widget.dart';
import 'package:rayahhalekapp/vm/notification_vm.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationVm _notificationVm = NotificationVm();
  final isProvider = Helper.isProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HeaderWidget(
      "notifications",
      22,
      Container(
        height: 20,
        child: FutureBuilder(
            future: _notificationVm.getNotification(),
            builder: (context, snapshot) {
              var notifications = snapshot.data;
              return notifications != null
                  ? ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return NotificationItemWidget(notifications[index]);
                      },
                    )
                  : Center(child: CircularProgressIndicator());
            }),
      ),
      image: isProvider ? ServiceModel.getImageBg(Helper.service) : "",
      colors: isProvider
          ? ServiceModel.getImageColors(Helper.service)
          : [0xD437128D, 0xD49004B7],
    );
  }
}
