import 'dart:convert';

import 'package:velocy_user_app/helper/safe_parser.dart';

class VehicleImageModel {
  final String? id;
  final String? image;
  final String? uploadedAt;

  VehicleImageModel({this.id, this.image, this.uploadedAt});

  factory VehicleImageModel.fromMap(Map<String, dynamic> map) {
    return VehicleImageModel(
      id: safeParser(map['id'], 'id'),
      image: safeParser(map['image'], 'image'),
      uploadedAt: safeParser(map['uploaded_at'], 'uploaded_at'),
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'image': image, 'uploaded_at': uploadedAt};
  }

  factory VehicleImageModel.fromJson(String source) =>
      VehicleImageModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}

class VehicleDetailsResponseModel {
  final String? id;
  final String? vehicleName;
  final String? vehicleType;
  final String? registrationNumber;
  final int? seatingCapacity;
  final String? fuelType;
  final String? transmission;
  final String? rentalPricePerHour;
  final String? availableFromDate;
  final String? availableToDate;
  final String? pickupLocation;
  final String? vehiclePapersDocument;
  final bool? confirmationChecked;
  final String? vehicleColor;
  final bool? isAc;
  final bool? isAvailable;
  final bool? isApproved;
  final String? securityDeposit;
  final List<VehicleImageModel>? images;

  VehicleDetailsResponseModel({
    this.id,
    this.vehicleName,
    this.vehicleType,
    this.registrationNumber,
    this.seatingCapacity,
    this.fuelType,
    this.transmission,
    this.rentalPricePerHour,
    this.availableFromDate,
    this.availableToDate,
    this.pickupLocation,
    this.vehiclePapersDocument,
    this.confirmationChecked,
    this.vehicleColor,
    this.isAc,
    this.isAvailable,
    this.isApproved,
    this.securityDeposit,
    this.images,
  });

  factory VehicleDetailsResponseModel.fromMap(Map<String, dynamic> map) {
    return VehicleDetailsResponseModel(
      id: safeParser(map['id'], 'id'),
      vehicleName: safeParser(map['vehicle_name'], 'vehicle_name'),
      vehicleType: safeParser(map['vehicle_type'], 'vehicle_type'),
      registrationNumber: safeParser(
        map['registration_number'],
        'registration_number',
      ),
      seatingCapacity: int.tryParse(
        safeParser(map['seating_capacity'], 'seating_capacity') ?? '',
      ),
      fuelType: safeParser(map['fuel_type'], 'fuel_type'),
      transmission: safeParser(map['transmission'], 'transmission'),
      rentalPricePerHour: safeParser(
        map['rental_price_per_hour'],
        'rental_price_per_hour',
      ),
      availableFromDate: safeParser(
        map['available_from_date'],
        'available_from_date',
      ),
      availableToDate: safeParser(
        map['available_to_date'],
        'available_to_date',
      ),
      pickupLocation: safeParser(map['pickup_location'], 'pickup_location'),
      vehiclePapersDocument: safeParser(
        map['vehicle_papers_document'],
        'vehicle_papers_document',
      ),
      confirmationChecked:
          map['confirmation_checked'] == true ||
          map['confirmation_checked'] == 1,
      vehicleColor: safeParser(map['vehicle_color'], 'vehicle_color'),
      isAc: map['is_ac'] == true || map['is_ac'] == 1,
      isAvailable: map['is_available'] == true || map['is_available'] == 1,
      isApproved: map['is_approved'] == true || map['is_approved'] == 1,
      securityDeposit: safeParser(
        map['security_deposite'],
        'security_deposite',
      ),
      images:
          (map['images'] as List<dynamic>?)
              ?.map((img) => VehicleImageModel.fromMap(img))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vehicle_name': vehicleName,
      'vehicle_type': vehicleType,
      'registration_number': registrationNumber,
      'seating_capacity': seatingCapacity,
      'fuel_type': fuelType,
      'transmission': transmission,
      'rental_price_per_hour': rentalPricePerHour,
      'available_from_date': availableFromDate,
      'available_to_date': availableToDate,
      'pickup_location': pickupLocation,
      'vehicle_papers_document': vehiclePapersDocument,
      'confirmation_checked': confirmationChecked,
      'vehicle_color': vehicleColor,
      'is_ac': isAc,
      'is_available': isAvailable,
      'is_approved': isApproved,
      'security_deposite': securityDeposit,
      'images': images?.map((e) => e.toMap()).toList(),
    };
  }

  factory VehicleDetailsResponseModel.fromJson(String source) =>
      VehicleDetailsResponseModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
