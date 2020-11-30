// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    json['id'] as int,
    json['user_id'] as String,
    json['created_at'] as String,
    json['service_id'] as String,
    (json['service_details'] as Map != null
        ? ServiceData.fromJson(json['service_details'])
        : null),
    (json['provider'] as Map != null ? User.fromJson(json['provider']) : null),
    (json['city'] as Map != null ? City.fromJson(json['city']) : null),
    json['district'] as String,
    json['building_number'] as String,
    json['apartment_number'] as String,
    json['details'] as String,
    json['price'] as String,
    json['order_status'] as String,
    ((json['attachments'] as List)
        ?.map((e) =>
            e == null ? null : Attachment.fromJson(e as Map<String, dynamic>))
        ?.toList()),
  );
}
