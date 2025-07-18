import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeocodingService {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/geocode/json';
  static const String _apiKey = 'YOUR_GOOGLE_MAPS_API_KEY';

  static Future<LatLng?> getCoordinatesFromAddress(String address) async {
    try {
      final String url =
          '$_baseUrl?address=${Uri.encodeComponent(address)}&key=$_apiKey';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['results'] != null && data['results'].isNotEmpty) {
          final location = data['results'][0]['geometry']['location'];
          return LatLng(location['lat'], location['lng']);
        }
      }
    } catch (e) {
      print('Error geocoding address: $e');
    }
    return null;
  }
}
