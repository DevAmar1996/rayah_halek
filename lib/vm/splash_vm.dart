
import 'package:rayahhalekapp/api/app_api.dart';
import 'package:rayahhalekapp/helper/helper.dart';

class SplashVm {
//  void backgroundFetchHeadlessTask(String taskId) async {
//    print('[BackgroundFetch] Headless event received.');
//    BackgroundFetch.finish(taskId);
//  }

  Future<void> getUserInfo() async {
    if (Helper.token == null) {
      return;
    }
    try {
      await AppApi.userClient.getUserInfo();
      return;
    }catch(err){
      throw Exception(err);
    }
  }


}
