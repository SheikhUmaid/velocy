// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:velocy_user_app/helper/safe_parser.dart';

class ConfirmLocationResponseModel {
  final String? id;
  final String? rideType;
  final String? scheduleTime;
  final String? ridePurpose;
  final String? fromLocation;
  final String? fromLatitude;
  final String? fromLongitude;
  final String? toLocation;
  final String? toLatitude;
  final String? toLongitude;
  final String? distanceKm;
  ConfirmLocationResponseModel({
    this.id,
    this.rideType,
    this.scheduleTime,
    this.ridePurpose,
    this.fromLocation,
    this.fromLatitude,
    this.fromLongitude,
    this.toLocation,
    this.toLatitude,
    this.toLongitude,
    this.distanceKm,
  });

  ConfirmLocationResponseModel copyWith({
    String? id,
    String? rideType,
    String? scheduleTime,
    String? ridePurpose,
    String? fromLocation,
    String? fromLatitude,
    String? fromLongitude,
    String? toLocation,
    String? toLatitude,
    String? toLongitude,
    String? distanceKm,
  }) {
    return ConfirmLocationResponseModel(
      id: id ?? this.id,
      rideType: rideType ?? this.rideType,
      scheduleTime: scheduleTime ?? this.scheduleTime,
      ridePurpose: ridePurpose ?? this.ridePurpose,
      fromLocation: fromLocation ?? this.fromLocation,
      fromLatitude: fromLatitude ?? this.fromLatitude,
      fromLongitude: fromLongitude ?? this.fromLongitude,
      toLocation: toLocation ?? this.toLocation,
      toLatitude: toLatitude ?? this.toLatitude,
      toLongitude: toLongitude ?? this.toLongitude,
      distanceKm: distanceKm ?? this.distanceKm,
    );
  }

  factory ConfirmLocationResponseModel.fromMap(Map<String, dynamic> map) {
    return ConfirmLocationResponseModel(
      id: safeParser(map['id'], 'id'),
      rideType: safeParser(map['ride_type'], 'ride_type'),
      scheduleTime: safeParser(map['schedule_time'], 'schedule_time'),
      ridePurpose: safeParser(map['ride_purpose'], 'ride_purpose'),
      fromLocation: safeParser(map['from_location'], 'from_location'),
      fromLatitude: safeParser(map['from_latitude'], 'from_latitude'),
      fromLongitude: safeParser(map['from_longitude'], 'from_longitude'),
      toLocation: safeParser(map['to_location'], 'to_location'),
      toLatitude: safeParser(map['to_latitude'], 'to_latitude'),
      toLongitude: safeParser(map['to_longitude'], 'to_longitude'),
      distanceKm: safeParser(map['distance_km'], 'distance_km'),
    );
  }

  factory ConfirmLocationResponseModel.fromJson(String source) =>
      ConfirmLocationResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'ConfirmLocationResponseModel(id: $id, rideType: $rideType, scheduleTime: $scheduleTime, ridePurpose: $ridePurpose, fromLocation: $fromLocation, fromLatitude: $fromLatitude, fromLongitude: $fromLongitude, toLocation: $toLocation, toLatitude: $toLatitude, toLongitude: $toLongitude, distanceKm: $distanceKm)';
  }

  @override
  bool operator ==(covariant ConfirmLocationResponseModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.rideType == rideType &&
        other.scheduleTime == scheduleTime &&
        other.ridePurpose == ridePurpose &&
        other.fromLocation == fromLocation &&
        other.fromLatitude == fromLatitude &&
        other.fromLongitude == fromLongitude &&
        other.toLocation == toLocation &&
        other.toLatitude == toLatitude &&
        other.toLongitude == toLongitude &&
        other.distanceKm == distanceKm;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        rideType.hashCode ^
        scheduleTime.hashCode ^
        ridePurpose.hashCode ^
        fromLocation.hashCode ^
        fromLatitude.hashCode ^
        fromLongitude.hashCode ^
        toLocation.hashCode ^
        toLatitude.hashCode ^
        toLongitude.hashCode ^
        distanceKm.hashCode;
  }
}
