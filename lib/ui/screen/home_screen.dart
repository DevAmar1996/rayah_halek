import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/api/app_api.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/model/user.dart';
import 'package:rayahhalekapp/provider/user_model.dart';
import 'package:rayahhalekapp/ui/screen/customer_home_screen.dart';
import 'package:rayahhalekapp/ui/screen/provider/provider_order_screen.dart';
import 'package:rayahhalekapp/ui/widget/app_drawer.dart';
import 'package:rayahhalekapp/ui/widget/user_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    AppApi.orderClient.params.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(
        AppColors.lightGrayBg,
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/notification");
                },
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: <Widget>[
                    Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 28,
                    ),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Color(AppColors.redColor),
                        shape: BoxShape.circle,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 21.9,
          ),
          Consumer<UserModel>(
            builder: (context, model, child) {
              User user = model.user ?? Helper.user;
              return UserImage(
                  32,
                  32,
                  Helper.user != null
                      ? Helper.imageUrl + user.avatar
                      : "");
            },
          ),
          SizedBox(
            width: 24,
          ),
        ],
      ),
      body: Helper.isProvider ? ProviderOrderScreen() : CustomerHomeScreen(),
      drawer: Drawer(
        child: AppDrawer(),
      ),
    );
  }
}
