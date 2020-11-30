import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/api/app_api.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/provider/order_model.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/header_widget.dart';
import 'package:rayahhalekapp/ui/widget/order_widget.dart';
import 'package:rayahhalekapp/vm/customer_order_vm.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen();

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
      {
  var selectedIndex = 0;
  var startMargin = 0.0;


  var alignment = AlignmentDirectional.bottomStart;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  var startPagination = false;
  var canPaginate =true;
  var titles = ["pending", "active", "finished"];

  CustomerOrderVm _customerOrderVm;

  void initVm() {
    _customerOrderVm = CustomerOrderVm();
  }

  Future<dynamic> Function(int poistion , bool isPagination) futureWork ;

  @override
  void initState() {
    super.initState();
    initVm();
  }

  @override
  Widget build(BuildContext context) {
    return HeaderWidget(
      "orders",
      0,
      Container(
        height: 20,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Container(
                color: Color(AppColors.borderGray).withOpacity(0.29),
                height: 48,
                child: Stack(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          titles.length,
                          (index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                                pageController.animateToPage(index,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                                setAlignment(index);
                              },
                              child: Container(
                                width:
                                    (MediaQuery.of(context).size.width - 40) /
                                        3,
                                height: 48,
                                child: Center(
                                  child: AppText(
                                    AppLocalization.of(context)
                                        .translate(titles[index]),
                                    (selectedIndex == index
                                        ? FontWeight.w700
                                        : FontWeight.w300),
                                    15,
                                    (selectedIndex == index
                                        ? AppColors.purpleTextColor
                                        : AppColors.hintGray),
                                    TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    AnimatedAlign(
                      alignment: alignment,
                      duration: Duration(
                        microseconds: 300,
                      ),
                      curve: Curves.easeInOut,
                      child: Container(
                        height: 4,
                        width: (MediaQuery.of(context).size.width - 10) / 3,
                        padding: EdgeInsetsDirectional.only(start: startMargin),
                        decoration: BoxDecoration(
                          color: Color(
                            AppColors.purpleTextColor,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (section) {
                  setState(() {
                    this.selectedIndex = section;
                    setAlignment(section);
                  });
                },
                children: List.generate(titles.length, (index) {
                  return Consumer<OrderModel>(builder: (context, model, child) {
                    if (model.cancelOrder != null) {
                      _customerOrderVm.cancelOrder(model.cancelOrder);
                    }
                    if (model.completedOrder != null) {
                      _customerOrderVm.completeOrder(model.completedOrder);
                    }
                    if (model.activatedOrder != null) {
                      _customerOrderVm.activateOrders(model.activatedOrder);
                    }
                    if (model.changedProviderOrder != null) {
                      _customerOrderVm.changeProvider(model.changedProviderOrder);
                    }
                    return  NotificationListener<ScrollNotification>(
                          onNotification:
                              (ScrollNotification scrollInfo) {
                            if (AppApi.orderClient.customerCanPaginate &&
                                scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent && canPaginate) {
                              // start loading data
                              canPaginate = false;
                              setState(() {
                                startPagination = true;
                              });
                              _customerOrderVm.getOrders(index + 1,
                                  isPagination: true).then((value) {
                                    canPaginate = true;
                                    setState(() {
                                      startPagination = false;
                                    });
                              });
                              return true;

                            }
                            return false;
                            },
                      child: FutureBuilder(
                        future: _customerOrderVm.getOrders(index+ 1) ,
                        builder: (context, snapshot) {
                          var orders = snapshot.data;
//                          if(startPagination){
//                            canPaginate = true;
//                            startPagination = false;
//                          }
                          return orders == null
                              ? Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    itemCount: orders.length,
                                    itemBuilder: (context, index) {
                                      return OrderWidget(
                                        orders[index],
                                        selectedIndex,
                                        moveTo: (position){
                                          if(position != null){
                                            setState(() {
                                              selectedIndex = position;
                                            });
                                            pageController.animateToPage(selectedIndex,
                                                duration: Duration(milliseconds: 300),
                                                curve: Curves.easeInOut);
                                            setAlignment(selectedIndex);
                                          }
                                        },
                                      );
                                    },
                                  );

                        },
                      ),
                    );
                  });
                }),
              ),
            ),
            startPagination ? CircularProgressIndicator() : SizedBox()
          ],
        ),
      ),
      colors: [0xD437128D, 0xD49004B7],
      showBackButton: true,
      containFliterIcon: false,
    );
  }

  void setAlignment(int index) {
    switch (index) {
      case 0:
        alignment = AlignmentDirectional.bottomStart;
        startMargin = 0;
        break;
      case 1:
        alignment = AlignmentDirectional.bottomCenter;
        startMargin = 5;
        break;
      case 2:
        alignment = AlignmentDirectional.bottomEnd;
        startMargin = 0;
        break;
    }
  }


}
