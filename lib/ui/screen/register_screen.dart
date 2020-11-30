import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/model/city.dart';
import 'package:rayahhalekapp/provider/checkBox_model.dart';
import 'package:rayahhalekapp/provider/city_model.dart';
import 'package:rayahhalekapp/provider/picker_model.dart';
import 'package:rayahhalekapp/provider/user_model.dart';
import 'package:rayahhalekapp/ui/widget/city_picker.dart';
import 'package:rayahhalekapp/ui/widget/component/CustomProgressDialog.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/auth_bg.dart';
import 'package:rayahhalekapp/ui/widget/component/check_box.dart';
import 'package:rayahhalekapp/ui/widget/circle_image.dart';
import 'package:rayahhalekapp/ui/widget/component/error_dialog.dart';
import 'package:rayahhalekapp/ui/widget/component/normal_btn.dart';
import 'package:rayahhalekapp/ui/widget/component/picker_text_field.dart';
import 'package:rayahhalekapp/ui/widget/component/text_field.dart';
import 'package:rayahhalekapp/ui/widget/modal/provider/provider_service_Widget.dart';
import 'package:rayahhalekapp/vm/register_vm.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterProtocol {
  final _formKey = GlobalKey<FormState>();
  FocusNode _passwordFocusNode = new FocusNode();
  FocusNode _nameFocusNode = new FocusNode();
  FocusNode _cityFocusNode = new FocusNode();
  FocusNode _addressFocusNode = new FocusNode();
  FocusNode _mobileFocusNode = new FocusNode();

  TextEditingController _mobile = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  TextEditingController _address = new TextEditingController();

  final picker = ImagePicker();
  File file;
  CustomProgressDialog pr;
  var selectedCity = -1;
  var selectedServiceId = -1;
  bool isAcceptedTerm = false;

  var isProvider = Helper.isProvider;

  RegisterVM _registerVM;
  List<City> cities;

  void initVm() {
    _registerVM = RegisterVM(this);
    _registerVM.getCities();
  }

  @override
  void initState() {
    super.initState();
    initVm();
  }

  String screenName;

  @override
  Widget build(BuildContext context) {
    screenName = ModalRoute.of(context).settings.arguments ?? null;
    return AuthBg(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsetsDirectional.only(
            start: 16,
            end: 16,
            top: 33,
            bottom: 20,
          ),
          child: Form(
            key: _formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppLocalization.of(context).translate("welcome"),
                      style: AppThemeData.largeTitle(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      AppLocalization.of(context)
                          .translate("create_your_account_title"),
                      style: AppThemeData.subTitle(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: GestureDetector(
                          onTap: () {
                            pickImageFromGallery(ImageSource.gallery);
                          },
                          child: CircleImage(file)),
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    AppTextField(
                      AppLocalization.of(context).translate("name"),
                      TextInputType.text,
                      _nameFocusNode,
                      _mobileFocusNode,
                      _name,
                      AppLocalization.of(context).translate("name_required"),
                      onChange: (_) {
                        _formKey.currentState.validate();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                      AppLocalization.of(context).translate("mobile_number"),
                      TextInputType.number,
                      _mobileFocusNode,
                      _addressFocusNode,
                      _mobile,
                      AppLocalization.of(context)
                          .translate("mobile_num_required"),
                      onChange: (_) {
                        _formKey.currentState.validate();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Consumer<CityModel>(
                      builder: (context, model, child) {
                        selectedCity = model.id ?? -1;
                        return CityPicker(
                            cities, model.index ?? -1, Colors.white.value);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                      AppLocalization.of(context).translate("Address"),
                      TextInputType.text,
                      _addressFocusNode,
                      _passwordFocusNode,
                      _address,
                      AppLocalization.of(context).translate("address_required"),
                      onChange: (_) {
                        _formKey.currentState.validate();
                      },
                    ),
                    SizedBox(
                      height: isProvider ? 10 : 0,
                    ),
                    isProvider
                        ? Consumer<PickerModel>(
                            builder: (context, model, child) {
                              selectedServiceId = model.serviceSelectedId ?? -1;
                              return PickerTextField(() {
                                FocusScope.of(context).unfocus();
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      ProviderService(selectedServiceId - 1),
                                );
                              },
                                  AppLocalization.of(context).translate(
                                      model.serviceName == null ||
                                              model.serviceName == ""
                                          ? "service"
                                          : model.serviceName),
                                  true);
                            },
                          )
                        : SizedBox.shrink(),
                    SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                      AppLocalization.of(context).translate("password"),
                      TextInputType.text,
                      _passwordFocusNode,
                      null,
                      _password,
                      AppLocalization.of(context)
                          .translate("password_required"),
                      onChange: (_) {
                        _formKey.currentState.validate();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Consumer<CheckBoxModel>(
                      builder: (context, model, child) {
                        isAcceptedTerm = model.isSelected ?? false;
                        return CheckBox(
                          AppLocalization.of(context)
                              .translate("read_term_and_conditions"),
                        );
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    NormalButton(
                      AppLocalization.of(context).translate("register"),
                      () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          if (selectedCity == -1) {
                            AppDialog.showMe(
                                context,
                                AppLocalization.of(context)
                                    .translate("city_err"));
                          } else if (file == null) {
                            AppDialog.showMe(
                                context,
                                AppLocalization.of(context)
                                    .translate("image_err"));
                          } else if (!isAcceptedTerm) {
                            AppDialog.showMe(
                                context,
                                AppLocalization.of(context)
                                    .translate("term_err"));
                          } else if (Helper.isProvider &&
                              selectedServiceId == -1) {
                            AppDialog.showMe(
                                context,
                                AppLocalization.of(context)
                                    .translate("service_err"));
                          } else {
                            pr = CustomProgressDialog(
                                context,
                                AppLocalization.of(context).translate("reg..."),
                                () {});
                            pr.showDialog().then(
                              (value) {
                                _registerVM.register(
                                  _mobile.text,
                                  _password.text,
                                  _name.text,
                                  _address.text,
                                  file,
                                  selectedCity,
                                  selectedServiceId,
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: AppText(
                          AppLocalization.of(context).translate("login"),
                          FontWeight.w800,
                          15,
                          Colors.white.value,
                          TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  pickImageFromGallery(ImageSource imageSource) async {
    var pickFile = await picker.getImage(source: imageSource);
    File file = await compressImage(File(pickFile.path));

    setState(() {
      this.file = file;
    });
  }

  /// Compress Image
  Future<File> compressImage(File file) async {
    // Get file path
    // eg:- "Volume/VM/abcd.jpeg"
    final filePath = file.absolute.path;
    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    return await FlutterImageCompress.compressAndGetFile(filePath, outPath,
        minWidth: 300, minHeight: 300, quality: 50);
  }

  @override
  void didLoadCitiesSuccess(List<City> cities) {
    if (mounted)
      setState(() {
        this.cities = cities;
      });
    else
      this.cities = cities;
  }

  @override
  void didRegisterFail(String message) {
    pr.hideDialog();
    AppDialog.showMe(context, message);
  }

  @override
  void didRegisterSuccess() {
    pr.hideDialog();
    Provider.of<UserModel>(context, listen: false).changeUser(Helper.user);
    if (screenName != null) {
      Navigator.of(context).popUntil(ModalRoute.withName(screenName));
    } else
      Navigator.of(context).pushReplacementNamed("/main");
  }
}
