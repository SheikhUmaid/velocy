import 'dart:convert';

class EstimatedPriceRequestModel {
  final String? cityName;
  final String? startLocationName;
  final String? endLocationName;
  EstimatedPriceRequestModel({
    this.cityName,
    this.startLocationName,
    this.endLocationName,
  });

  EstimatedPriceRequestModel copyWith({
    String? cityName,
    String? startLocationName,
    String? endLocationName,
  }) {
    return EstimatedPriceRequestModel(
      cityName: cityName ?? this.cityName,
      startLocationName: startLocationName ?? this.startLocationName,
      endLocationName: endLocationName ?? this.endLocationName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'city_name': cityName,
      'start_location_name': startLocationName,
      'end_location_name': endLocationName,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'EstimatedPriceRequestModel(cityName: $cityName, startLocationName: $startLocationName, endLocationName: $endLocationName)';

  @override
  bool operator ==(covariant EstimatedPriceRequestModel other) {
    if (identical(this, other)) return true;

    return other.cityName == cityName &&
        other.startLocationName == startLocationName &&
        other.endLocationName == endLocationName;
  }

  @override
  int get hashCode =>
      cityName.hashCode ^ startLocationName.hashCode ^ endLocationName.hashCode;
}
