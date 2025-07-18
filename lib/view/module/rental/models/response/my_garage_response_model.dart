// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:velocy_user_app/helper/safe_parser.dart';

class MyGarageResponseModel {
  final List<MyGarageData> data;
  MyGarageResponseModel({required this.data});

  MyGarageResponseModel copyWith({List<MyGarageData>? data}) {
    return MyGarageResponseModel(data: data ?? this.data);
  }

  factory MyGarageResponseModel.fromMap(Map<String, dynamic> map) {
    return MyGarageResponseModel(
      data: List<MyGarageData>.from(
        (map['data'] as List<dynamic>).map<MyGarageData>(
          (x) => MyGarageData.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  String toString() => 'MyGarageResponseModel(data: $data)';

  @override
  bool operator ==(covariant MyGarageResponseModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;
}

class MyGarageData {
  final int? id;
  final String? vehicleName;
  final String? registrationNumber;
  final String? vehicleColor;
  final bool? isApproved;
  final List<String>? images;
  MyGarageData({
    this.id,
    this.vehicleName,
    this.registrationNumber,
    this.vehicleColor,
    this.isApproved,
    this.images,
  });

  MyGarageData copyWith({
    int? id,
    String? vehicleName,
    String? registrationNumber,
    String? vehicleColor,
    bool? isApproved,
    List<String>? images,
  }) {
    return MyGarageData(
      id: id ?? this.id,
      vehicleName: vehicleName ?? this.vehicleName,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      vehicleColor: vehicleColor ?? this.vehicleColor,
      isApproved: isApproved ?? this.isApproved,
      images: images ?? this.images,
    );
  }

  factory MyGarageData.fromMap(Map<String, dynamic> map) {
    return MyGarageData(
      id: safeParser(map['id'], 'id'),
      vehicleName: safeParser(map['vehicle_name'], 'vehicle_name'),
      registrationNumber: safeParser(
        map['registration_number'],
        'registration_number',
      ),
      vehicleColor: safeParser(map['vehicle_color'], 'vehicle_color'),
      isApproved: safeParser(map['is_approved'], 'is_approved'),
      images:
          map['images'] != null
              ? List<String>.from((map['images'] as List<dynamic>))
              : null,
    );
  }

  @override
  String toString() {
    return 'MyGarageData(id: $id, vehicleName: $vehicleName, registrationNumber: $registrationNumber, vehicleColor: $vehicleColor, isApproved: $isApproved, images: $images)';
  }

  @override
  bool operator ==(covariant MyGarageData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.vehicleName == vehicleName &&
        other.registrationNumber == registrationNumber &&
        other.vehicleColor == vehicleColor &&
        other.isApproved == isApproved &&
        listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        vehicleName.hashCode ^
        registrationNumber.hashCode ^
        vehicleColor.hashCode ^
        isApproved.hashCode ^
        images.hashCode;
  }
}
