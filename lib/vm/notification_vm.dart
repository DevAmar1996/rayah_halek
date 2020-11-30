import 'package:rayahhalekapp/api/app_api.dart';
import 'package:rayahhalekapp/model/notification.dart';

class NotificationVm {
  Future<List<AppNotification>> getNotification() async {
    try {
      var notifications = await AppApi.configClient.getNotification();
      return notifications;
    }catch(err){
      print(err);
    }
  }
}