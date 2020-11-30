import 'dart:collection';

import 'package:rayahhalekapp/api/app_api.dart';

class VerifyPasswordVM {

  VerifyPasswordProtocol protocol;
  VerifyPasswordVM(this.protocol);


  void verifyCode(String phone,String code) async {
    HashMap<String, String> params = HashMap<String, String>();
    params["phone"] = phone;
    params["code"] = code;

    try {
      await AppApi.authClient.verifyCode(params);
      protocol.didSuccess();
    } catch (err) {
      protocol.didFail(err.toString().replaceAll("Exception:", ""));
    }
  }

  Future resetCode(String phone)  async {
    HashMap<String, String> params = HashMap<String, String>();
    params["phone"] = phone;

    try {
      await AppApi.authClient.forgetPassword(params);
      return;
    } catch (err) {
      protocol.didFail(err.toString().replaceAll("Exception:", ""));
    }
  }
}

class VerifyPasswordProtocol {
  void didSuccess() {}

  void didFail(String message) {}
}