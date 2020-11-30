import 'dart:convert';

import 'package:rayahhalekapp/model/provider.dart';
import 'package:rayahhalekapp/model/service_data.dart';

import 'api_request.dart';

class ServiceClient {
  Future<List<ServiceData>> getServices(int id) async {
    try {
      var response = await ApiRequest.fetchData("services/$id");
      List<ServiceData> services = [];
      List data = jsonDecode(response.body)["data"];
      data.forEach((element) {
        services.add(ServiceData.fromJson(element));
      });
      return services;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<List<ProviderData>> getProviderList(int id) async {
    try {
      var response =
          await ApiRequest.fetchData("customer_service_providers/$id");
      List<ProviderData> providers = [];
      List data = jsonDecode(response.body)["data"];
      data.forEach((element) {
        providers.add(ProviderData.fromJson(element));
      });
      return providers;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<ProviderData> getNearProviderList(
      int id, int lat, int long, int num) async {
    try {
      var response = await ApiRequest.fetchData(
          "customer_service_provider/$id/$lat/$long/$num");
      return ProviderData.fromJson(jsonDecode(response.body)["data"]);
    } catch (err) {
      throw Exception(err);
    }
  }
}
