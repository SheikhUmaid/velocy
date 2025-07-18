class DriverSettingsModel {
  bool? status;
  String? message;
  Data? data;

  DriverSettingsModel({this.status, this.message, this.data});

  DriverSettingsModel.fromJson(Map<String, dynamic> json) {
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
  String? username;
  Null? email;
  String? profileImage;
  VehicleInfo? vehicleInfo;

  Data({this.username, this.email, this.profileImage, this.vehicleInfo});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    profileImage = json['profile_image'];
    vehicleInfo =
        json['vehicle_info'] != null
            ? new VehicleInfo.fromJson(json['vehicle_info'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    if (this.vehicleInfo != null) {
      data['vehicle_info'] = this.vehicleInfo!.toJson();
    }
    return data;
  }
}

class VehicleInfo {
  int? id;
  String? vehicleNumber;
  String? carName;

  VehicleInfo({this.id, this.vehicleNumber, this.carName});

  VehicleInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleNumber = json['vehicle_number'];
    carName = json['car_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicle_number'] = this.vehicleNumber;
    data['car_name'] = this.carName;
    return data;
  }
}
