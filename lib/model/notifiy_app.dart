import 'package:json_annotation/json_annotation.dart';
import 'package:rayahhalekapp/model/order.dart';
import 'package:rayahhalekapp/model/user.dart';


part 'notify.g.dart';

@JsonSerializable()
class Notify {
  int id;
  String userId;
  String otherUserId;
  String title;
  String message;
  String isOffer;
  User otherUser;
  Order order;


  Notify(this.id, this.userId,this.otherUserId,this.title,this.message,this.isOffer);

  factory Notify.fromJson(Map<String, dynamic> json) => _$NotifyFromJson(json);



}