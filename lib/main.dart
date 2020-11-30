import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/api/app_api.dart';
import 'package:rayahhalekapp/provider/attachment_model.dart';
import 'package:rayahhalekapp/provider/checkBox_model.dart';
import 'package:rayahhalekapp/provider/city_model.dart';
import 'package:rayahhalekapp/provider/language_model.dart';
import 'package:rayahhalekapp/provider/option_model.dart';
import 'package:rayahhalekapp/provider/order_detail_model.dart';
import 'package:rayahhalekapp/provider/order_model.dart';
import 'package:rayahhalekapp/provider/picker_model.dart';
import 'package:rayahhalekapp/provider/user_model.dart';
import 'package:rayahhalekapp/ui/screen/home_screen.dart';
import 'package:rayahhalekapp/ui/screen/login_screen.dart';
import 'package:rayahhalekapp/ui/screen/notification_screen.dart';
import 'package:rayahhalekapp/ui/screen/orders_screen.dart';
import 'package:rayahhalekapp/ui/screen/privacy_policy_screen.dart';
import 'package:rayahhalekapp/ui/screen/provider_by_map_screen.dart';
import 'package:rayahhalekapp/ui/screen/provider_list_screen.dart';
import 'package:rayahhalekapp/ui/screen/register_screen.dart';
import 'package:rayahhalekapp/ui/screen/splash_screen.dart';
import 'package:rayahhalekapp/vm/splash_vm.dart';
import 'package:workmanager/workmanager.dart';
import 'helper/UtilSharedPreferences.dart';
import 'helper/app_localization.dart';
import 'helper/helper.dart';
import 'model/service.dart';
import 'model/user.dart';

var splashVm = SplashVm();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await loadUserInfo();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => PickerModel()),
    ChangeNotifierProvider(create: (context) => CheckBoxModel()),
    ChangeNotifierProvider(create: (context) => OptionModel()),
    ChangeNotifierProvider(create: (context) => CityModel()),
    ChangeNotifierProvider(create: (context) => AttachmentModel()),
    ChangeNotifierProvider(create: (context) => OrderDetailModel()),
    ChangeNotifierProvider(create: (context) => OrderModel()),
    ChangeNotifierProvider(create: (context) => UserModel()),
    ChangeNotifierProvider(create: (context) => LanguageModel()),
  ], child: MyApp()));
}

Future<void> loadUserInfo() async {
  try {
    await UtilSharedPreferences.load();
    print(UtilSharedPreferences.getString("token"));
//  if (UtilSharedPreferences.getString("token") != null) {
    Helper.token = UtilSharedPreferences.getString("token");

    Helper.user = User.fromJson(UtilSharedPreferences.getObj("user"));
    Helper.isProvider = UtilSharedPreferences.getBool("is_provider");
    Helper.service = ServiceModel.getService(Helper.user.serviceId);
//    await splashVm.getUserInfo();

    print(Helper.isProvider);
    print(Helper.token);
    if(!Platform.isIOS)
    initService(Helper.isProvider, Helper.token);
  }catch(err){
    return;
  }
//  }
}

void initService(bool isProvider, String token) {
  HashMap<String, dynamic> params = HashMap();
  params["is_provider"] = isProvider;
  params["token"] = token;
  Workmanager.initialize(
    // The top level function, aka callbackDispatcher
    callbackDispatcher,
    // If enabled it will post a notification whenever
    // the task is running. Handy for debugging tasks
    isInDebugMode: true,
  );
  // Periodic task registration
  if (isProvider) {
    Workmanager.registerPeriodicTask(
        "2",

        //This is the value that will be
        // returned in the callbackDispatcher
        "checkLocationPeriodicTask",

        // When no frequency is provided
        // the default 15 minutes is set.
        // Minimum frequency is 15 min.
        // Android will automatically change
        // your frequency to 15 min
        // if you have configured a lower frequency.
        frequency: Duration(minutes: 15),
        inputData: params);
  }
  HashMap<String, dynamic> notifyParams = HashMap();
  notifyParams["token"] = token;
  notifyParams["is_notify"] = true;
  Workmanager.registerPeriodicTask(
      "3",

      //This is the value that will be
      // returned in the callbackDispatcher
      "checkNotificationPeriodicTask",

      // When no frequency is provided
      // the default 15 minutes is set.
      // Minimum frequency is 15 min.
      // Android will automatically change
      // your frequency to 15 min
      // if you have configured a lower frequency.
      frequency: Duration(minutes: 15),
      initialDelay: Duration(seconds: 5),
      inputData: notifyParams);
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    print(inputData["token"]);
    if (task == "checkNotificationPeriodicTask") {
      await serviceNotificationWork(inputData["token"]);
      return Future.value(true);
    } else {
      print("I am here as a notification");
      await serviceLocationWork(inputData["is_provider"], inputData["token"]);
      return Future.value(true);
    }
  });
}

Future<void> serviceLocationWork(bool isProvider, String token) async {
//    return Future.value(true);
  if (isProvider) {
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    HashMap<String, String> params = HashMap();
    params["latitude"] = position.latitude.toString();
    params["longitude"] = position.longitude.toString();
    await AppApi.userClient.updateLocation(params, token);
    return;
  }
}

Future<void> serviceNotificationWork(String token) async {
//    return Future.value(true);
  var notifies = await AppApi.userClient.checkNotify(token);

  FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();

  // app_icon needs to be a added as a drawable
  // resource to the Android head project.
  var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
  var IOS = new IOSInitializationSettings();

  // initialise settings for both Android and iOS device.
  var settings = new InitializationSettings(android, IOS);
  flip.initialize(settings);
  notifies.forEach((element) {
//    if (element.isOffer == "1") {
//      print("I am hello offer ");
////      try {
////        Get.
////      } catch (err) {
////        print("whfefereryyyyyyy");
////        print(err.toString());
////      }
////      _showNotificationWithDefaultSound(
////          flip, element.message, element.title);
//      print("whyyyyyyy");
//    } else {
      _showNotificationWithDefaultSound(flip, element.message, element.title);
//    }
  });
  return;
}

Future _showNotificationWithDefaultSound(
    flip, String message, String title) async {
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  print("Hi i am here");
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max, priority: Priority.High);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flip.show(0, title, message, platformChannelSpecifics,
      payload: 'Default_Sound');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black));
    return Consumer<LanguageModel>(
      builder: (context,model,child) {
        print(model.selectedLanguage);
        model.selectedLanguage =  UtilSharedPreferences.getInt("selected_language") ?? 0;
        return MaterialApp(
            title: '',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              AppLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('ar'),
              Locale('en'),
            ],
            locale: Locale( model.selectedLanguage == 0  ? "ar" : "en"),
//
//      localeResolutionCallback: (locale, supportedLocales) {
//        print(supportedLocales.first);
//        if (locale == null) {
//          debugPrint("*language locale is null!!!");
//          return supportedLocales.first;
//        }
//        for (var supportedLocale in supportedLocales) {
//          if (supportedLocale.languageCode == locale.languageCode) {
//            return supportedLocale;
//          }
//        }
//        return supportedLocales.first;
//      },
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              canvasColor: Colors.transparent,
              bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.white.withAlpha(1)),
            ),
            initialRoute: "/",
            routes: {
              "/": (context) => SplashScreen(),
              "/login": (context) => LoginScreen(),
              "/register": (context) => RegisterScreen(),
              "/main": (context) => HomeScreen(),
              "/notification": (context) => NotificationScreen(),
              "/provider_list": (context) => ProviderListScreen(),
              "/provider_map": (context) => ProviderByMapScreen(),
              "/my_order": (context) => OrderScreen(),
            }
        );
      }
    );
  }
}
