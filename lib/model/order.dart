import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rayahhalekapp/model/attachment.dart';
import 'package:rayahhalekapp/model/city.dart';
import 'package:rayahhalekapp/model/service_data.dart';
import 'package:rayahhalekapp/model/user.dart';

part 'order.g.dart';

@JsonSerializable()
class Order extends Equatable {
  int id;
  String userId;
  String serviceId;
  String createdAt;
  ServiceData serviceDetail;
  User provider;
  City city;
  String district;
  String buildingNumber;
  String apartmentNumber;
  String details;
  String price;
  String status;
  List<Attachment> attachments;

  Order(
      this.id,
      this.userId,
      this.createdAt,
      this.serviceId,
      this.serviceDetail,
      this.provider,
      this.city,
      this.district,
      this.buildingNumber,
      this.apartmentNumber,
      this.details,
      this.price,
      this.status,
      this.attachments);

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  @override
  List<Object> get props => [id];
}
