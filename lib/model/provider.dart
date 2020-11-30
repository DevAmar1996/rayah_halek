import 'package:json_annotation/json_annotation.dart';

part 'provider.g.dart';

@JsonSerializable()
class ProviderData {
  int id;
  String name;
  String userTypeId;
  String cityId;
  String email;
  String phone;
  String avatar;
  String serviceId;
  String latitude;
  String longitude;

  ProviderData(this.id, this.name, this.userTypeId, this.cityId, this.email,
      this.phone, this.avatar, this.serviceId,this.latitude,this.longitude);

  factory ProviderData.fromJson(Map<String, dynamic> json) =>
      _$ProviderFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderToJson(this);
}
