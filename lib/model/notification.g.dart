// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppNotification _$NotificationFromJson(Map<String, dynamic> json) {
  return AppNotification(
    json['id'] as int,
    json['user_id'] as String,
    json['other_user_id'] as String,
    json['title_lang'] as String,
    json['message_lang'] as String,
    json['created_at'] as String,
//    (json['other_user'] as Map != null ? User.fromJson(json['city']) : null),
    (json['order'] as Map != null ? Order.fromJson(json['order']) : null),
  );
}
