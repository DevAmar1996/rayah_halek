
part 'service_data.g.dart';

class ServiceData {
  final int id;
  final String serviceId;
  final String image;
  final String title;
  final String description;



  ServiceData(this.id,this.serviceId, this.title, this.image, this.description);

  factory ServiceData.fromJson(Map<String, dynamic> json) => _$ServiceDataFromJson(json);

}
