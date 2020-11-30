import 'package:flutter/material.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/model/provider.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/ui/widget/component/CustomProgressDialog.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/auth_bg.dart';
import 'package:rayahhalekapp/ui/widget/component/error_dialog.dart';
import 'package:rayahhalekapp/ui/widget/gradient_btn.dart';
import 'package:rayahhalekapp/ui/widget/order_successfully_created_widget.dart';
import 'package:rayahhalekapp/ui/widget/provider_list_widget.dart';
import 'package:rayahhalekapp/vm/provider_list_vm.dart';

class ProviderListScreen extends StatefulWidget {
  final bool isForChange;
  final Service service;

  ProviderListScreen({this.isForChange = false, this.service});

  @override
  _ProviderListScreenState createState() => _ProviderListScreenState();
}

class _ProviderListScreenState extends State<ProviderListScreen>
    implements ProviderListProtocol {
  var selectedPosition = -1;

  Service service;
  List<ProviderData> providers = [];
  var isLoaded = false;

  ProviderListVm providerListVm;
  CustomProgressDialog pr;

  void initVm() {
    providerListVm = ProviderListVm(this);
    providerListVm.getProvider(ServiceModel.getId(service));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    service = ModalRoute.of(context).settings.arguments ?? widget.service;
    if (!isLoaded) initVm();

    return Scaffold(
      backgroundColor: Color(
        AppColors.lightGrayBg,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          AuthBg(
            Container(
              height: 312,
            ),
            image: ServiceModel.getImageBg(service),
            colors: ServiceModel.getImageColors(service),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            padding: EdgeInsets.all(
              20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    AppText(
                      AppLocalization.of(context).translate("choose_one"),
                      FontWeight.w800,
                      25,
                      Colors.white.value,
                      TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                      bottom: 6,
                    ),
                    decoration: AppThemeData.roundedBoxWithShadow(),
                    height: 100,
                    child: isLoaded
                        ? ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemCount: providers.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(
                                      () {
                                        selectedPosition = index;
                                      },
                                    );
                                  },
                                  child: ProviderListWidget(
                                      ServiceModel.textColor(service),
                                      selectedPosition == index,
                                      providers[index].name),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(
                                  ServiceModel.textColor(service),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                GradientButton(
                  AppLocalization.of(context).translate("continue"),
                  () {
                    if (widget.isForChange) {
                      Navigator.of(context).pop(selectedPosition == -1
                          ? null
                          : providers[selectedPosition]);
                      return;
                    }
                    if (selectedPosition == -1) {
                      AppDialog.showMe(
                          context,
                          AppLocalization.of(context)
                              .translate("pick_provider_err"));
                      return;
                    }
                    if (Helper.user == null) {
                      this.mustLogin();
                      return;
                    }
                    pr = CustomProgressDialog(context, "", () {});
                    pr.showDialog().then((value) {
                      providerListVm.sendOrder(providers[selectedPosition].id);
                    });
                  },
                  ServiceModel.getButtonColors(service),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void didLoadProviderSuccess(List<ProviderData> providers) {
    if (mounted)
      setState(() {
        this.isLoaded = true;
        this.providers = providers;
      });
  }

  @override
  void didFail(String err) {
    pr.hideDialog();
    AppDialog.showMe(context, err);
  }

  @override
  void didSendOrderSuccess() {
    pr.hideDialog();
    providerListVm.clearData(context);
    showDialog(
      context: context,
      builder: (context) => (OrderCreatedSuccessfullyWidget(
          ServiceModel.textColor(service),
          ServiceModel.getButtonColors(service))),
    );
  }

  @override
  void mustLogin() {
    Navigator.of(context).pushNamed("/login", arguments: "/provider_list");
  }

  @override
  void nearProvider(ProviderData provider) {}
}
