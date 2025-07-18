// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AddVehicleRequestModel {
  final String vehicleName;
  final String vehicleType;
  final String registrationNumber;
  final String seatingCapacity;
  final String fuelType;
  final String transmission;
  final String rentalPricePerHour;
  final String availableFromDate;
  final String availableToDate;
  final String picupLocation;
  final String vehiclePapersDocument;
  final bool confirmationChecked;
  final String vehicleColor;
  final bool isAc;
  final List<String> images;
  AddVehicleRequestModel({
    required this.vehicleName,
    required this.vehicleType,
    required this.registrationNumber,
    required this.seatingCapacity,
    required this.fuelType,
    required this.transmission,
    required this.rentalPricePerHour,
    required this.availableFromDate,
    required this.availableToDate,
    required this.picupLocation,
    required this.vehiclePapersDocument,
    required this.confirmationChecked,
    required this.vehicleColor,
    required this.isAc,
    required this.images,
  });

  AddVehicleRequestModel copyWith({
    String? vehicleName,
    String? vehicleType,
    String? registrationNumber,
    String? seatingCapacity,
    String? fuelType,
    String? transmission,
    String? rentalPricePerHour,
    String? availableFromDate,
    String? availableToDate,
    String? picupLocation,
    String? vehiclePapersDocument,
    bool? confirmationChecked,
    String? vehicleColor,
    bool? isAc,
    List<String>? images,
  }) {
    return AddVehicleRequestModel(
      vehicleName: vehicleName ?? this.vehicleName,
      vehicleType: vehicleType ?? this.vehicleType,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      seatingCapacity: seatingCapacity ?? this.seatingCapacity,
      fuelType: fuelType ?? this.fuelType,
      transmission: transmission ?? this.transmission,
      rentalPricePerHour: rentalPricePerHour ?? this.rentalPricePerHour,
      availableFromDate: availableFromDate ?? this.availableFromDate,
      availableToDate: availableToDate ?? this.availableToDate,
      picupLocation: picupLocation ?? this.picupLocation,
      vehiclePapersDocument:
          vehiclePapersDocument ?? this.vehiclePapersDocument,
      confirmationChecked: confirmationChecked ?? this.confirmationChecked,
      vehicleColor: vehicleColor ?? this.vehicleColor,
      isAc: isAc ?? this.isAc,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vehicle_name': vehicleName,
      'vehicle_type': vehicleType,
      'registration_number': registrationNumber,
      'seating_capacity': seatingCapacity,
      'fuel_type': fuelType,
      'transmission': transmission,
      'rental_price_per_hour': rentalPricePerHour,
      'available_from_date': availableFromDate,
      'available_to_date': availableToDate,
      'picup_location': picupLocation,
      'vehicle_papers_document': vehiclePapersDocument,
      'confirmation_checked': confirmationChecked,
      'vehicle_color': vehicleColor,
      'is_ac': isAc,
      'images': images,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'AddVehicleRequestModel(vehicleName: $vehicleName, vehicleType: $vehicleType, registrationNumber: $registrationNumber, seatingCapacity: $seatingCapacity, fuelType: $fuelType, transmission: $transmission, rentalPricePerHour: $rentalPricePerHour, availableFromDate: $availableFromDate, availableToDate: $availableToDate, picupLocation: $picupLocation, vehiclePapersDocument: $vehiclePapersDocument, confirmationChecked: $confirmationChecked, vehicleColor: $vehicleColor, isAc: $isAc, images: $images)';
  }

  @override
  bool operator ==(covariant AddVehicleRequestModel other) {
    if (identical(this, other)) return true;

    return other.vehicleName == vehicleName &&
        other.vehicleType == vehicleType &&
        other.registrationNumber == registrationNumber &&
        other.seatingCapacity == seatingCapacity &&
        other.fuelType == fuelType &&
        other.transmission == transmission &&
        other.rentalPricePerHour == rentalPricePerHour &&
        other.availableFromDate == availableFromDate &&
        other.availableToDate == availableToDate &&
        other.picupLocation == picupLocation &&
        other.vehiclePapersDocument == vehiclePapersDocument &&
        other.confirmationChecked == confirmationChecked &&
        other.vehicleColor == vehicleColor &&
        other.isAc == isAc &&
        listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return vehicleName.hashCode ^
        vehicleType.hashCode ^
        registrationNumber.hashCode ^
        seatingCapacity.hashCode ^
        fuelType.hashCode ^
        transmission.hashCode ^
        rentalPricePerHour.hashCode ^
        availableFromDate.hashCode ^
        availableToDate.hashCode ^
        picupLocation.hashCode ^
        vehiclePapersDocument.hashCode ^
        confirmationChecked.hashCode ^
        vehicleColor.hashCode ^
        isAc.hashCode ^
        images.hashCode;
  }
}
