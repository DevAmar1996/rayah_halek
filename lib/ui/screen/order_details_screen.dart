import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/model/order.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/attachment_widget.dart';
import 'package:rayahhalekapp/ui/widget/container_with_title.dart';
import 'package:rayahhalekapp/ui/widget/detail_last_widget.dart';
import 'package:rayahhalekapp/ui/widget/header_widget.dart';
import 'package:rayahhalekapp/ui/widget/order_detail_widget.dart';
import 'package:rayahhalekapp/vm/order_detail_vm.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int section;
  final Service service;
  final List<int> bgColors;
  final List<int> buttonColors;
  final String image;
  final Widget userInfo;
  final Widget priceWidget;
  final Widget lastWidget;
  final int textColor;
  final Order order;

  OrderDetailsScreen(this.section, this.service, this.userInfo,
      this.priceWidget, this.lastWidget, this.order,
      {this.bgColors = const [0xD437128D, 0xD49004B7],
      this.image,
      this.buttonColors = const [
        0xFF9004B7,
        0xFF36128C,
      ],
      this.textColor = 0xFF9004B7});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {


  @override
  Widget build(BuildContext context) {
    return HeaderWidget(
      "order_detail",
      16,
      widget.order == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Center(
                  child: Image(
                    width: 23,
                    height: 23,
                    image: AssetImage(
                      AppThemeData.imagePath +
                          ServiceModel.getImage(widget.service),
                    ),
                    color: Color(
                      ServiceModel.textColor(
                        widget.service,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Center(
                  child: AppText(
                      AppLocalization.of(context)
                          .translate(ServiceModel.getTitle(widget.service)),
                      FontWeight.w700,
                      15,
                      ServiceModel.textColor(
                        widget.service,
                      ),
                      TextAlign.center),
                ),
                SizedBox(
                  height: 13,
                ),
               OrderDetailWidget(widget.textColor, widget.order),
                SizedBox(
                  height: 16,
                ),
                widget.order.attachments.length != 0
                    ? ContainerWithTitle(
                        "attachments",
                        Container(
                          padding: EdgeInsets.all(7),
                          height: 110,
                          child: ListView.builder(
                            itemCount:  widget.order.attachments.length,
                            padding: EdgeInsets.all(0),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return AttachmentWidget(
                                () {},
                                url: Helper.imageUrl + widget.order.attachments[index].path,
                              );
                            },
                          ),
                        ),
                        widget.textColor)
                    : SizedBox.shrink(),
                SizedBox(
                  height: widget.order.attachments.length != 0 ? 16 : 0,
                ),
                widget.order?.provider == null ? SizedBox.shrink() : widget.userInfo,
                SizedBox(
                  height:  16 ,
                ),
                widget.priceWidget,
                SizedBox(
                  height: 30,
                ),
                widget.lastWidget
              ],
            ),
      isScroll: true,
      colors: widget.bgColors,
      image: widget.image,
    );
  }
}
