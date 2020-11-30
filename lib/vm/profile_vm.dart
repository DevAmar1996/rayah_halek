import 'dart:collection';
import 'dart:io';

import 'package:rayahhalekapp/api/app_api.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/model/city.dart';

class ProfileVm {
  Future<void> updateProfile(String phone, String name, String address,
      File avatar, int cityId, int serviceId) async {
    HashMap<String, String> params = HashMap<String, String>();
    params["phone"] = phone ?? Helper.user.phone;
    params["name"] = name?? Helper.user.name;;
    params["city_id"] = cityId != -1 ? cityId.toString() : Helper.user.cityId;

    params["address"] = address ?? Helper.user.address;
    if (Helper.isProvider) {
      params["service_id"] = serviceId.toString();
    }
    print(params);
    try {
      await AppApi.userClient.updateCustomer(avatar, params);
      return null;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<List<City>> getCities() async {
    var cities = await AppApi.configClient.getCities();
    return cities;
  }
}
