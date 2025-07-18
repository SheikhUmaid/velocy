// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:velocy_user_app/helper/safe_parser.dart';

class EstimatePriceResponseModel {
  final bool status;
  final String message;
  final EstimatePrice estimatePrice;
  EstimatePriceResponseModel({
    required this.status,
    required this.message,
    required this.estimatePrice,
  });

  EstimatePriceResponseModel copyWith({
    bool? status,
    String? message,
    EstimatePrice? estimatePrice,
  }) {
    return EstimatePriceResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      estimatePrice: estimatePrice ?? this.estimatePrice,
    );
  }

  factory EstimatePriceResponseModel.fromMap(Map<String, dynamic> map) {
    return EstimatePriceResponseModel(
      status: map['status'] as bool,
      message: map['message'] as String,
      estimatePrice: EstimatePrice.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  factory EstimatePriceResponseModel.fromJson(String source) =>
      EstimatePriceResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'EstimatePriceResponseModel(status: $status, message: $message, estimatePrice: $estimatePrice)';

  @override
  bool operator ==(covariant EstimatePriceResponseModel other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.message == message &&
        other.estimatePrice == estimatePrice;
  }

  @override
  int get hashCode =>
      status.hashCode ^ message.hashCode ^ estimatePrice.hashCode;
}

class EstimatePrice {
  final String message;
  final int vehicleTypeId;
  final double pricePerKm;
  final double distanceKm;
  final double estimatedPrice;
  final String userRole;
  EstimatePrice({
    required this.message,
    required this.vehicleTypeId,
    required this.pricePerKm,
    required this.distanceKm,
    required this.estimatedPrice,
    required this.userRole,
  });

  EstimatePrice copyWith({
    String? message,
    int? vehicleTypeId,
    double? pricePerKm,
    double? distanceKm,
    double? estimatedPrice,
    String? userRole,
  }) {
    return EstimatePrice(
      message: message ?? this.message,
      vehicleTypeId: vehicleTypeId ?? this.vehicleTypeId,
      pricePerKm: pricePerKm ?? this.pricePerKm,
      distanceKm: distanceKm ?? this.distanceKm,
      estimatedPrice: estimatedPrice ?? this.estimatedPrice,
      userRole: userRole ?? this.userRole,
    );
  }

  factory EstimatePrice.fromMap(Map<String, dynamic> map) {
    return EstimatePrice(
      message: safeParser(map['message'], 'message'),
      vehicleTypeId: safeParser(map['vehicle_type_id'], 'vehicleTypeId'),
      pricePerKm: safeParser(map['price_per_km'], 'pricePerKm'),
      distanceKm: safeParser(map['distance_km'], 'distanceKm'),
      estimatedPrice: safeParser(map['estimated_price'], 'estimatedPrice'),
      userRole: safeParser(map['user_role'], 'userRole'),
    );
  }

  factory EstimatePrice.fromJson(String source) =>
      EstimatePrice.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EstimatePrice(message: $message, vehicleTypeId: $vehicleTypeId, pricePerKm: $pricePerKm, distanceKm: $distanceKm, estimatedPrice: $estimatedPrice, userRole: $userRole)';
  }

  @override
  bool operator ==(covariant EstimatePrice other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.vehicleTypeId == vehicleTypeId &&
        other.pricePerKm == pricePerKm &&
        other.distanceKm == distanceKm &&
        other.estimatedPrice == estimatedPrice &&
        other.userRole == userRole;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        vehicleTypeId.hashCode ^
        pricePerKm.hashCode ^
        distanceKm.hashCode ^
        estimatedPrice.hashCode ^
        userRole.hashCode;
  }
}
