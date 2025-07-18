import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velocy_user_app/service/socket/web_socket_services.dart';
import 'package:velocy_user_app/view/module/driver/driver_cab_tracking/driver_cab_tracking_services/direction_services.dart';
import 'package:velocy_user_app/view/module/driver/driver_cab_tracking/driver_cab_tracking_services/geo_coding_services.dart';
import 'package:velocy_user_app/view/module/driver/recent_rides_page/model/ride_details_model.dart';

// class LiveTrackingDriverPage extends StatefulWidget {
//   final String rideId;
//   final RideDetailsModel rideDetails;

//   const LiveTrackingDriverPage({
//     super.key,
//     required this.rideId,
//     required this.rideDetails,
//   });

//   @override
//   State<LiveTrackingDriverPage> createState() => _LiveTrackingDriverPageState();
// }

// class _LiveTrackingDriverPageState extends State<LiveTrackingDriverPage> {
//   GoogleMapController? _mapController;
//   final RideTrackingService _trackingService = RideTrackingService();

//   Marker? _driverMarker;
//   Marker? _pickupMarker;
//   Marker? _destinationMarker;
//   Set<Polyline> _polylines = {};
  
//   bool _mapReady = false;
//   String socketStatus = 'Disconnected';
//   LatLng? _currentDriverPosition;
//   bool _isLoadingRoute = true;

//   // Default coordinates (Bangalore)
//   LatLng _pickupLatLng = const LatLng(12.9716, 77.5946);
//   LatLng _destinationLatLng = const LatLng(12.9716, 77.5946);

//   @override
//   void initState() {
//     super.initState();
//     _initializeMap();
//     _startTracking();
//   }

//   Future<void> _initializeMap() async {
//     // await _getCoordinates();
//     await _createStaticMarkers();
//     await _drawRoute();
//     setState(() {
//       _isLoadingRoute = false;
//     });
//   }

//   // Future<void> _getCoordinates() async {
//   //   // If coordinates are already available in the model, use them
//   //   if (widget.rideDetails.fromLatitude != null && widget.rideDetails.fromLongitude != null) {
//   //     _pickupLatLng = LatLng(widget.rideDetails.fromLatitude!, widget.rideDetails.fromLongitude!);
//   //   } else {
//   //     // Otherwise, geocode the address
//   //     final pickupCoords = await GeocodingService.getCoordinatesFromAddress(widget.rideDetails.fromLocation);
//   //     if (pickupCoords != null) {
//   //       _pickupLatLng = pickupCoords;
//   //     }
//   //   }

//   //   if (widget.rideDetails.toLatitude != null && widget.rideDetails.toLongitude != null) {
//   //     _destinationLatLng = LatLng(widget.rideDetails.toLatitude!, widget.rideDetails.toLongitude!);
//   //   } else {
//   //     final destinationCoords = await GeocodingService.getCoordinatesFromAddress(widget.rideDetails.toLocation);
//   //     if (destinationCoords != null) {
//   //       _destinationLatLng = destinationCoords;
//   //     }
//   //   }
//   // }

//   Future<void> _createStaticMarkers() async {
//     setState(() {
//       _pickupMarker = Marker(
//         markerId: const MarkerId("pickup"),
//         position: _pickupLatLng,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//         infoWindow: InfoWindow(
//           title: "Pickup Location",
//           snippet: widget.rideDetails.fromLocation,
//         ),
//       );

//       _destinationMarker = Marker(
//         markerId: const MarkerId("destination"),
//         position: _destinationLatLng,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//         infoWindow: InfoWindow(
//           title: "Destination",
//           snippet: widget.rideDetails.toLocation,
//         ),
//       );
//     });
//   }

//   Future<void> _drawRoute() async {
//     final routeCoordinates = await DirectionsService.getRouteCoordinates(_pickupLatLng, _destinationLatLng);
    
//     if (routeCoordinates.isNotEmpty) {
//       setState(() {
//         _polylines = {
//           Polyline(
//             polylineId: const PolylineId("route"),
//             points: routeCoordinates,
//             color: Colors.blue,
//             width: 4,
//             patterns: [PatternItem.dash(20), PatternItem.gap(10)],
//           ),
//         };
//       });
//     }
//   }

//   void _startTracking() {
//     _trackingService.connect(widget.rideId);

//     _trackingService.onConnected = () {
//       setState(() => socketStatus = 'Connected ✅');
//       debugPrint("[WebSocket] Connected");
//     };

//     _trackingService.onDisconnected = () {
//       setState(() => socketStatus = 'Disconnected ❌');
//       debugPrint("[WebSocket] Disconnected");
//     };

//     _trackingService.onError = (error) {
//       setState(() => socketStatus = 'Error ⚠️');
//       debugPrint("[WebSocket] Error: $error");
//     };

//     _trackingService.locationStream.listen((location) {
//       debugPrint("[WebSocket] Location received in UI: $location");

//       final position = LatLng(location['latitude']!, location['longitude']!);
//       _currentDriverPosition = position;

//       setState(() {
//         _driverMarker = Marker(
//           markerId: const MarkerId("driver"),
//           position: position,
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//           infoWindow: InfoWindow(
//             title: "Driver",
//             snippet: "Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}",
//           ),
//         );
//       });

//       debugPrint("[WebSocket] Driver marker updated at: ${position.latitude}, ${position.longitude}");

//       if (_mapReady && _mapController != null) {
//         _mapController!.animateCamera(
//           CameraUpdate.newLatLngZoom(position, 16),
//         );
//         debugPrint("[WebSocket] Map camera moved to driver position");
//       }
//     }, onError: (error) {
//       debugPrint("[WebSocket] Error in location stream: $error");
//     });
//   }

//   void _fitMarkersInView() {
//     if (_mapController == null) return;

//     final List<LatLng> positions = [];
//     if (_driverMarker != null) positions.add(_driverMarker!.position);
//     if (_pickupMarker != null) positions.add(_pickupMarker!.position);
//     if (_destinationMarker != null) positions.add(_destinationMarker!.position);

//     if (positions.isNotEmpty) {
//       final bounds = _calculateBounds(positions);
//       _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
//     }
//   }

//   LatLngBounds _calculateBounds(List<LatLng> positions) {
//     double minLat = positions.first.latitude;
//     double maxLat = positions.first.latitude;
//     double minLng = positions.first.longitude;
//     double maxLng = positions.first.longitude;

//     for (LatLng position in positions) {
//       minLat = minLat < position.latitude ? minLat : position.latitude;
//       maxLat = maxLat > position.latitude ? maxLat : position.latitude;
//       minLng = minLng < position.longitude ? minLng : position.longitude;
//       maxLng = maxLng > position.longitude ? maxLng : position.longitude;
//     }

//     return LatLngBounds(
//       southwest: LatLng(minLat, minLng),
//       northeast: LatLng(maxLat, maxLng),
//     );
//   }

//   @override
//   void dispose() {
//     _mapController?.dispose();
//     _trackingService.disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final model = widget.rideDetails;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Live Tracking"),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.fit_screen),
//             onPressed: _fitMarkersInView,
//             tooltip: "Fit all markers in view",
//           ),
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               _trackingService.disconnect();
//               _startTracking();
//             },
//             tooltip: "Reconnect",
//           ),
//           IconButton(
//             icon: const Icon(Icons.bug_report),
//             onPressed: () {
//               // Test with mock location data
//               _trackingService.simulateLocationUpdate(12.9716, 77.5946);
//             },
//             tooltip: "Test Location",
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: _pickupLatLng,
//               zoom: 14,
//             ),
//             onMapCreated: (controller) {
//               _mapController = controller;
//               setState(() => _mapReady = true);
//               // Fit all markers in view after map is ready
//               Future.delayed(const Duration(milliseconds: 1000), () {
//                 _fitMarkersInView();
//               });
//             },
//             markers: {
//               if (_driverMarker != null) _driverMarker!,
//               if (_pickupMarker != null) _pickupMarker!,
//               if (_destinationMarker != null) _destinationMarker!,
//             },
//             polylines: _polylines,
//             myLocationEnabled: true,
//             myLocationButtonEnabled: true,
//             zoomControlsEnabled: true,
//             mapToolbarEnabled: false,
//             compassEnabled: true,
//             tiltGesturesEnabled: true,
//             rotateGesturesEnabled: true,
//             scrollGesturesEnabled: true,
//             zoomGesturesEnabled: true,
//           ),

//           // 🔼 RIDE DETAILS CARD
//           Positioned(
//             top: 10,
//             left: 10,
//             right: 10,
//             child: Card(
//               elevation: 6,
//               color: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         const Icon(Icons.location_city, color: Colors.blue, size: 20),
//                         const SizedBox(width: 8),
//                         Expanded(child: Text("City: ${model.city}", style: const TextStyle(fontWeight: FontWeight.w500))),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         const Icon(Icons.my_location, color: Colors.green, size: 20),
//                         const SizedBox(width: 8),
//                         Expanded(child: Text("From: ${model.fromLocation}", style: const TextStyle(fontSize: 13))),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         const Icon(Icons.location_on, color: Colors.red, size: 20),
//                         const SizedBox(width: 8),
//                         Expanded(child: Text("To: ${model.toLocation}", style: const TextStyle(fontSize: 13))),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         const Icon(Icons.directions_car, color: Colors.orange, size: 20),
//                         const SizedBox(width: 8),
//                         Text("Vehicle: ${model.vehicleType}", style: const TextStyle(fontWeight: FontWeight.w500)),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         const Icon(Icons.currency_rupee, color: Colors.purple, size: 20),
//                         const SizedBox(width: 8),
//                         Text("Estimated: ₹${model.estimatedPrice}", style: const TextStyle(fontWeight: FontWeight.w500)),
//                         const Spacer(),
//                         Text("Offered: ₹${model.offeredPrice}", style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.green)),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         const Icon(Icons.wifi, size: 20),
//                         const SizedBox(width: 8),
//                         Text(
//                           "Socket: $socketStatus",
//                           style: TextStyle(
//                             color: socketStatus.contains('Connected') 
//                                 ? Colors.green 
//                                 : socketStatus.contains('Error')
//                                     ? Colors.orange
//                                     : Colors.red,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         const Icon(Icons.gps_fixed, size: 20),
//                         const SizedBox(width: 8),
//                         Text(
//                           _currentDriverPosition != null 
//                               ? "Driver: ${_currentDriverPosition!.latitude.toStringAsFixed(4)}, ${_currentDriverPosition!.longitude.toStringAsFixed(4)}"
//                               : "Driver: No location yet",
//                           style: TextStyle(
//                             color: _currentDriverPosition != null ? Colors.blue : Colors.grey,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           // Loading indicator
//           if (_isLoadingRoute || _driverMarker == null)
//             Container(
//               color: Colors.black26,
//               child: const Center(
//                 child: Card(
//                   child: Padding(
//                     padding: EdgeInsets.all(20),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         CircularProgressIndicator(),
//                         SizedBox(height: 16),
//                         Text('Loading route and waiting for driver location...'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   } }

