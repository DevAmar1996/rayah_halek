import 'package:flutter/cupertino.dart';

class LanguageModel extends ChangeNotifier{
  int selectedLanguage;



  void change(int selectedLanguage){
    this.selectedLanguage = selectedLanguage;
    notifyListeners();
  }

}