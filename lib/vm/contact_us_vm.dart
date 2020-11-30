import 'dart:collection';

import 'package:rayahhalekapp/api/app_api.dart';

class ContactUsViewModel {

  Future<void> contactUs(String title , String message)async{
    HashMap<String,String> map = HashMap<String,String>();
    map["title"] = title;
    map["message"] = message;
    try {
      await AppApi.configClient.contactUs(map);
    }catch(err){

      throw(err);
    }
  }
}