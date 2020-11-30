import 'dart:collection';

import 'package:rayahhalekapp/api/app_api.dart';

class LoginVM {
  LoginProtocol protocol;

  LoginVM(this.protocol);

  void login(String phone, String password) async {
    HashMap<String, String> params = HashMap<String, String>();
    params["phone"] = phone;
    params["password"] = password;
    try {
      await AppApi.authClient.login(params);
      protocol.didLoginSuccess();
    } catch (err) {
      protocol.didLoginFail(err.toString().replaceAll("Exception:", ""));
    }
  }
}

class LoginProtocol {
  void didLoginSuccess() {}

  void didLoginFail(String message) {}
}
