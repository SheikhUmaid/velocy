import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

class CustomRouteMapView extends StatefulWidget {
  final String pickup;
  final String drop;
  final List<String> stops;
  final double height;

  const CustomRouteMapView({
    super.key,
    required this.pickup,
    required this.drop,
    required this.stops,
    this.height = 250,
  });

  @override
  State<CustomRouteMapView> createState() => _CustomRouteMapViewState();
}

class _CustomRouteMapViewState extends State<CustomRouteMapView> {
  final Completer<GoogleMapController> _mapController = Completer();
  LatLng? pickupLatLng;
  LatLng? dropoffLatLng;
  List<LatLng> stopCoordinates = [];
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await _initializeLocations();
    });
  }

  Future<void> _initializeLocations() async {
    debugPrint(
      "Initializing locations: Pickup: ${widget.pickup}, Dropoff: ${widget.drop}, Stops: ${widget.stops}",
    );
    try {
      final pickupLocations = await locationFromAddress(widget.pickup);
      final dropLocations = await locationFromAddress(widget.drop);

      final tempStopCoords = <LatLng>[];
      for (String stop in widget.stops) {
        final locations = await locationFromAddress(stop);
        if (locations.isNotEmpty) {
          tempStopCoords.add(
            LatLng(locations.first.latitude, locations.first.longitude),
          );
        }
      }

      setState(() {
        pickupLatLng = LatLng(
          pickupLocations.first.latitude,
          pickupLocations.first.longitude,
        );
        dropoffLatLng = LatLng(
          dropLocations.first.latitude,
          dropLocations.first.longitude,
        );
        stopCoordinates = tempStopCoords;
        _polylines.clear();
      });

      await _drawRoutePolyline();
      await _moveCameraToBounds();
    } catch (e) {
      print("Geocoding error: $e");
    }
  }

  Future<void> _drawRoutePolyline() async {
    final points = [pickupLatLng!, ...stopCoordinates, dropoffLatLng!];

    for (int i = 0; i < points.length - 1; i++) {
      final origin = points[i];
      final destination = points[i + 1];
      final url =
          'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=${"AIzaSyCMnUiAvEu6ytGmFvZXF4R0Do0j0ON6axY"}';

      try {
        final response = await http.get(Uri.parse(url));
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          final polylinePoints =
              data['routes'][0]['overview_polyline']['points'];
          final List<LatLng> decodedPoints = _decodePolyline(polylinePoints);

          final polyline = Polyline(
            polylineId: PolylineId('route_$i'),
            color: Colors.blue,
            width: 5,
            points: decodedPoints,
          );

          setState(() => _polylines.add(polyline));
        } else {
          print('Directions API error: ${data['status']}');
        }
      } catch (e) {
        print("Polyline decoding error: $e");
      }
    }
  }

  Future<void> _moveCameraToBounds() async {
    final controller = await _mapController.future;
    final allPoints = [pickupLatLng!, ...stopCoordinates, dropoffLatLng!];

    final southwestLat = allPoints
        .map((e) => e.latitude)
        .reduce((a, b) => a < b ? a : b);
    final southwestLng = allPoints
        .map((e) => e.longitude)
        .reduce((a, b) => a < b ? a : b);
    final northeastLat = allPoints
        .map((e) => e.latitude)
        .reduce((a, b) => a > b ? a : b);
    final northeastLng = allPoints
        .map((e) => e.longitude)
        .reduce((a, b) => a > b ? a : b);

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(southwestLat, southwestLng),
          northeast: LatLng(northeastLat, northeastLng),
        ),
        50,
      ),
    );
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0) ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0) ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return polyline;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
      "Map page Pickup: $pickupLatLng, Dropoff: $dropoffLatLng, Stops: $stopCoordinates",
    );
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child:
          pickupLatLng == null || dropoffLatLng == null
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: pickupLatLng!,
                  zoom: 14,
                ),
                polylines: _polylines,
                markers: {
                  Marker(
                    markerId: const MarkerId("pickup"),
                    position: pickupLatLng!,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue,
                    ),
                  ),
                  Marker(
                    markerId: const MarkerId("dropoff"),
                    position: dropoffLatLng!,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed,
                    ),
                  ),
                  ...List.generate(stopCoordinates.length, (index) {
                    return Marker(
                      markerId: MarkerId('stop$index'),
                      position: stopCoordinates[index],
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueOrange,
                      ),
                    );
                  }),
                },
                onMapCreated: (controller) {
                  if (!_mapController.isCompleted) {
                    _mapController.complete(controller);
                  }
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
              ),
    );
  }
}
