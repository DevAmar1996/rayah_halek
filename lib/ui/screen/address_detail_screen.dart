import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/model/city.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/provider/city_model.dart';
import 'package:rayahhalekapp/ui/widget/city_picker.dart';
import 'package:rayahhalekapp/ui/widget/component/error_dialog.dart';
import 'package:rayahhalekapp/ui/widget/header_widget.dart';
import 'package:rayahhalekapp/ui/widget/component/text_field.dart';
import 'package:rayahhalekapp/ui/widget/modal/provider_order_option_widget.dart';
import 'package:rayahhalekapp/vm/address_detail_vm.dart';

import 'map_screen.dart';

class AddressDetailScreen extends StatefulWidget {
  final Service service;

  AddressDetailScreen(this.service);

  @override
  _AddressDetailScreenState createState() => _AddressDetailScreenState();
}

class _AddressDetailScreenState extends State<AddressDetailScreen>
    implements AddressDetailProtocol {
  final _formKey = GlobalKey<FormState>();
  FocusNode _districtFocusNode = new FocusNode();
  FocusNode _buildNumberFocusNode = new FocusNode();
  FocusNode _apartmentFocusNode = new FocusNode();

  TextEditingController _district = new TextEditingController();
  TextEditingController _buildNumber = new TextEditingController();
  TextEditingController _apartment = new TextEditingController();
  AddressDetailVm _addressDetailVm;

  List<City> cities;

  int selectedCityId = -1;
  LatLng latLng = LatLng(0, 0);
  GoogleMapController mapController;
  Marker marker;

  void initVm() {
    _addressDetailVm = AddressDetailVm(this);
    _addressDetailVm.getCities();
  }

  @override
  void initState() {
    initVm();
    super.initState();
    _district.text = _addressDetailVm.getDistrict();
    _apartment.text = _addressDetailVm.getApartmentNumber();
    _buildNumber.text = _addressDetailVm.getBuildingNumber();
    _addressDetailVm.getUserLocation();

//    if (_addressDetailVm.getPosition().latitude != 0) {
//      latLng = _addressDetailVm.getPosition();
//    }else{
//      _addressDetailVm.getUserLocation();
//    }
  }

  @override
  Widget build(BuildContext context) {
    return HeaderWidget(
      "address_detail",
      16,
      Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsetsDirectional.only(start: 4, end: 4),
              child: Consumer<CityModel>(
                builder: (context, model, child) {
                  selectedCityId = model.id ?? -1;
                  return CityPicker(
                    cities,
                    model.index ?? -1,
                    AppColors.borderGray,
                    borderWidth: 1,
                    borderColor: AppColors.borderGray,
                    height: 46,
                    textColor: ServiceModel.textColor(widget.service),

                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AppTextField(
              AppLocalization.of(context).translate("district"),
              TextInputType.text,
              _districtFocusNode,
              _buildNumberFocusNode,
              _district,
              "",
              isLight: true,
              height: 55,
              focusColor: ServiceModel.textColor(
                widget.service,
              ),
              textColor: ServiceModel.textColor(
                widget.service,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AppTextField(
              AppLocalization.of(context).translate("build_number"),
              TextInputType.text,
              _buildNumberFocusNode,
              _apartmentFocusNode,
              _buildNumber,
              "",
              isLight: true,
              height: 55,
              focusColor: ServiceModel.textColor(
                widget.service,
              ),
              textColor: ServiceModel.textColor(
                widget.service,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AppTextField(
              AppLocalization.of(context).translate("apartment_number"),
              TextInputType.text,
              _apartmentFocusNode,
              null,
              _apartment,
              "",
              isLight: true,
              height: 55,
              focusColor: ServiceModel.textColor(
                widget.service,
              ),
              textColor: ServiceModel.textColor(
                widget.service,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 284,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                child: FutureBuilder(
                  future: _addressDetailVm.getUserLocation(),
                  builder: (context, data) {
                    latLng = data.data;
                    marker = Marker(
                      markerId: MarkerId('Marker'),
                      position: latLng,
                      icon: BitmapDescriptor.defaultMarkerWithHue(10),
                    );
                    return data.data != null
                        ? GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: latLng,
                              zoom: 11,
                            ),
                            onTap: (value) async {
                              print(this.latLng.longitude);
                              print(this.latLng.latitude);
                              LatLng latLng = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => MapScreen(
                                    this.latLng,
                                    ServiceModel.getButtonColors(
                                        widget.service),
                                  ),
                                ),
                              );
                              this.latLng = latLng;
                              mapController.animateCamera(
                                  CameraUpdate.newLatLng(latLng));

                            },
                            myLocationButtonEnabled: false,
                            onMapCreated: (GoogleMapController controller) {
                              mapController = controller;
                            },
                          )
                        : SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      action: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          if (selectedCityId == -1) {
            AppDialog.showMe(
                context, AppLocalization.of(context).translate("city_err"));
            return;
          }
          if (latLng.latitude == 0 || latLng.longitude == 0) {
            AppDialog.showMe(
                context, AppLocalization.of(context).translate("location_err"));
            return;
          }
          _addressDetailVm.save(
            selectedCityId,
            _district.text,
            _buildNumber.text,
            _apartment.text,
            latLng.latitude,
            latLng.longitude,
          );
          showModalBottomSheet(
              context: context,
              builder: (context) => ProviderOrderOptionWidget(widget.service));
        }
      },
      isScroll: true,
      image: ServiceModel.getImageBg(widget.service),
      haveButton: true,
      buttonColors: ServiceModel.getButtonColors(widget.service),
      buttonText: "continue",
      colors: ServiceModel.getImageColors(widget.service),
    );
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
  void didPickUserLocation(double lat, double long) {
    if (mounted) {
      setState(() {
        this.latLng = LatLng(lat, long);
      });
      mapController?.animateCamera(CameraUpdate.newLatLng(latLng));
    } else {
      this.latLng = LatLng(lat, long);
    }
  }
}
