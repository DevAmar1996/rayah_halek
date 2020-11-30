import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/ui/widget/header_widget.dart';
import 'package:rayahhalekapp/ui/widget/transaction_widget.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final bool isProvider = Helper.isProvider;
  final Service service = Helper.service;

  @override
  Widget build(BuildContext context) {
    return HeaderWidget(
      "pays",
      16,
      Container(
        height: 100,
        child: ListView.builder(
          padding: EdgeInsets.all(0),
          itemCount: 3,
          itemBuilder: (context, index) {
            return TransactionWidget(isProvider
                ? ServiceModel.textColor(service)
                : AppColors.purpleTextColor);
          },
        ),
      ),
      image: isProvider ? ServiceModel.getImageBg(service) : "",
      colors: isProvider
          ? ServiceModel.getImageColors(service)
          : [0xD437128D, 0xD49004B7],
    );
  }
}
