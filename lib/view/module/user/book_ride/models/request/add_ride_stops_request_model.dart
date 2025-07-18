// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:velocy_user_app/helper/safe_parser.dart';

class AddRideStopsRequestModel {
  final String ride;
  final String latitude;
  final String longitude;
  final String location;
  AddRideStopsRequestModel({
    required this.ride,
    required this.latitude,
    required this.longitude,
    required this.location,
  });

  AddRideStopsRequestModel copyWith({
    String? ride,
    String? latitude,
    String? longitude,
    String? location,
  }) {
    return AddRideStopsRequestModel(
      ride: ride ?? this.ride,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ride': ride,
      'latitude': latitude,
      'longitude': longitude,
      'location': location,
    }..removeWhere((key, value) => value == null);
  }

  factory AddRideStopsRequestModel.fromMap(Map<String, dynamic> map) {
    return AddRideStopsRequestModel(
      ride: safeParser(map['ride'], 'ride'),
      latitude: safeParser(map['latitude'], 'latitude'),
      longitude: safeParser(map['longitude'], 'longitude'),
      location: safeParser(map['location'], 'location'),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddRideStopsRequestModel.fromJson(String source) =>
      AddRideStopsRequestModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'AddRideStopsRequestModel(ride: $ride, latitude: $latitude, longitude: $longitude, location: $location)';
  }

  @override
  bool operator ==(covariant AddRideStopsRequestModel other) {
    if (identical(this, other)) return true;

    return other.ride == ride &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.location == location;
  }

  @override
  int get hashCode {
    return ride.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        location.hashCode;
  }
}
