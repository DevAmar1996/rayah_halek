import 'package:json_annotation/json_annotation.dart';

part 'app_config.g.dart';

@JsonSerializable()
class AppConfig {
  String email;
  String phone;
  String facebook;
  String twitter;
  String instagram;
  String snapchat;
  String whatsapp;

  AppConfig(this.email, this.phone, this.facebook, this.twitter, this.instagram,
      this.snapchat, this.whatsapp);

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);
}
