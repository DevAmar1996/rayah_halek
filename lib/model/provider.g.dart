// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderData _$ProviderFromJson(Map<String, dynamic> json) {
  return ProviderData(
    json['id'] as int,
    json['name'] as String,
    json['user_type_id'] as String,
    json['city_id'] as String,
    json['email'] as String,
    json['phone'] as String,
    json['avatar'] as String,
    json['service_id'] as String,
    json['latitude'] as String ?? "0",
    json['longitude'] as String ?? "0",

  );
}



Map<String, dynamic> _$ProviderToJson(ProviderData instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'user_type_id': instance.userTypeId,
  'city_id': instance.cityId,
  'email': instance.email,
  'phone': instance.phone,
  'avatar': instance.avatar,
  'service_id': instance.serviceId,
};
