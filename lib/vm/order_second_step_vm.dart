

import 'dart:io';

import 'package:rayahhalekapp/api/app_api.dart';


class OrderSecondStepVm {
  void save(int timeType, String time, String details, List<File> files) {
    AppApi.orderClient.files = files;
    AppApi.orderClient.params["service_date_type"] = timeType.toString();
    AppApi.orderClient.params["service_date"] = time;
    AppApi.orderClient.params["details"] = details;
  }


}
