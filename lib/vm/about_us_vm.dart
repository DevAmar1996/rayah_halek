import 'package:rayahhalekapp/api/app_api.dart';
import 'package:rayahhalekapp/model/app_config.dart';

class AboutUsViewModel {
  AppConfig appConfig;


  void getAppConfig() async{
    try {
      appConfig =  await AppApi.configClient.getAppConstants();
      print(appConfig);
    }catch(err){
      print(err);
    }
  }
}