import 'dart:collection';

import 'package:provider/provider.dart';
import 'package:rayahhalekapp/api/app_api.dart';
import 'package:rayahhalekapp/model/order.dart';
import 'package:rayahhalekapp/provider/order_model.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailVm {
  Future<Order> getOrderDetails(int id) async {
    try {
      var order = await AppApi.orderClient.getOrder(id);
      return order;
    } catch (err) {
      print(err);
      return null;
    }

  }

  Future<void> cancelOrder(int id) async {
    try {
      HashMap<String, String> map = HashMap<String, String>();
      map["order_id"] = id.toString();
      await AppApi.orderClient.cancelOrder(map);
      return;
    } catch (err) {
      print(err);
    }
  }

  Future<void> rejectOrder(int id) async {
    try {
      HashMap<String, String> map = HashMap<String, String>();
      map["order_id"] = id.toString();
      print(id);
      await AppApi.orderClient.rejectOrder(map);
      return;
    } catch (err) {
      print(err);
    }
  }

  Future<void> completeOrder(int id) async {
    try {
      HashMap<String, String> map = HashMap<String, String>();
      map["order_id"] = id.toString();
      await AppApi.orderClient.completeOrder(map);
      return;
    } catch (err) {
      print(err);
    }
  }

  Future<void> acceptOffer(int id) async {
    try {
      HashMap<String, String> map = HashMap<String, String>();
      map["order_id"] = id.toString();
      await AppApi.orderClient.customerAcceptProviderOffer(map);
      return;
    } catch (err) {
      print(err);
    }
  }

  Future<void> addOffer(int id, String price) async {
    try {
      HashMap<String, String> map = HashMap<String, String>();
      map["order_id"] = id.toString();
      map["price"] = price;
      await AppApi.orderClient.addOffer(map);
      return;
    } catch (err) {
      print(err);
    }
  }

  Future<void> changeProvider(int id, int providerId) async {
    try {
      HashMap<String, String> map = HashMap<String, String>();
      map["order_id"] = id.toString();
      map["provider_id"] = providerId.toString();
      print(map);
      await AppApi.orderClient.changeProvider(map);
      return;
    } catch (err) {
      print(err);
    }
  }

  launchCaller(String phone) async {
    const url = "tel:1234567";
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
