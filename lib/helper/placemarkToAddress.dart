import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image/image.dart';

String placemarkToAddressString(Placemark? place, {String? defaultValue}) {
  if (place == null) return defaultValue ?? 'Unknown location';

  debugPrint(
    "===========> name: ${place.name}, subLocality: ${place.subLocality}, Locality: ${place.locality}, administrativeArea: ${place.administrativeArea}, postalCode: ${place.postalCode}, country: ${place.country}",
  );
  return [
    place.name,
    // place.subLocality,
    place.locality,
    place.administrativeArea,
    // place.postalCode,
    place.country,
  ].where((element) => element != null && element.trim().isNotEmpty).join(', ');
}
