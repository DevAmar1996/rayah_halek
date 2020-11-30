import 'package:geolocator/geolocator.dart';
import 'package:rayahhalekapp/api/app_api.dart';
import 'package:rayahhalekapp/model/provider.dart';
import 'package:rayahhalekapp/provider/checkBox_model.dart';
import 'package:rayahhalekapp/provider/city_model.dart';
import 'package:rayahhalekapp/provider/option_model.dart';
import 'package:rayahhalekapp/provider/order_detail_model.dart';
import 'package:rayahhalekapp/provider/picker_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProviderListVm {
  ProviderListProtocol protocol;

  ProviderListVm(this.protocol);

  int number = 1;

  void getProvider(int serviceId) async {
    var cities = await AppApi.serviceClient.getProviderList(serviceId);
    protocol.didLoadProviderSuccess(cities);
  }

  void getNearProvider(int serviceId) async {
    var position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    try {
      var provider = await AppApi.serviceClient.getNearProviderList(serviceId,
          position.latitude.round(), position.longitude.round(), number);
      number += 1;
      protocol.nearProvider(provider);
    } catch (err) {
        protocol.didFail(err.toString().replaceAll("Exception:", ""));
    }
  }

  void sendOrder(int id) async {
    AppApi.orderClient.params["provider_id"] = id.toString();
    print(AppApi.orderClient.params);
    try {
      await AppApi.orderClient.storeOrder();
      AppApi.orderClient.params.clear();
      protocol.didSendOrderSuccess();
    } catch (err) {
      protocol.didFail(err.toString().replaceAll("Exception:", ""));
    }
  }

  void clearData(BuildContext context) {
    AppApi.orderClient.params.clear();
    Provider.of<CityModel>(context, listen: false).removeAll();
    Provider.of<OptionModel>(context, listen: false).removeAll();
    Provider.of<CheckBoxModel>(context, listen: false).removeAll();
    Provider.of<OrderDetailModel>(context, listen: false).removeAll();
    Provider.of<PickerModel>(context, listen: false).removeAll();
  }
}

class ProviderListProtocol {
  void didLoadProviderSuccess(List<ProviderData> providers) {}

  void didSendOrderSuccess() {}

  void didFail(String err) {}

  void mustLogin() {}

  void nearProvider(ProviderData provider) {}
}
