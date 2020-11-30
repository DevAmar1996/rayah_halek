import 'dart:collection';

import 'package:rayahhalekapp/api/app_api.dart';
import 'package:rayahhalekapp/model/order.dart';

class ProviderOrderVm {
  List<List<Order>> orders = [null, null, null];

  Future<List<Order>> getOrders(int position, {bool isRefresh = false,bool isPagination = false}) async {
    List<Order> orders;
    if (this.orders[position - 1] != null && !isRefresh && !isPagination) {
      return this.orders[position - 1];
    }
    orders = await AppApi.orderClient.getProviderOrders(position,isPagination);
    if(isPagination){
      this.orders[position - 1].addAll(orders);
    }else{
      AppApi.orderClient.providerNextPage = 1;
      this.orders[position - 1] = orders;
    }
//    this.orders[position - 1] = orders;
    return orders;
  }

  void cancelOrder(Order order) {
    if (orders[0] != null) {
      orders[0].remove(order);
    }
    if (orders[2] != null) {
      orders[2].add(order);
    }
  }

  void completeOrder(Order order) {
    if (orders[1] != null) {
      orders[1].remove(order);
    }
    if (orders[2] != null) {
      orders[2].add(order);
    }
  }

  void initService() async {

  }



}
