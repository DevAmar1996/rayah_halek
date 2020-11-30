
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()
class City extends Equatable{
  int id;
  String name;


  City(this.id, this.name);

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);

  @override
  List<Object> get props => [id];
}
