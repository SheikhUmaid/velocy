import 'dart:convert';

class ConfirmLocationRequestModel {
  final String? rideType;
  final String? cityName;
  final String? fromLocation;
  final String? fromLatitude;
  final String? fromLongitude;
  final String? toLocation;
  final String? toLatitude;
  final String? toLongitude;
  final String? distanceKm;
  final String? ridePurpose;
  ConfirmLocationRequestModel({
    this.rideType,
    this.cityName,
    this.fromLocation,
    this.fromLatitude,
    this.fromLongitude,
    this.toLocation,
    this.toLatitude,
    this.toLongitude,
    this.distanceKm,
    this.ridePurpose,
  });

  ConfirmLocationRequestModel copyWith({
    String? rideType,
    String? cityName,
    String? fromLocation,
    String? fromLatitude,
    String? fromLongitude,
    String? toLocation,
    String? toLatitude,
    String? toLongitude,
    String? distanceKm,
    String? ridePurpose,
  }) {
    return ConfirmLocationRequestModel(
      rideType: rideType ?? this.rideType,
      cityName: cityName ?? this.cityName,
      fromLocation: fromLocation ?? this.fromLocation,
      fromLatitude: fromLatitude ?? this.fromLatitude,
      fromLongitude: fromLongitude ?? this.fromLongitude,
      toLocation: toLocation ?? this.toLocation,
      toLatitude: toLatitude ?? this.toLatitude,
      toLongitude: toLongitude ?? this.toLongitude,
      distanceKm: distanceKm ?? this.distanceKm,
      ridePurpose: ridePurpose ?? this.ridePurpose,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ride_type': rideType,
      'city_name': cityName,
      'from_location': fromLocation,
      'from_latitude': fromLatitude,
      'from_longitude': fromLongitude,
      'to_location': toLocation,
      'to_latitude': toLatitude,
      'to_longitude': toLongitude,
      'distance_km': distanceKm,
      'ride_purpose': ridePurpose,
    }..removeWhere((key, value) => value == null);
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ConfirmLocationRequestModel(rideType: $rideType, cityName: $cityName, fromLocation: $fromLocation, fromLatitude: $fromLatitude, fromLongitude: $fromLongitude, toLocation: $toLocation, toLatitude: $toLatitude, toLongitude: $toLongitude, distanceKm: $distanceKm, ridePurpose: $ridePurpose)';
  }

  @override
  bool operator ==(covariant ConfirmLocationRequestModel other) {
    if (identical(this, other)) return true;

    return other.rideType == rideType &&
        other.cityName == cityName &&
        other.fromLocation == fromLocation &&
        other.fromLatitude == fromLatitude &&
        other.fromLongitude == fromLongitude &&
        other.toLocation == toLocation &&
        other.toLatitude == toLatitude &&
        other.toLongitude == toLongitude &&
        other.distanceKm == distanceKm &&
        other.ridePurpose == ridePurpose;
  }

  @override
  int get hashCode {
    return rideType.hashCode ^
        cityName.hashCode ^
        fromLocation.hashCode ^
        fromLatitude.hashCode ^
        fromLongitude.hashCode ^
        toLocation.hashCode ^
        toLatitude.hashCode ^
        toLongitude.hashCode ^
        distanceKm.hashCode ^
        ridePurpose.hashCode;
  }
}
