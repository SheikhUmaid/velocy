class DriverRidesResponseModel {
  final bool status;
  final String message;
  final List<DriverRideModel> data;

  DriverRidesResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DriverRidesResponseModel.fromJson(Map<String, dynamic> json) {
    final dataField = json['data'];
    return DriverRidesResponseModel(
      status: json['status'] == true,
      message: json['message'] ?? '',
      data: dataField is List
          ? dataField
          .map((e) => DriverRideModel.fromJson(e as Map<String, dynamic>))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class DriverRideModel {
  final int id;
  final String toLocation;
  final String toLatitude;
  final String toLongitude;
  final double price;

  DriverRideModel({
    required this.id,
    required this.toLocation,
    required this.toLatitude,
    required this.toLongitude,
    required this.price,
  });

  factory DriverRideModel.fromJson(Map<String, dynamic> json) {
    return DriverRideModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      toLocation: json['to_location'] ?? '',
      toLatitude: json['to_latitude'] ?? '',
      toLongitude: json['to_longitude'] ?? '',
      price: (json['price'] is num) ? (json['price'] as num).toDouble() : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'to_location': toLocation,
      'to_latitude': toLatitude,
      'to_longitude': toLongitude,
      'price': price,
    };
  }
}
