import 'package:flutter/cupertino.dart';

class OptionModel extends ChangeNotifier{
  int selectedPosition;



  void change(int position){
    this.selectedPosition = selectedPosition;
    notifyListeners();
  }

  void removeAll(){
    this.selectedPosition = null;
    notifyListeners();

  }

}