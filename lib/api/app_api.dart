import 'package:rayahhalekapp/api/auth_client.dart';
import 'package:rayahhalekapp/api/config_client.dart';
import 'package:rayahhalekapp/api/order_client.dart';
import 'package:rayahhalekapp/api/service_client.dart';
import 'package:rayahhalekapp/api/user_client.dart';

class AppApi {
  static AuthClient authClient = AuthClient();
  static ConfigClient configClient = ConfigClient();
  static ServiceClient serviceClient = ServiceClient();
  static OrderClient orderClient = OrderClient();
  static UserClient userClient = UserClient();
}
