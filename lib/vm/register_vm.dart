import 'dart:collection';
import 'dart:io';

import 'package:rayahhalekapp/api/app_api.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/model/city.dart';

class RegisterVM {
  RegisterProtocol protocol;

  RegisterVM(this.protocol);

  void register(String phone, String password,String name,String address, File avatar, int cityId,
      int serviceId) async {
    HashMap<String, String> params = HashMap<String, String>();
    params["phone"] = phone;
    params["password"] = password;
    params["name"] = name;
    params["city_id"] = cityId.toString();
    params["password_confirmation"] = password;
    params["user_type"] = (Helper.isProvider ? 2 : 3).toString();
    params["address"] = address;
    if (Helper.isProvider) {
      params["service_id"] = serviceId.toString();
    }
    try {
      await AppApi.authClient.register(avatar, params);
      protocol.didRegisterSuccess();
    } catch (err) {
      protocol.didRegisterFail(err.toString().replaceAll("Exception:", ""));
    }
  }

  void getCities() async {
    var cities = await AppApi.configClient.getCities();
    protocol.didLoadCitiesSuccess(cities);
  }
}

class RegisterProtocol {
  void didRegisterSuccess() {}

  void didLoadCitiesSuccess(List<City> cities) {}

  void didRegisterFail(String message) {}
}
