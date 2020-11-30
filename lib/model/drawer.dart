import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/UtilSharedPreferences.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/ui/screen/about_screen.dart';
import 'package:rayahhalekapp/ui/screen/call_us_screen.dart';
import 'package:rayahhalekapp/ui/screen/language_screen.dart';
import 'package:rayahhalekapp/ui/screen/login_screen.dart';
import 'package:rayahhalekapp/ui/screen/orders_screen.dart';
import 'package:rayahhalekapp/ui/screen/payment_way_screen.dart';
import 'package:rayahhalekapp/ui/screen/privacy_policy_screen.dart';
import 'package:rayahhalekapp/ui/screen/profile_screen.dart';
import 'package:rayahhalekapp/ui/screen/transaction_screen.dart';
import 'package:workmanager/workmanager.dart';

class DrawerModel {
  final bool isProvider = Helper.isProvider;

  final List<String> customerDrawers = [
    "home",
    "orders",
    "pays",
    "profile",
    "paying_method",
    "language",
    "about_app",
    "call_us",
    "privacy_policy",
    Helper.user == null ? "login" : "logout"
  ];
  List<String> providerDrawers = [
    "orders",
    "pays",
    "profile",
    "paying_method",
    "language",
    "about_app",
    "call_us",
    "privacy_policy",
    Helper.user == null ? "login" : "logout"
  ];

  List<String> providerImages = [
    AppThemeData.drawerImagePath + "orders.png",
    AppThemeData.drawerImagePath + "money.png",
    AppThemeData.drawerImagePath + "profile.png",
    AppThemeData.drawerImagePath + "payment_card.png",
    AppThemeData.drawerImagePath + "language.png",
    AppThemeData.drawerImagePath + "about_app.png",
    AppThemeData.drawerImagePath + "call_us.png",
    AppThemeData.drawerImagePath + "privacy_policy.png",
    AppThemeData.drawerImagePath + "logout.png",
  ];

  final List<String> images = [
    AppThemeData.drawerImagePath + "home_app.png",
    AppThemeData.drawerImagePath + "orders.png",
    AppThemeData.drawerImagePath + "money.png",
    AppThemeData.drawerImagePath + "profile.png",
    AppThemeData.drawerImagePath + "payment_card.png",
    AppThemeData.drawerImagePath + "language.png",
    AppThemeData.drawerImagePath + "about_app.png",
    AppThemeData.drawerImagePath + "call_us.png",
    AppThemeData.drawerImagePath + "privacy_policy.png",
    AppThemeData.drawerImagePath + "logout.png",
  ];

  int getDrawerCount() {
    return isProvider ? customerDrawers.length - 1 : customerDrawers.length;
  }

  String getName(int index) {
    return isProvider ? providerDrawers[index] : customerDrawers[index];
  }

  String getIcon(int index) {
    return isProvider ? providerImages[index] : images[index];
  }

  Function() getAction(int index, BuildContext context) {
    Widget screen;
    if (index == 0) {
      return () {
        Navigator.of(context).pop();
      };
    }
    switch (index) {
      case 1:
        screen = isProvider ? TransactionScreen() : OrderScreen();
        break;
      case 2:
        screen = isProvider ? ProfileScreen() : TransactionScreen();
        break;
      case 3:
        screen = isProvider ? PaymentWayScreen() : ProfileScreen();
        break;
      case 4:
        screen = isProvider ? LanguageScreen() : PaymentWayScreen();
        break;

      case 5:
        screen = isProvider ? AboutAppScreen() : LanguageScreen();
        break;
      case 6:
        screen = isProvider ? CallUsScreen() : AboutAppScreen();
        break;
      case 7:
        screen = isProvider ? PrivacyPolicyScreen() : CallUsScreen();
        break;

      case 8:
        screen = isProvider ? LoginScreen() : PrivacyPolicyScreen();
        break;
      case 9:
        screen = LoginScreen();
        break;
    }
    return () {
      if ((index == 8 && isProvider || index == 9 ) && Helper.user != null) {
        UtilSharedPreferences.clear();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => screen),
            ModalRoute.withName("/"));
        Workmanager.cancelAll();


      }else{
        print(index);
        if((index == 1 || index == 2 || index == 3||index == 6) && Helper.user == null){
          AppThemeData.showLoginDialog(context);
        }else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => screen));
        }
        Workmanager.cancelAll();
      }
    };
  }
}
