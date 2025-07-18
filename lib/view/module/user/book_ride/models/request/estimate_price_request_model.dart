// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EstimatePriceRequestModel {
  final String rideId;
  final String vehicleType;
  EstimatePriceRequestModel({required this.rideId, required this.vehicleType});

  EstimatePriceRequestModel copyWith({String? rideId, String? vehicleType}) {
    return EstimatePriceRequestModel(
      rideId: rideId ?? this.rideId,
      vehicleType: vehicleType ?? this.vehicleType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'ride_id': rideId, 'vehicle_type_id': vehicleType}
      ..removeWhere((key, value) => value == null);
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(covariant EstimatePriceRequestModel other) {
    if (identical(this, other)) return true;

    return other.rideId == rideId && other.vehicleType == vehicleType;
  }

  @override
  int get hashCode => rideId.hashCode ^ vehicleType.hashCode;
}
