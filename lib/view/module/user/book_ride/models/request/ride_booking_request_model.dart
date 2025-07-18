// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RideBookingRequestModel {
  final String rideId;
  final bool womenOnly;
  final String? status;
  final String? offeredPrice;
  RideBookingRequestModel({
    required this.rideId,
    required this.womenOnly,
    this.status = 'pending',
    this.offeredPrice,
  });

  RideBookingRequestModel copyWith({
    String? rideId,
    bool? womenOnly,
    String? status,
    String? offeredPrice,
  }) {
    return RideBookingRequestModel(
      rideId: rideId ?? this.rideId,
      womenOnly: womenOnly ?? this.womenOnly,
      status: status ?? this.status,
      offeredPrice: offeredPrice ?? this.offeredPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'women_only': womenOnly,
      'status': status,
      'offered_price': offeredPrice,
    }..removeWhere((key, value) => value == null);
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'RideBoolingRequestModel(womenOnly: $womenOnly, status: $status, offeredPrice: $offeredPrice)';

  @override
  bool operator ==(covariant RideBookingRequestModel other) {
    if (identical(this, other)) return true;

    return other.womenOnly == womenOnly &&
        other.status == status &&
        other.offeredPrice == offeredPrice;
  }

  @override
  int get hashCode =>
      womenOnly.hashCode ^ status.hashCode ^ offeredPrice.hashCode;
}
