import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsService {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json';
  static const String _apiKey = 'YOUR_GOOGLE_MAPS_API_KEY';

  static Future<List<LatLng>> getRouteCoordinates(
    LatLng origin,
    LatLng destination,
  ) async {
    try {
      final String url =
          '$_baseUrl?origin=${origin.latitude},${origin.longitude}'
          '&destination=${destination.latitude},${destination.longitude}'
          '&key=$_apiKey';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['routes'] != null && data['routes'].isNotEmpty) {
          final String encodedPolyline =
              data['routes'][0]['overview_polyline']['points'];
          return _decodePoly(encodedPolyline);
        }
      }
    } catch (e) {
      print('Error getting directions: $e');
    }
    return [];
  }

  static List<LatLng> _decodePoly(String poly) {
    var list = <LatLng>[];
    var index = 0;
    var len = poly.length;
    var lat = 0;
    var lng = 0;

    while (index < len) {
      var shift = 0;
      var result = 0;
      int b;
      do {
        b = poly.codeUnitAt(index) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
        index++;
      } while (b >= 0x20);
      var dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = poly.codeUnitAt(index) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
        index++;
      } while (b >= 0x20);
      var dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      list.add(LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble()));
    }

    return list;
  }
}
