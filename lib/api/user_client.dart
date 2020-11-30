import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:rayahhalekapp/api/api_request.dart';
import 'package:rayahhalekapp/helper/UtilSharedPreferences.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/model/notifiy_app.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/model/user.dart';

class UserClient {
  Future<void> updateCustomer(File file, HashMap<String, String> params) async {
    try {
      if (file == null) {
        var response = await ApiRequest.postData("update_profile", params,
            isRequiredToken: true);
        handleUserInfo(response.body);
      } else {
        var response = await ApiRequest.uploadMulitpart(
            "update_profile", [file], ["avatar"], params,
            isRequiredToken: true);
        handleUserInfo(response);
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> getUserInfo() async {
    try {
      var response = await ApiRequest.fetchData("user", isRequiredToken: true);
      handleUserInfo(response.body);
      return;
    } catch (err) {
      UtilSharedPreferences.clear();
    }
  }

  Future<void> updateLocation(HashMap<String, String> params,String token) async {
    try {
        print("I am  updateLocation");
        var response = await ApiRequest.postData(
            "update_provider_location",params,
            isRequiredToken: true,token: token);
        print("back service  $response");
        return;
    } catch (err) {
      print("back err  $err");
    }
  }



  Future<List<Notify>> checkNotify(String token) async{
    print("I am checkNotify");
    var response = await ApiRequest.fetchData(
        "check_notify",
        isRequiredToken: true,token: token);
    print("back service checkNotify");
    print(response.body);
    List<Notify> notifies = List<Notify>();
    List data = jsonDecode(response.body)["data"];
    data.forEach((element) {
      notifies.add(Notify.fromJson(element));
    });
    return notifies;
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
}
