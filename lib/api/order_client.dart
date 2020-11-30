import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:rayahhalekapp/model/order.dart';

import 'api_request.dart';

class OrderClient {
  HashMap<String, String> params = HashMap<String, String>();
  List<File> files = [];

  int customerNextPage = 1;
  bool customerCanPaginate = true;
  bool providerCanPaginate = true;
  int providerNextPage = 1;

  Future<void> storeOrder() async {
    try {
      List<String> keys = [];
      var i = 1;
      files.forEach((element) {
        keys.add("attachments[$i]");
        i += 1;
      });
      if (params["service_id"] == null) {
        params["service_id"] = 4.toString();
      }
      print(files.length);
      print("Fuck");
      var response = await ApiRequest.uploadMulitpart(
          "store_order", files, keys, params,
          isRequiredToken: true);

      print(response);
      return;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<List<Order>> getOrders(int position,bool isPaging) async {
    try {
      List<Order> orders = [];
      int  page =  isPaging ? customerNextPage + 1 : 1;
      customerNextPage = page;
      var response = await ApiRequest.fetchData("customer/orders/$position?page=$page",
          isRequiredToken: true);
      List data = jsonDecode(response.body)["data"]["data"];
      data.forEach((element) {
        orders.add(Order.fromJson(element));
      });
//      print( jsonDecode(response.body)["data"]["next_page_url"] != null);
      customerCanPaginate = jsonDecode(response.body)["data"]["next_page_url"] != null;
      print(response);
      return orders;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<List<Order>> getProviderOrders(int position,bool isPaging) async {
    try {
      List<Order> orders = [];
      int  page =  isPaging ? providerNextPage + 1 : 1;
      providerNextPage = page;
      var response = await ApiRequest.fetchData("provider/orders/$position?page=$page",
          isRequiredToken: true);
      List data = jsonDecode(response.body)["data"]["data"];
      data.forEach((element) {
        orders.add(Order.fromJson(element));
      });
      print(response);
      providerCanPaginate = jsonDecode(response.body)["data"]["next_page_url"] != null;
      return orders;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<Order> getOrder(int id) async {
    try {
      var response =
          await ApiRequest.fetchData("order_by_id/$id", isRequiredToken: true);
      return Order.fromJson(jsonDecode(response.body)["data"]);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> cancelOrder(HashMap<String, String> params) async {
    try {
      await ApiRequest.postData("customer_cancel_order", params,
          isRequiredToken: true);
      return;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> customerAcceptProviderOffer(HashMap<String, String> params) async {
    try {
      await ApiRequest.postData("customer_accept_order", params,
          isRequiredToken: true);
      return;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> rejectOrder(HashMap<String, String> params) async {
    try {
      await ApiRequest.postData("provider_cancel_order", params,
          isRequiredToken: true);
      return;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> addOffer(HashMap<String, String> params) async {
    try {
      await ApiRequest.postData("order_offer", params, isRequiredToken: true);
      return;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> completeOrder(HashMap<String, String> params) async {
    try {
      await ApiRequest.postData("customer_finish_order", params,
          isRequiredToken: true);
      return;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> changeProvider(HashMap<String, String> params) async {
    try {
      await ApiRequest.postData("change_provider", params,
          isRequiredToken: true);
      return;
    } catch (err) {
      throw Exception(err);
    }
  }
}
