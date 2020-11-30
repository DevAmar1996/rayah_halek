import 'dart:collection';

import 'package:rayahhalekapp/api/app_api.dart';

class ForgetPasswordVm {
  final ForgetPasswordProtocol protocol;

  ForgetPasswordVm(this.protocol);

  void forgetPassword(String phone) async {
    HashMap<String, String> params = HashMap<String, String>();
    params["phone"] = phone;
    try {
      await AppApi.authClient.forgetPassword(params);
      protocol.didSuccess();
    } catch (err) {
      protocol.didFail(err.toString().replaceAll("Exception:", ""));
    }
  }
}

class ForgetPasswordProtocol {
  void didSuccess() {}

  void didFail(String message) {}
}
