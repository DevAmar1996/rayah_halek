import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rayahhalekapp/api/app_api.dart';
import 'package:rayahhalekapp/model/city.dart';
import 'package:geolocator/geolocator.dart';

class AddressDetailVm {
  AddressDetailProtocol protocol;

  AddressDetailVm(this.protocol);

  void save(int cityId, String district, String buildingNumber,
      String apartmentNumber, double latitude, double longitude) {
    AppApi.orderClient.params["city_id"] = cityId.toString();
    AppApi.orderClient.params["district"] = district;
    AppApi.orderClient.params["building_number"] = buildingNumber;
    AppApi.orderClient.params["apartment_number"] = apartmentNumber;
    AppApi.orderClient.params["latitude"] = latitude.toString();
    AppApi.orderClient.params["longitude"] = longitude.toString();
  }

  void getCities() async {
    var cities = await AppApi.configClient.getCities();
    protocol.didLoadCitiesSuccess(cities);
  }

  Future<LatLng> getUserLocation() async {
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    print(position.longitude);
    return LatLng(position.latitude,position.longitude);
  }

  String getDistrict() {
    return AppApi.orderClient.params["district"] ?? "";
  }

  String getBuildingNumber() {
    return AppApi.orderClient.params["building_number"] ?? "";
  }

  String getApartmentNumber() {
    return AppApi.orderClient.params["apartment_number"] ?? "";
  }

//  LatLng getPosition() {
//    print(AppApi.orderClient.params["latitude"]);
//    return LatLng((AppApi.orderClient.params["latitude"] ?? "0") as double,
//        (AppApi.orderClient.params["longitude"] ?? "0") as double);
//  }
}

class AddressDetailProtocol {
  void didLoadCitiesSuccess(List<City> cities) {}

  void didPickUserLocation(double lat, double long) {}
}
