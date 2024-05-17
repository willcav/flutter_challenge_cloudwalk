import '../../domain/entities/location_info.dart';

class LocationInfoModel extends LocationInfo {
  LocationInfoModel({
    required super.latitude,
    required super.longitude,
  });

  factory LocationInfoModel.fromJson(Map<String, dynamic> json) {
    return LocationInfoModel(
      latitude: json['lat'],
      longitude: json['lon'],
    );
  }
}
