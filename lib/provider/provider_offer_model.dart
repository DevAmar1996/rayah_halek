import 'package:flutter/cupertino.dart';
import 'package:rayahhalekapp/model/order.dart';
import 'package:rayahhalekapp/model/user.dart';

class ProviderOfferModel extends ChangeNotifier {
  Order order;
  User user;

  void shouldDisplayOfferWidget( Order order,User user){
    this.order = order;
    this.user = user;
  }

}
