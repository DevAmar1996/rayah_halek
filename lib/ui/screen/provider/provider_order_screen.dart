import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/api/app_api.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/provider/order_model.dart';
import 'package:rayahhalekapp/provider/user_model.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/header_widget.dart';
import 'package:rayahhalekapp/ui/widget/order_widget.dart';
import 'package:rayahhalekapp/vm/provider_order_vm.dart';

class ProviderOrderScreen extends StatefulWidget {
  @override
  _ProviderOrderScreenState createState() => _ProviderOrderScreenState();
}

class _ProviderOrderScreenState extends State<ProviderOrderScreen> {
  var selectedIndex = 0;
  var startMargin = 0.0;
  var alignment = AlignmentDirectional.bottomStart;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  var titles = ["new", "active", "finished"];
  Service service = Helper.service;
  var startPagination = false;
  var canPaginate =true;
  ProviderOrderVm _providerOrderVm;
  var newOrderCount = 0;

  initVm() {
    _providerOrderVm = ProviderOrderVm();
    _providerOrderVm.initService();
  }

  @override
  void initState() {
    super.initState();

    initVm();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(builder: (context, model, child) {
      if (model.user != null) {
        service = Helper.service;
      }
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
                                  setState(
                                    () {
                                      selectedIndex = index;
                                    },
                                  );
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AppText(
                                          AppLocalization.of(context)
                                              .translate(titles[index]),
                                          selectedIndex == index
                                              ? FontWeight.w700
                                              : FontWeight.w300,
                                          15,
                                          selectedIndex == index
                                              ? ServiceModel.textColor(service)
                                              : AppColors.hintGray,
                                          TextAlign.center,
                                        ),
                                        index == 0
                                            ? AppText(
                                                newOrderCount == 0
                                                    ? ""
                                                    : " $newOrderCount ",
                                                FontWeight.w700,
                                                15,
                                                AppColors.redColor2,
                                                TextAlign.start,
                                              )
                                            : SizedBox.shrink()
                                      ],
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
                          padding:
                              EdgeInsetsDirectional.only(start: startMargin),
                          decoration: BoxDecoration(
                            color: Color(ServiceModel.textColor(service)),
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
                  children: List.generate(
                    titles.length,
                    (index) {
                      return Consumer<OrderModel>(
                        builder: (context,model,child) {
                          if (model.cancelOrder != null) {
                            _providerOrderVm.cancelOrder(model.cancelOrder);
                          }
                          if (model.completedOrder != null) {
                            _providerOrderVm.completeOrder(model.completedOrder);
                          }
                          return  NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification scrollInfo){
                              if (AppApi.orderClient.providerCanPaginate &&
                                  scrollInfo.metrics.pixels ==
                                      scrollInfo.metrics.maxScrollExtent && canPaginate) {
                                // start loading data
                                print("hi");
                                canPaginate = false;
                                setState(() {
                                  startPagination = true;
                                });
                                _providerOrderVm.getOrders(index + 1,
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
                              future: _providerOrderVm.getOrders(index + 1),
                              builder: (context, snapshot) {
                                var orders = snapshot.data;
                                if (orders != null && index == 0) {
                                  newOrderCount = orders.length;
                                }
                                return orders == null
                                    ? Center(child: CircularProgressIndicator())
                                    : (index == 0 && orders.isEmpty
                                    ? Padding(
                                  padding: EdgeInsets.only(
                                    top: 100,
                                  ),
                                  child: Column(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            AppThemeData.imagePath +
                                                "no_order.png"),
                                        height: 125,
                                      ),
                                      SizedBox(
                                        height: 23,
                                      ),
                                      AppText(
                                        AppLocalization.of(context)
                                            .translate("no_new_order"),
                                        FontWeight.w300,
                                        20,
                                        AppColors.textGrayColor,
                                        TextAlign.center,
                                      )
                                    ],
                                  ),
                                )
                                    : RefreshIndicator(
                                  backgroundColor: Colors.white,
                                  color: Color(
                                    ServiceModel.textColor(service),
                                  ),
                                  child: ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    itemCount: orders.length,
                                    itemBuilder: (context, innerIndex) {
                                      return OrderWidget(
                                        orders[innerIndex],
                                        selectedIndex,
                                        isProvider: true,
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
                                  ),
                                  onRefresh: () async {
                                    var result = await _providerOrderVm
                                        .getOrders(index + 1,
                                        isRefresh: true);
                                    setState(
                                          () {
                                        orders = result;
                                      },
                                    );
                                    return;
                                  },
                                ));
                              },
                            ),
                          );
                        }
                      );
                    },
                  ),
                ),
              ),
              startPagination ? CircularProgressIndicator() : SizedBox()
            ],
          ),
        ),
        colors: ServiceModel.getImageColors(service),
        image: ServiceModel.getImageBg(service),
        showBackButton: false,
        containFliterIcon: true,
      );
    });
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
