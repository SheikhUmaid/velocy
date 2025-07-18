// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddStopsRequestModel {
  final String? rideId;
  final String? locationName;
  final double? latitude;
  final double? longitude;
  AddStopsRequestModel({
    this.rideId,
    this.locationName,
    this.latitude,
    this.longitude,
  });

  AddStopsRequestModel copyWith({
    String? rideId,
    String? locationName,
    double? latitude,
    double? longitude,
  }) {
    return AddStopsRequestModel(
      rideId: rideId ?? this.rideId,
      locationName: locationName ?? this.locationName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location_name': locationName,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'AddStopsRequestModel(rideId: $rideId, locationName: $locationName, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant AddStopsRequestModel other) {
    if (identical(this, other)) return true;

    return other.rideId == rideId &&
        other.locationName == locationName &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return rideId.hashCode ^
        locationName.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
