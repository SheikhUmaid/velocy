// class RideDetailsResponseModel {
//   final bool status;
//   final String message;
//   final RideDetailsModel? data;

//   RideDetailsResponseModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory RideDetailsResponseModel.fromJson(Map<String, dynamic> json) {
//     return RideDetailsResponseModel(
//       status: json['status'] ?? false,
//       message: json['message'] ?? '',
//       data:
//           json['data'] != null ? RideDetailsModel.fromJson(json['data']) : null,
//     );
//   }
// }

// class RideDetailsModel {
//   final int? id;
//   final String? user;
//   final String? city;
//   final String? vehicleType;
//   final List<RideStop>? rideStops;
//   final String? createdAt;
//   final String? rideType;
//   final String? scheduledTime;
//   final String? fromLocation;
//   final String? fromLatitude;
//   final String? fromLongitude;
//   final String? toLocation;
//   final String? toLatitude;
//   final String? toLongitude;
//   final String? distanceKm;
//   final String? estimatedPrice;
//   final String? offeredPrice;
//   final bool? status;
//   final bool? womenOnly;
//   final String? startTime;
//   final String? endTime;
//   final int? driver;

//   RideDetailsModel({
//     this.id,
//     this.user,
//     this.city,
//     this.vehicleType,
//     this.rideStops,
//     this.createdAt,
//     this.rideType,
//     this.scheduledTime,
//     this.fromLocation,
//     this.fromLatitude,
//     this.fromLongitude,
//     this.toLocation,
//     this.toLatitude,
//     this.toLongitude,
//     this.distanceKm,
//     this.estimatedPrice,
//     this.offeredPrice,
//     this.status,
//     this.womenOnly,
//     this.startTime,
//     this.endTime,
//     this.driver,
//   });

//   factory RideDetailsModel.fromJson(Map<String, dynamic> json) {
//     return RideDetailsModel(
//       id: json['id'],
//       user: json['user'],
//       city: json['city'],
//       vehicleType: json['vehicle_type'],
//       rideStops:
//           (json['ride_stops'] as List<dynamic>?)
//               ?.map((e) => RideStop.fromJson(e))
//               .toList(),
//       createdAt: json['created_at'],
//       rideType: json['ride_type'],
//       scheduledTime: json['scheduled_time'],
//       fromLocation: json['from_location'],
//       fromLatitude: json['from_latitude'],
//       fromLongitude: json['from_longitude'],
//       toLocation: json['to_location'],
//       toLatitude: json['to_latitude'],
//       toLongitude: json['to_longitude'],
//       distanceKm: json['distance_km'],
//       estimatedPrice: json['estimated_price'],
//       offeredPrice: json['offered_price'],
//       status: json['status'],
//       womenOnly: json['women_only'],
//       startTime: json['start_time'],
//       endTime: json['end_time'],
//       driver: json['driver'],
//     );
//   }
// }

// class RideStop {
//   final int? id;
//   final String? location;
//   final String? latitude;
//   final String? longitude;
//   final int? order;

//   RideStop({this.id, this.location, this.latitude, this.longitude, this.order});

//   factory RideStop.fromJson(Map<String, dynamic> json) {
//     return RideStop(
//       id: json['id'],
//       location: json['location'],
//       latitude: json['latitude'],
//       longitude: json['longitude'],
//       order: json['order'],
//     );
//   }
// }

class RideDetailsResponseModel {
  final bool status;
  final String message;
  final RideDetailsModel? data;

  RideDetailsResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RideDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return RideDetailsResponseModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data:
          json['data'] != null ? RideDetailsModel.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data?.toJson()};
  }

  @override
  String toString() {
    return 'RideDetailsResponseModel(status: $status, message: $message, data: $data)';
  }
}

class RideDetailsModel {
  int? id;
  String? user;
  String? city;
  String? vehicleType;
  List<RideStop>? rideStops;
  String? createdAt;
  String? rideType;
  String? scheduledTime;
  String? fromLocation;
  String? fromLatitude;
  String? fromLongitude;
  String? toLocation;
  String? toLatitude;
  String? toLongitude;
  String? distanceKm;
  String? estimatedPrice;
  String? offeredPrice;
  String? status;
  bool? womenOnly;
  String? startTime;
  String? endTime;
  String? ridePurpose;
  dynamic driver;
  dynamic company;

  RideDetailsModel({
    this.id,
    this.user,
    this.city,
    this.vehicleType,
    this.rideStops,
    this.createdAt,
    this.rideType,
    this.scheduledTime,
    this.fromLocation,
    this.fromLatitude,
    this.fromLongitude,
    this.toLocation,
    this.toLatitude,
    this.toLongitude,
    this.distanceKm,
    this.estimatedPrice,
    this.offeredPrice,
    this.status,
    this.womenOnly,
    this.startTime,
    this.endTime,
    this.ridePurpose,
    this.driver,
    this.company,
  });

  factory RideDetailsModel.fromJson(Map<String, dynamic> json) {
    return RideDetailsModel(
      id: json['id'],
      user: json['user'],
      city: json['city'],
      vehicleType: json['vehicle_type'],
      rideStops:
          (json['ride_stops'] as List<dynamic>?)
              ?.map((e) => RideStop.fromJson(e))
              .toList(),
      createdAt: json['created_at'],
      rideType: json['ride_type'],
      scheduledTime: json['scheduled_time'],
      fromLocation: json['from_location'],
      fromLatitude: json['from_latitude'],
      fromLongitude: json['from_longitude'],
      toLocation: json['to_location'],
      toLatitude: json['to_latitude'],
      toLongitude: json['to_longitude'],
      distanceKm: json['distance_km'].toString(),
      estimatedPrice: json['estimated_price'].toString(),
      offeredPrice: json['offered_price']?.toString(),
      status: json['status']?.toString(),
      womenOnly: json['women_only'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      ridePurpose: json['ride_purpose'],
      driver: json['driver'],
      company: json['company'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'city': city,
      'vehicle_type': vehicleType,
      'ride_stops': rideStops?.map((e) => e.toJson()).toList(),
      'created_at': createdAt,
      'ride_type': rideType,
      'scheduled_time': scheduledTime,
      'from_location': fromLocation,
      'from_latitude': fromLatitude,
      'from_longitude': fromLongitude,
      'to_location': toLocation,
      'to_latitude': toLatitude,
      'to_longitude': toLongitude,
      'distance_km': distanceKm,
      'estimated_price': estimatedPrice,
      'offered_price': offeredPrice,
      'status': status,
      'women_only': womenOnly,
      'start_time': startTime,
      'end_time': endTime,
      'ride_purpose': ridePurpose,
      'driver': driver,
      'company': company,
    };
  }

  @override
  String toString() {
    return 'RideDetailsModel(user: $user, city: $city, from: $fromLocation, to: $toLocation, '
        'distance: $distanceKm, estimatedPrice: ₹$estimatedPrice)';
  }
}

class RideStop {
  String? location;
  String? latitude;
  String? longitude;
  int? order;

  RideStop({this.location, this.latitude, this.longitude, this.order});

  factory RideStop.fromJson(Map<String, dynamic> json) {
    return RideStop(
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'order': order,
    };
  }

  @override
  String toString() {
    return 'RideStop(location: $location, lat: $latitude, long: $longitude, order: $order)';
  }
}
