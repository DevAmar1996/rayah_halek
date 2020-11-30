import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
import 'package:rayahhalekapp/ui/widget/provider_widget.dart';
import 'package:rayahhalekapp/vm/provider_list_vm.dart';

class ProviderByMapScreen extends StatefulWidget {
  ProviderByMapScreen();

  @override
  _ProviderByMapScreenState createState() => _ProviderByMapScreenState();
}

class _ProviderByMapScreenState extends State<ProviderByMapScreen>
    implements ProviderListProtocol {
  ProviderData provider;
  var isLoaded = false;

  ProviderListVm providerListVm;
  CustomProgressDialog pr;

  void initVm() {
    providerListVm = ProviderListVm(this);
    providerListVm.getNearProvider(ServiceModel.getId(service));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      initVm();
    });
  }

  Service service;

  @override
  Widget build(BuildContext context) {
    service = ModalRoute.of(context).settings.arguments;

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
                    decoration: AppThemeData.serviceDetailBoxDecoration(
                      borderRadius: 15,
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              14,
                            ),
                          ),
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(31.5129856, 34.4182822),
                              zoom: 14.4746,
                            ),
                            myLocationButtonEnabled: false,
                          ),
                        ),
                        isLoaded
                            ? ProviderWidget(
                                ServiceModel.textColor(service),
                                provider,
                                () {
                                  providerListVm.getNearProvider(
                                      ServiceModel.getId(service));
                                },
                              )
                            : Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(
                                      ServiceModel.textColor(service),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                GradientButton(
                  AppLocalization.of(context).translate("continue"),
                  () {
                    if (provider == null) {
                      return;
                    }
                    if (Helper.user == null) {
                      this.mustLogin();
                      return;
                    }
                    pr = CustomProgressDialog(context, "", () {});
                    pr.showDialog().then((value) {
                      providerListVm.sendOrder(provider.id);
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
  void didFail(String err) {
    pr?.hideDialog();
    AppDialog.showMe(context, err, onClickOk: () {
      if (providerListVm.number == 1) Navigator.of(context).pop();
    });
  }

  @override
  void didLoadProviderSuccess(List<ProviderData> providers) {}

  @override
  void didSendOrderSuccess() {
    pr.hideDialog();
    providerListVm.clearData(context);
    showDialog(
      context: context,
      builder: (context) => (OrderCreatedSuccessfullyWidget(
        ServiceModel.textColor(service),
        ServiceModel.getButtonColors(service),
      )),
    );
  }

  @override
  void mustLogin() {
    Navigator.of(context).pushNamed("/login", arguments: "/provider_map");
  }

  @override
  void nearProvider(ProviderData provider) {
    if (mounted)
      setState(() {
        this.isLoaded = true;
        this.provider = provider;
      });
  }
}
