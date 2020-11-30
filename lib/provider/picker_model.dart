import 'package:flutter/cupertino.dart';

class PickerModel extends ChangeNotifier {
  int timeType;
  String time;

  int serviceSelectedId;
  String serviceName;

  void changeService(int id, String serviceName) {
    this.serviceSelectedId = id;
    this.serviceName = serviceName;
    notifyListeners();
  }

  void changeTimeType(int timeType) {
    this.timeType = timeType;
    notifyListeners();
  }

  void changeTime(String time) {
    this.time = time;
    notifyListeners();
  }

  void removeAll() {
    timeType = null;
    time = null;

    serviceSelectedId = null;
    serviceName = null;
  }
}
