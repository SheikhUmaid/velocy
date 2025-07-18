class DriverVehiclesDocModel {
  bool? status;
  String? message;
  Data? data;

  DriverVehiclesDocModel({this.status, this.message, this.data});

  DriverVehiclesDocModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? licensePlateNumber;
  String? vehicleRegistrationDoc;
  String? driverLicense;
  String? vehicleInsurance;
  bool? verified;

  Data({
    this.id,
    this.licensePlateNumber,
    this.vehicleRegistrationDoc,
    this.driverLicense,
    this.vehicleInsurance,
    this.verified,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    licensePlateNumber = json['license_plate_number'];
    vehicleRegistrationDoc = json['vehicle_registration_doc'];
    driverLicense = json['driver_license'];
    vehicleInsurance = json['vehicle_insurance'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['license_plate_number'] = this.licensePlateNumber;
    data['vehicle_registration_doc'] = this.vehicleRegistrationDoc;
    data['driver_license'] = this.driverLicense;
    data['vehicle_insurance'] = this.vehicleInsurance;
    data['verified'] = this.verified;
    return data;
  }
}
