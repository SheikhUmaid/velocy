// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:velocy_user_app/helper/safe_parser.dart';

class AddStopsResponseModel {
  final bool? status;
  final String? message;
  final AddStops? data;
  AddStopsResponseModel({this.status, this.message, this.data});

  AddStopsResponseModel copyWith({
    bool? status,
    String? message,
    AddStops? data,
  }) {
    return AddStopsResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory AddStopsResponseModel.fromMap(Map<String, dynamic> map) {
    return AddStopsResponseModel(
      status: safeParser(map['status'], 'status'),
      message: safeParser(map['message'], 'message'),
      data:
          map['data'] != null
              ? AddStops.fromMap(map['data'] as Map<String, dynamic>)
              : null,
    );
  }

  factory AddStopsResponseModel.fromJson(String source) =>
      AddStopsResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'AddStopsResponseModel(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(covariant AddStopsResponseModel other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}

class AddStops {
  final int? rideId;
  final int? stopId;
  final String? locationName;
  final int? order;
  AddStops({this.rideId, this.stopId, this.locationName, this.order});

  AddStops copyWith({
    int? rideId,
    int? stopId,
    String? locationName,
    int? order,
  }) {
    return AddStops(
      rideId: rideId ?? this.rideId,
      stopId: stopId ?? this.stopId,
      locationName: locationName ?? this.locationName,
      order: order ?? this.order,
    );
  }

  factory AddStops.fromMap(Map<String, dynamic> map) {
    return AddStops(
      rideId: safeParser(map['ride_id'], 'ride_id'),
      stopId: safeParser(map['stop_id'], 'stop_id'),
      locationName: safeParser(map['location_name'], 'location_name'),
      order: safeParser(map['order'], 'order'),
    );
  }

  factory AddStops.fromJson(String source) =>
      AddStops.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddStops(rideId: $rideId, stopId: $stopId, locationName: $locationName, order: $order)';
  }

  @override
  bool operator ==(covariant AddStops other) {
    if (identical(this, other)) return true;

    return other.rideId == rideId &&
        other.stopId == stopId &&
        other.locationName == locationName &&
        other.order == order;
  }

  @override
  int get hashCode {
    return rideId.hashCode ^
        stopId.hashCode ^
        locationName.hashCode ^
        order.hashCode;
  }
}
