import 'package:flutter/cupertino.dart';

class CheckBoxModel extends ChangeNotifier {
  bool isSelected;

  void change(bool isSelected) {
    this.isSelected = isSelected;
    notifyListeners();
  }

  void removeAll(){
    this.isSelected = null;
    notifyListeners();

  }
}
