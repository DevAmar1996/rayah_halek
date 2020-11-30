import 'package:flutter/cupertino.dart';

class CityModel extends ChangeNotifier {
  int id;
  int index;

  void change(int id, int index) {
    this.id = id;
    this.index = index;

    notifyListeners();
  }

  void removeAll(){
    this.id = null;
    this.index = null;
    notifyListeners();

  }
}
