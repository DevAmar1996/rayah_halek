import 'package:flutter/cupertino.dart';
import 'package:rayahhalekapp/model/order.dart';

class OrderModel extends ChangeNotifier {
   Order cancelOrder;
   Order completedOrder;
   Order activatedOrder;
   Order changedProviderOrder;


   void didCancel( Order order){
     this.cancelOrder = order;
     notifyListeners();
   }
   void didComplete( Order order){
     this.completedOrder = order;
     notifyListeners();
   }
   void didActive( Order order){
     this.activatedOrder = order;
     notifyListeners();
   }
   void changeProvider( Order order){
     this.changedProviderOrder = order;
     notifyListeners();
   }
}