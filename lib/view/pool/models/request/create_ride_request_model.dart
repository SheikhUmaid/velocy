// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateRideRequestModel {
  final String? startLocationName;
  final double? startLatitude;
  final double? startLongitude;
  final String? endLocationName;
  final double? endLatitude;
  final double? endLongitude;
  final String? date;
  final String? time;
  final int? totalSeats;
  final double? finalPrice;
  final String? estimatedDuration;
  final String? driverNotes;
  final String? distanceKm;
  CreateRideRequestModel({
    this.startLocationName,
    this.startLatitude,
    this.startLongitude,
    this.endLocationName,
    this.endLatitude,
    this.endLongitude,
    this.date,
    this.time,
    this.totalSeats,
    this.finalPrice,
    this.estimatedDuration,
    this.driverNotes,
    this.distanceKm,
  });

  CreateRideRequestModel copyWith({
    String? startLocationName,
    double? startLatitude,
    double? startLongitude,
    String? endLocationName,
    double? endLatitude,
    double? endLongitude,
    String? date,
    String? time,
    int? totalSeats,
    double? finalPrice,
    String? estimatedDuration,
    String? driverNotes,
    String? distanceKm,
  }) {
    return CreateRideRequestModel(
      startLocationName: startLocationName ?? this.startLocationName,
      startLatitude: startLatitude ?? this.startLatitude,
      startLongitude: startLongitude ?? this.startLongitude,
      endLocationName: endLocationName ?? this.endLocationName,
      endLatitude: endLatitude ?? this.endLatitude,
      endLongitude: endLongitude ?? this.endLongitude,
      date: date ?? this.date,
      time: time ?? this.time,
      totalSeats: totalSeats ?? this.totalSeats,
      finalPrice: finalPrice ?? this.finalPrice,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      driverNotes: driverNotes ?? this.driverNotes,
      distanceKm: distanceKm ?? this.distanceKm,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'start_location_name': startLocationName,
      'start_latitude': startLatitude,
      'start_longitude': startLongitude,
      'end_location_name': endLocationName,
      'end_latitude': endLatitude,
      'end_longitude': endLongitude,
      'date': date,
      'time': time,
      'total_seats': totalSeats,
      'final_price': finalPrice,
      'estimated_duration': estimatedDuration,
      'driver_notes': driverNotes,
      'distance_km': distanceKm,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CreateRideRequestModel(startLocationName: $startLocationName, startLatitude: $startLatitude, startLongitude: $startLongitude, endLocationName: $endLocationName, endLatitude: $endLatitude, endLongitude: $endLongitude, date: $date, time: $time, totalSeats: $totalSeats, finalPrice: $finalPrice, estimatedDuration: $estimatedDuration, driverNotes: $driverNotes, distanceKm: $distanceKm)';
  }

  @override
  bool operator ==(covariant CreateRideRequestModel other) {
    if (identical(this, other)) return true;

    return other.startLocationName == startLocationName &&
        other.startLatitude == startLatitude &&
        other.startLongitude == startLongitude &&
        other.endLocationName == endLocationName &&
        other.endLatitude == endLatitude &&
        other.endLongitude == endLongitude &&
        other.date == date &&
        other.time == time &&
        other.totalSeats == totalSeats &&
        other.finalPrice == finalPrice &&
        other.estimatedDuration == estimatedDuration &&
        other.driverNotes == driverNotes &&
        other.distanceKm == distanceKm;
  }

  @override
  int get hashCode {
    return startLocationName.hashCode ^
        startLatitude.hashCode ^
        startLongitude.hashCode ^
        endLocationName.hashCode ^
        endLatitude.hashCode ^
        endLongitude.hashCode ^
        date.hashCode ^
        time.hashCode ^
        totalSeats.hashCode ^
        finalPrice.hashCode ^
        estimatedDuration.hashCode ^
        driverNotes.hashCode ^
        distanceKm.hashCode;
  }
}
