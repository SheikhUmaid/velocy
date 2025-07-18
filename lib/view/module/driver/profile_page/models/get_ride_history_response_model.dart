import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:velocy_user_app/helper/safe_parser.dart';

class GetRideHistoryResponseModel {
  final bool? status;
  final String? message;
  final List<RideHistory>? data;
  GetRideHistoryResponseModel({this.status, this.message, this.data});

  GetRideHistoryResponseModel copyWith({
    bool? status,
    String? message,
    List<RideHistory>? data,
  }) {
    return GetRideHistoryResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory GetRideHistoryResponseModel.fromMap(Map<String, dynamic> map) {
    return GetRideHistoryResponseModel(
      status: map['status'] != null ? map['status'] as bool : null,
      message: map['message'] != null ? map['message'] as String : null,
      data:
          map['data'] != null
              ? List<RideHistory>.from(
                (map['data'] as List<dynamic>).map<RideHistory?>(
                  (x) => RideHistory.fromMap(x as Map<String, dynamic>),
                ),
              )
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetRideHistoryResponseModel.fromJson(String source) =>
      GetRideHistoryResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'GetRideHistoryResponseModel(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(covariant GetRideHistoryResponseModel other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}

class RideHistory {
  final String? id;
  final String? fromLocation;
  final String? toLocation;
  final String? date;
  final String? startTime;
  final String? amountPaid;
  RideHistory({
    this.id,
    this.fromLocation,
    this.toLocation,
    this.date,
    this.startTime,
    this.amountPaid,
  });

  RideHistory copyWith({
    String? id,
    String? fromLocation,
    String? toLocation,
    String? date,
    String? startTime,
    String? amountPaid,
  }) {
    return RideHistory(
      id: id ?? this.id,
      fromLocation: fromLocation ?? this.fromLocation,
      toLocation: toLocation ?? this.toLocation,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      amountPaid: amountPaid ?? this.amountPaid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'from_location': fromLocation,
      'to_location': toLocation,
      'date': date,
      'start_time': startTime,
      'amount_paid': amountPaid,
    };
  }

  factory RideHistory.fromMap(Map<String, dynamic> map) {
    return RideHistory(
      id: safeParser(map['id'], 'id'),
      fromLocation: safeParser(map['from_location'], 'fromm_location'),
      toLocation: safeParser(map['to_location'], 'to_location'),
      date: safeParser(map['date'], 'date'),
      startTime: safeParser(map['start_time'], 'start_time'),
      amountPaid: safeParser(map['amount_paid'], 'amount_paid'),
    );
  }

  String toJson() => json.encode(toMap());

  factory RideHistory.fromJson(String source) =>
      RideHistory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RideHistory(id: $id, fromLocation: $fromLocation, toLocation: $toLocation, date: $date, startTime: $startTime, amountPaid: $amountPaid)';
  }

  @override
  bool operator ==(covariant RideHistory other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fromLocation == fromLocation &&
        other.toLocation == toLocation &&
        other.date == date &&
        other.startTime == startTime &&
        other.amountPaid == amountPaid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fromLocation.hashCode ^
        toLocation.hashCode ^
        date.hashCode ^
        startTime.hashCode ^
        amountPaid.hashCode;
  }
}
