import 'dart:collection';

import 'package:rayahhalekapp/api/app_api.dart';

class ResetPasswordVm {
  final ResetPasswordProtocol protocol;

  ResetPasswordVm(this.protocol);

  void resetPassword(String phone,String code,String password) async {
    HashMap<String, String> params = HashMap<String, String>();
    print(code);
    print(phone);
    params["phone"] = phone;
    params["code"] = code;
    params["password"] = password;
    params["password_confirmation"] = password;
    try {
      await AppApi.authClient.resetPassword(params);
      protocol.didSuccess();
    } catch (err) {
      protocol.didFail(err.toString().replaceAll("Exception:", ""));
    }
  }
}

class ResetPasswordProtocol {
  void didSuccess() {}

  void didFail(String message) {}
}
