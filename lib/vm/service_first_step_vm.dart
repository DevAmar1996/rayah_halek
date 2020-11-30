import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/api/app_api.dart';
import 'package:rayahhalekapp/model/service_data.dart';
import 'package:rayahhalekapp/provider/checkBox_model.dart';
import 'package:rayahhalekapp/provider/city_model.dart';
import 'package:rayahhalekapp/provider/option_model.dart';
import 'package:rayahhalekapp/provider/order_detail_model.dart';
import 'package:rayahhalekapp/provider/picker_model.dart';

class ServiceFirstStepVM {

  ServiceFirstStepProtocol protocol;
  ServiceFirstStepVM(this.protocol);
  void getServices(int id) async {
    try {
     var list =  await AppApi.serviceClient.getServices(id);
     protocol.didLoadServices(list);
    }catch(err){
      print(err);
    }
  }

  void saveData(String serviceId ,int serviceDetailId,int selectedPosition){
    AppApi.orderClient.params["service_id"] = serviceId;
    AppApi.orderClient.params["service_details_id"] = serviceDetailId.toString();
  }


  void clearData(BuildContext context){
    AppApi.orderClient.params.clear();
    Provider.of<CityModel>(context,listen: false).removeAll();
    Provider.of<OptionModel>(context,listen: false).removeAll();
    Provider.of<CheckBoxModel>(context,listen: false).removeAll();
    Provider.of<OrderDetailModel>(context,listen: false).removeAll();
    Provider.of<PickerModel>(context,listen: false).removeAll();
  }
}

class  ServiceFirstStepProtocol {
  void didLoadServices(List<ServiceData> services){}
}