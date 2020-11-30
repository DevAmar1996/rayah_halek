import 'dart:collection';
import 'dart:convert';

import 'package:rayahhalekapp/model/app_config.dart';
import 'package:rayahhalekapp/model/city.dart';
import 'package:rayahhalekapp/model/notification.dart';

import 'api_request.dart';

class ConfigClient {
  AppConfig appConfig;

  Future<List<City>> getCities() async {
    try {
      var response = await ApiRequest.fetchData("cities");
      List<City> cities = [];
      List data = jsonDecode(response.body)["data"];
      data.forEach((element) {
        cities.add(City.fromJson(element));
      });
      return cities;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<List<AppNotification>> getNotification() async {
    try {
      var response =
          await ApiRequest.fetchData("notifications", isRequiredToken: true);
      List<AppNotification> notifications = [];
      List data = jsonDecode(response.body)["data"]["data"];
      data.forEach((element) {
        notifications.add(AppNotification.fromJson(element));
      });
      return notifications;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> contactUs(HashMap<String, String> params) async {
    try {
      var response = await ApiRequest.postData("contact_us", params,
          isRequiredToken: true);
      print(response);
      return;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<AppConfig> getAppConstants() async {
    try {
      if (appConfig == null) {
        var response =
            await ApiRequest.fetchData("constants", isRequiredToken: true);
        var data = jsonDecode(response.body)["data"];
        appConfig = AppConfig.fromJson(data);
        return appConfig;
      }
      return appConfig;
    } catch (err) {
      throw Exception(err);
    }
  }
}
