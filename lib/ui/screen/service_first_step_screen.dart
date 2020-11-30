import 'package:flutter/material.dart';
import 'package:rayahhalekapp/api/app_api.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/model/service_data.dart';
import 'package:rayahhalekapp/ui/screen/order_second_step_screen.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/auth_bg.dart';
import 'package:rayahhalekapp/ui/widget/component/error_dialog.dart';
import 'package:rayahhalekapp/ui/widget/gradient_btn.dart';
import 'package:rayahhalekapp/vm/service_first_step_vm.dart';

class ServiceFirstStepScreen extends StatefulWidget {
  final Service service;

  ServiceFirstStepScreen(this.service);

  @override
  _ServiceFirstStepScreenState createState() => _ServiceFirstStepScreenState();
}

class _ServiceFirstStepScreenState extends State<ServiceFirstStepScreen>
    implements ServiceFirstStepProtocol {
  var selectedPosition = -1;

  List<ServiceData> services;
  ServiceFirstStepVM _serviceFirstStepVM;

  void setupViewModel() {
    _serviceFirstStepVM = ServiceFirstStepVM(this);
    _serviceFirstStepVM.getServices(ServiceModel.getId(widget.service));
  }

  @override
  void initState() {
    super.initState();
    setupViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(
        AppColors.lightGrayBg,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AuthBg(
              Column(
                children: <Widget>[
                  Container(
                    height: 312,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.08,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _serviceFirstStepVM.clearData(context);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsetsDirectional.only(start: 16),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Image(
                            image: AssetImage(
                              AppThemeData.imagePath +
                                  ServiceModel.getImage(widget.service),
                            ),
                            color: Colors.white,
                            width: 78,
                            fit: BoxFit.fill,
                            height: 78,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: AppText(
                              AppLocalization.of(context).translate(
                                  ServiceModel.getTitle(widget.service)),
                              FontWeight.w600,
                              20,
                              Colors.white.value,
                              TextAlign.center),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                          ),
                          child: Center(
                            child: AppText(
                              "نموذج نص من المفترض أن يكون هنا نموذج نص من المفترض أن يكون هنا نموذج نص من المفترض أن يكون هنا",
                              FontWeight.w500,
                              15,
                              Colors.white.value,
                              TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              colors: ServiceModel.getImageColors(
                widget.service,
              ),
              image: ServiceModel.getImageBg(widget.service),
            ),
            SizedBox(
              height: ServiceModel.spaceBeforeDisplayingService(
                widget.service,
              ).toDouble(),
            ),
            services != null
                ? GridView.count(
                    padding: EdgeInsets.all(0),
                    mainAxisSpacing: ServiceModel.getMainSpacing(
                      widget.service,
                    ),
                    childAspectRatio: ServiceModel.getAspectRatio(
                      widget.service,
                      MediaQuery.of(context).size.width,
                    ),
                    crossAxisSpacing: 0,
                    shrinkWrap: true,
                    physics: new NeverScrollableScrollPhysics(),
                    crossAxisCount: ServiceModel.getNumberOfGrid(
                      widget.service,
                    ),
                    children: List.generate(
                      services.length,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              this.selectedPosition = index;
                            });
                          },
                          child: ServiceModel.getGridWidget(
                              widget.service, selectedPosition == index,
                              serviceData: services.length != 0
                                  ? services[index]
                                  : null),
                        );
                      },
                    ))
                : Container(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(
                            ServiceModel.textColor(widget.service),
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 16,
            ),
            Container(
              padding: EdgeInsetsDirectional.only(
                end: 16,
                start: 16,
              ),
              child: GradientButton(
                  AppLocalization.of(context).translate("continue"), () {
                if (selectedPosition == -1) {
                  AppDialog.showMe(
                    context,
                    AppLocalization.of(context).translate("choose_service_err"),
                  );
                  return;
                }
                _serviceFirstStepVM.saveData(
                    this.services[selectedPosition].serviceId,
                    this.services[selectedPosition].id,
                    selectedPosition);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) =>
                        OrderSecondStepScreen(widget.service,this.services[selectedPosition]))));
              }, ServiceModel.getButtonColors(widget.service)),
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didLoadServices(List<ServiceData> services) {
    if (mounted)
      setState(() {
        this.services = services;
      });
    else
      this.services = services;
  }
}
