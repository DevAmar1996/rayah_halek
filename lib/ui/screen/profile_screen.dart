import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/model/city.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/provider/city_model.dart';
import 'package:rayahhalekapp/provider/picker_model.dart';
import 'package:rayahhalekapp/provider/user_model.dart';
import 'package:rayahhalekapp/ui/widget/city_picker.dart';
import 'package:rayahhalekapp/ui/widget/component/CustomProgressDialog.dart';
import 'package:rayahhalekapp/ui/widget/component/error_dialog.dart';
import 'package:rayahhalekapp/ui/widget/component/picker_text_field.dart';
import 'package:rayahhalekapp/ui/widget/header_widget.dart';
import 'package:rayahhalekapp/ui/widget/modal/provider/provider_service_Widget.dart';
import 'package:rayahhalekapp/ui/widget/provider_image.dart';
import 'package:rayahhalekapp/ui/widget/component/text_field.dart';
import 'package:rayahhalekapp/vm/profile_vm.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var isEditable = false;
  final _formKey = GlobalKey<FormState>();
  FocusNode _nameFocusNode = new FocusNode();
  FocusNode _cityFocusNode = new FocusNode();
  FocusNode _addressFocusNode = new FocusNode();
  FocusNode _mobileFocusNode = new FocusNode();

  final bool isProvider = Helper.isProvider;
  Service service = Helper.service;

  ProfileVm _profileVm;
  String _mobile;
  String _name;
  String _address;

  final picker = ImagePicker();
  File file;
  CustomProgressDialog pr;
  var selectedCity = -1;
  var selectedServiceId = -1;

  void initVm() {
    _profileVm = ProfileVm();
  }

  @override
  void initState() {
    super.initState();
    initVm();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, model, child) {
        if (model.user != null) {
          service = Helper.service;
        }
        return HeaderWidget(
          "profile",
          16,
          Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isEditable = true;
                    });
                  },
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: !isEditable
                        ? Image(
                            image:
                                AssetImage(AppThemeData.imagePath + "edit.png"),
                            width: 16.8,
                            height: 15,
                          )
                        : SizedBox.shrink(),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                GestureDetector(
                  onTap: () {
                    pickImageFromGallery(ImageSource.gallery);
                  },
                  child: ProviderImage(AppColors.dividerGrayColor,
                      size: 134,
                      padding: 7,
                      path: Helper.imageUrl + Helper.user.avatar,
                      file: file),
                ),
                SizedBox(
                  height: 25,
                ),
                AppTextField(
                  AppLocalization.of(context).translate("name"),
                  TextInputType.text,
                  _nameFocusNode,
                  _mobileFocusNode,
                  null,
                  "",
                  isLight: true,
                  padding: 0,
                  initialText: Helper.user.name,
                  isEnabled: isEditable,
                  textColor:
                      isProvider ? ServiceModel.textColor(service) : 0xD46034A1,
                  focusColor:
                      isProvider ? ServiceModel.textColor(service) : 0xFF36128C,
                  onChange: (value) {
                    _name = value;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AppTextField(
                  AppLocalization.of(context).translate("mobile_number"),
                  TextInputType.text,
                  _mobileFocusNode,
                  _cityFocusNode,
                  null,
                  "",
                  isLight: true,
                  padding: 0,
                  initialText: Helper.user.phone,
                  isEnabled: isEditable,
                  textColor:
                      isProvider ? ServiceModel.textColor(service) : 0xD46034A1,
                  focusColor:
                      isProvider ? ServiceModel.textColor(service) : 0xFF36128C,
                  onChange: (value) {
                    _mobile = value;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                FutureBuilder(
                  future: _profileVm.getCities(),
                  builder: (context, snapshot) {
                    List<City> cities = snapshot.data;
                    print(cities);
                    return Consumer<CityModel>(
                      builder: (context, model, child) {
                        selectedCity = model.id ?? -1;
                        return CityPicker(
                          cities,
                          -1,
                          AppColors.borderGray,
                          borderWidth: 1,
                          borderColor: AppColors.borderGray,
                          height: 46,
                          textColor: isProvider
                              ? ServiceModel.textColor(service)
                              : 0xD46034A1,
                          initText: Helper.user?.city?.name??"",
                          isEditable: isEditable,
                        );
                      },
                    );
                  },
                ),
                SizedBox(
                  height: Helper.isProvider ? 16 : 0,
                ),
                Helper.isProvider
                    ? Consumer<PickerModel>(
                        builder: (context, model, child) {
                          selectedServiceId = model.serviceSelectedId ??
                              ServiceModel.getId(Helper.service);
                          return PickerTextField(
                            () {
                              FocusScope.of(context).unfocus();
                              if(isEditable)
                              showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    ProviderService(selectedServiceId - 1),
                              );
                            },
                            AppLocalization.of(context).translate(
                                model.serviceName == null ||
                                        model.serviceName == ""
                                    ? ServiceModel.getTitle(Helper.service)
                                    : model.serviceName),
                            true,
                            borderWidth: 1,
                            borderColor: AppColors.borderGray,
                            height: 46,
                            textColor: isProvider
                                ? ServiceModel.textColor(service)
                                : 0xD46034A1,
                          );
                        },
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 16,
                ),
                AppTextField(
                  AppLocalization.of(context).translate("Address"),
                  TextInputType.text,
                  _addressFocusNode,
                  null,
                  null,
                  "",
                  isLight: true,
                  padding: 0,
                  initialText: Helper.user.address,
                  isEnabled: isEditable,
                  textColor:
                      isProvider ? ServiceModel.textColor(service) : 0xD46034A1,
                  focusColor:
                      isProvider ? ServiceModel.textColor(service) : 0xFF36128C,
                  onChange: (value) {
                    _address = value;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          haveButton: isEditable,
          isScroll: true,
          buttonColors: isProvider
              ? ServiceModel.getButtonColors(service)
              : [
                  (AppColors.purpleTextColor),
                  (AppColors.purpleTextColor2),
                ],
          image: isProvider ? ServiceModel.getImageBg(service) : "",
          colors: isProvider
              ? ServiceModel.getImageColors(service)
              : [0xD437128D, 0xD49004B7],
          buttonText: "send",
          action: () async {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              pr = CustomProgressDialog(context, "", () {});
              await pr.showDialog();
              try {
                await _profileVm.updateProfile(_mobile, _name, _address, file,
                    selectedCity, selectedServiceId);
                Provider.of<UserModel>(context, listen: false)
                    .changeUser(Helper.user);
                pr.hideDialog();
                setState(() {
                  isEditable = false;
                });
              } catch (err) {
                pr.hideDialog();
                AppDialog.showMe(
                    context, err.toString().replaceAll("Exception:", ""));
              }
            }
          },
        );
      },
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
}
