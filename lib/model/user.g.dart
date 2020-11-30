// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as int,
    json['name'] as String,
    json['user_type_id'] as String,
    json['city_id'] as String,
    json['email'] as String,
    json['phone'] as String,
    json['avatar'] as String,
    json['service_id'] as String,
    json['address'] as String,
    (json['city'] as Map != null ? City.fromJson(json['city']) : null),
    (json['service'] as Map != null ? ServiceData.fromJson(json['service']) : null),

  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'user_type_id': instance.userTypeId,
      'city_id': instance.cityId,
      'email': instance.email,
      'phone': instance.phone,
      'avatar': instance.avatar,
      'service_id': instance.serviceId,
    };
