
import 'package:json_annotation/json_annotation.dart';
import 'package:rayahhalekapp/model/city.dart';
import 'package:rayahhalekapp/model/service.dart';
import 'package:rayahhalekapp/model/service_data.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  String name;
  String userTypeId;
  String cityId;
  String email;
  String phone;
  String avatar;
  String serviceId;
  String address;
  City city;
  ServiceData serviceData;

  User(this.id, this.name, this.userTypeId, this.cityId, this.email, this.phone,
      this.avatar, this.serviceId,this.address,this.city,this.serviceData);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
