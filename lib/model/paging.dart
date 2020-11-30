
import 'package:json_annotation/json_annotation.dart';

part 'paging.g.dart';

@JsonSerializable()
class Paging {
  int currentPage;
  dynamic data;
  String nextPageUrl;

  Paging(this.currentPage, this.data,this.nextPageUrl);

  factory Paging.fromJson(Map<String, dynamic> json) => _$PagingFromJson(json);


}