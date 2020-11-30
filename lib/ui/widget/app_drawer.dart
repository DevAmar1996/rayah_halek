import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/model/drawer.dart';
import 'package:rayahhalekapp/ui/widget/drawer_header.dart';
import 'package:rayahhalekapp/ui/widget/list_item/drawer_item.dart';
import 'component/app_text.dart';

class AppDrawer extends StatelessWidget {
  final DrawerModel _drawerModel = DrawerModel();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          AppDrawerHeader(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: _drawerModel.getDrawerCount(),
              itemBuilder: (context, index) {
                return DrawerItem(
                    _drawerModel.getName(index),
                    _drawerModel.getIcon(index),
                    _drawerModel.getAction(index, context),
                    index == 9);
              },
            ),
          ),
          SafeArea(
            child: AppText(
              AppLocalization.of(context).translate("all_right_saved") + "\n",
              FontWeight.w500,
              12,
              AppColors.textGrayColor,
              TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
