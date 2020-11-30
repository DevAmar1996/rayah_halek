import 'package:flutter/cupertino.dart';
import 'package:rayahhalekapp/model/user.dart';

class UserModel extends ChangeNotifier {
  User user;

  void changeUser(User user){
    this.user = user;
    notifyListeners();
  }
}