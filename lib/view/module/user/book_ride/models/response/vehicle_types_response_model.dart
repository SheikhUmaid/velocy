// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:velocy_user_app/helper/safe_parser.dart';

class VehicleTypesResponseModel {
  final bool status;
  final String message;
  final List<VehicleType> vehicleTypes;
  VehicleTypesResponseModel({
    required this.status,
    required this.message,
    required this.vehicleTypes,
  });

  VehicleTypesResponseModel copyWith({
    bool? status,
    String? message,
    List<VehicleType>? vehicleTypes,
  }) {
    return VehicleTypesResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      vehicleTypes: vehicleTypes ?? this.vehicleTypes,
    );
  }

  factory VehicleTypesResponseModel.fromMap(Map<String, dynamic> map) {
    return VehicleTypesResponseModel(
      status: map['status'] as bool,
      message: map['message'] as String,
      vehicleTypes: List<VehicleType>.from(
        (map['data'] as List<dynamic>).map<VehicleType>(
          (x) => VehicleType.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory VehicleTypesResponseModel.fromJson(String source) =>
      VehicleTypesResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'VehicleTypesResponseModel(status: $status, message: $message, vehicleTypes: $vehicleTypes)';

  @override
  bool operator ==(covariant VehicleTypesResponseModel other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.message == message &&
        listEquals(other.vehicleTypes, vehicleTypes);
  }

  @override
  int get hashCode =>
      status.hashCode ^ message.hashCode ^ vehicleTypes.hashCode;
}

class VehicleType {
  final int id;
  final String name;
  final String image;
  final int numberOfPassengers;
  VehicleType({
    required this.id,
    required this.name,
    required this.image,
    required this.numberOfPassengers,
  });

  VehicleType copyWith({
    int? id,
    String? name,
    String? image,
    int? numberOfPassengers,
  }) {
    return VehicleType(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      numberOfPassengers: numberOfPassengers ?? this.numberOfPassengers,
    );
  }

  factory VehicleType.fromMap(Map<String, dynamic> map) {
    return VehicleType(
      id: safeParser(map['id'], 'id'),
      name: safeParser(map['name'], 'name'),
      image: safeParser(map['image'], 'image'),
      numberOfPassengers: safeParser(
        map['number_of_passengers'],
        'number_of_passengers',
      ),
    );
  }

  factory VehicleType.fromJson(String source) =>
      VehicleType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VehicleType(id: $id, name: $name, image: $image, numberOfPassengers: $numberOfPassengers)';
  }

  @override
  bool operator ==(covariant VehicleType other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.image == image &&
        other.numberOfPassengers == numberOfPassengers;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        numberOfPassengers.hashCode;
  }
}
