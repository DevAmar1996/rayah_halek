import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:rayahhalekapp/api/api_request.dart';
import 'package:rayahhalekapp/helper/UtilSharedPreferences.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/model/user.dart';

class AuthClient {
  String code;

  Future<void> login(HashMap<String, String> params) async {
    try {
      var response = await ApiRequest.postData("login", params);
      handleUserInfo(response.body);
    } catch (err) {
      throw Exception(err);
    }
  }

  void handleUserInfo(String response) {
    Helper.user = User.fromJson(jsonDecode(response)["data"]);
    Helper.token = jsonDecode(response)["data"]["api_token"];
    print(Helper.token);
    Helper.isProvider = Helper.user.userTypeId == "2";
    Helper.service = ServiceModel.getService(Helper.user.serviceId);
    UtilSharedPreferences.setString("token", Helper.token);
    UtilSharedPreferences.setObj("user", Helper.user);
    UtilSharedPreferences.setBool("is_provider", Helper.isProvider);

  }

  Future<void> register(File file, HashMap<String, String> params) async {
    try {
      var response = await ApiRequest.uploadMulitpart(
          "register", [file], ["avatar"], params);
      print(response);
      handleUserInfo(response);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<String> forgetPassword(HashMap<String, String> params) async {
    try {
      var response = await ApiRequest.postData("password/code", params);
      print(response);
      print(jsonDecode(response.body)["data"]["code"].toString());
      code = jsonDecode(response.body)["data"]["code"].toString();
      return jsonDecode(response.body)["data"]["code"].toString();
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> resetPassword(HashMap<String, String> params) async {
    try {
      var response = await ApiRequest.postData("password/reset", params);
      print(response);
      return jsonDecode(response.body)["data"]["code"].toString();
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> verifyCode(HashMap<String, String> params) async {
    try {
      var response =
          await ApiRequest.postData("password/code/validate", params);
      print(response);
    } catch (err) {
      throw Exception(err);
    }
  }
}
