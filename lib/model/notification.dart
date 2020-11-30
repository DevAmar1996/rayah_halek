
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order.dart';

part 'notification.g.dart';

@JsonSerializable()
class AppNotification {
  int id;
  String userId;
  String otherUserId;
  String title;
  String message;
  String createdAt;
//  String isOffer;
//  User otherUser;
  Order order;


  AppNotification(this.id, this.userId,this.otherUserId,this.title,this.message,this.createdAt,this.order);

  factory AppNotification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);

}
