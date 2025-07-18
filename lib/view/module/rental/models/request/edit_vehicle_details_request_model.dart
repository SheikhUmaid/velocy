import 'dart:convert';

class EditVehicleDetailsRequestModel {
  final String? vehicleId;
  final String? vehicleName;
  final String? securityDeposit;
  EditVehicleDetailsRequestModel({
    this.vehicleId,
    required this.vehicleName,
    required this.securityDeposit,
  });

  EditVehicleDetailsRequestModel copyWith({
    String? vehicleId,
    String? vehicleName,
    String? securityDeposit,
  }) {
    return EditVehicleDetailsRequestModel(
      vehicleId: vehicleId ?? this.vehicleId,
      vehicleName: vehicleName ?? this.vehicleName,
      securityDeposit: securityDeposit ?? this.securityDeposit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vehicle_name': vehicleName,
      'security_deposit': securityDeposit,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'EditVehicleDetailsRequestModel(vehicleName: $vehicleName, securityDeposit: $securityDeposit)';

  @override
  bool operator ==(covariant EditVehicleDetailsRequestModel other) {
    if (identical(this, other)) return true;

    return other.vehicleName == vehicleName &&
        other.securityDeposit == securityDeposit;
  }

  @override
  int get hashCode => vehicleName.hashCode ^ securityDeposit.hashCode;
}
