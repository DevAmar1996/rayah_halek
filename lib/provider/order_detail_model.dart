import 'package:flutter/material.dart';

class OrderDetailModel extends ChangeNotifier {
  String detail;

  void changeDetail(String detail) {
    this.detail = detail;
    notifyListeners();
  }
  void removeAll(){
    this.detail = null;
    notifyListeners();

  }
}
