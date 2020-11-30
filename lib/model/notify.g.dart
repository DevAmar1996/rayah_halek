// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifiy_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notify _$NotifyFromJson(Map<String, dynamic> json) {
  return Notify(
    json['id'] as int,
    json['user_id'] as String,
    json['other_user_id'] as String,
    json['title_lang'] as String,
    json['message_lang'] as String,
    json['is_offer'] as String,
//    (json['other_user'] as Map != null ? User.fromJson(json['city']) : null),
//    (json['order'] as Map != null ? Order.fromJson(json['city']) : null),

  );
}
