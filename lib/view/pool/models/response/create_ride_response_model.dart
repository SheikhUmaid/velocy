// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:velocy_user_app/helper/safe_parser.dart';

class CreateRideResponseModel {
  final bool? status;
  final String? message;
  final CreateRide? data;
  CreateRideResponseModel({this.status, this.message, this.data});

  CreateRideResponseModel copyWith({
    bool? status,
    String? message,
    CreateRide? data,
  }) {
    return CreateRideResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory CreateRideResponseModel.fromMap(Map<String, dynamic> map) {
    return CreateRideResponseModel(
      status: safeParser(map['status'], 'status'),
      message: safeParser(map['message'], 'message'),
      data:
          map['data'] != null
              ? CreateRide.fromMap(map['data'] as Map<String, dynamic>)
              : null,
    );
  }

  factory CreateRideResponseModel.fromJson(String source) =>
      CreateRideResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'CreateRideResponseModel(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(covariant CreateRideResponseModel other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}

class CreateRide {
  final int? rideId;
  final String? startLocation;
  final String? endLocation;
  final String? date;
  final String? time;
  final int? totalSeats;
  final int? availableSeats;
  CreateRide({
    this.rideId,
    this.startLocation,
    this.endLocation,
    this.date,
    this.time,
    this.totalSeats,
    this.availableSeats,
  });

  CreateRide copyWith({
    int? rideId,
    String? startLocation,
    String? endLocation,
    String? date,
    String? time,
    int? totalSeats,
    int? availableSeats,
  }) {
    return CreateRide(
      rideId: rideId ?? this.rideId,
      startLocation: startLocation ?? this.startLocation,
      endLocation: endLocation ?? this.endLocation,
      date: date ?? this.date,
      time: time ?? this.time,
      totalSeats: totalSeats ?? this.totalSeats,
      availableSeats: availableSeats ?? this.availableSeats,
    );
  }

  factory CreateRide.fromMap(Map<String, dynamic> map) {
    return CreateRide(
      rideId: safeParser(map['ride_id'], 'ride_id'),
      startLocation: safeParser(map['start_location'], 'start_location'),
      endLocation: safeParser(map['end_location'], 'end_location'),
      date: safeParser(map['date'], 'date'),
      time: safeParser(map['time'], 'time'),
      totalSeats: safeParser(map['total_seats'], 'total_seats'),
      availableSeats: safeParser(map['available_seats'], 'available_seats'),
    );
  }

  factory CreateRide.fromJson(String source) =>
      CreateRide.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreateRide(rideId: $rideId, startLocation: $startLocation, endLocation: $endLocation, date: $date, time: $time, totalSeats: $totalSeats, availableSeats: $availableSeats)';
  }

  @override
  bool operator ==(covariant CreateRide other) {
    if (identical(this, other)) return true;

    return other.rideId == rideId &&
        other.startLocation == startLocation &&
        other.endLocation == endLocation &&
        other.date == date &&
        other.time == time &&
        other.totalSeats == totalSeats &&
        other.availableSeats == availableSeats;
  }

  @override
  int get hashCode {
    return rideId.hashCode ^
        startLocation.hashCode ^
        endLocation.hashCode ^
        date.hashCode ^
        time.hashCode ^
        totalSeats.hashCode ^
        availableSeats.hashCode;
  }
}
