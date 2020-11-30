import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rayahhalekapp/ui/widget/auth_bg.dart';
import 'package:rayahhalekapp/vm/splash_vm.dart';
import 'package:workmanager/workmanager.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashVm splashVm;

  @override
  void initState() {
    super.initState();
    splashVm = SplashVm();
    Future.delayed(Duration(milliseconds: 500), () async {
      var status = await checkPermission();
      if (status == LocationPermission.denied ||
          status == LocationPermission.deniedForever) {
        requestPermission();
      }
//      try{
      await splashVm.getUserInfo();
      Navigator.of(context).pushReplacementNamed("/main");
//    }catch(err){
//        Workmanager.cancelAll();
//        Navigator.of(context).pushReplacementNamed("/login");
//
//      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBg(
        Center(
          child: Container(
            width: 156,
            height: 156,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
