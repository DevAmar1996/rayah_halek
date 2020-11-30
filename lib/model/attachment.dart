
import 'package:json_annotation/json_annotation.dart';

part 'attachment.g.dart';

@JsonSerializable()
class Attachment {
  String path;


  Attachment(this.path);

  factory Attachment.fromJson(Map<String, dynamic> json) => _$AttachmentFromJson(json);

}
