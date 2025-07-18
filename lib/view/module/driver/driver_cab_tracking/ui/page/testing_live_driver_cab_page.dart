import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:velocy_user_app/helper/routes_helper.dart';
import 'package:velocy_user_app/service/socket/web_socket_services.dart';

class TestLiveTrackingPage extends StatefulWidget {
  final String rideId;
  final String passengerName;
  final String destinationAddress;

  const TestLiveTrackingPage({
    Key? key,
    required this.rideId,
    required this.passengerName,
    required this.destinationAddress,
  }) : super(key: key);

  @override
  State<TestLiveTrackingPage> createState() => _DriverTrackingPageState();
}

class _DriverTrackingPageState extends State<TestLiveTrackingPage> {
  late GoogleMapController _mapController;
  final DriverLocationService _locationService = DriverLocationService();

  LatLng? _driverLatLng;
  LatLng? _passengerLatLng;

  Polyline? _routePolyline;
  Set<Marker> _markers = {};

  String _rideStatus = 'on_way_to_pickup';
  bool _isTracking = false;
  String _connectionStatus = "Connecting...";
  String? _receivedOtp;

  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeTracking();
  }

  Future<void> _initializeTracking() async {
    try {
      await _locationService.connect(widget.rideId);

      // Get actual driver location first, don't use hardcoded value
      await _getCurrentLocation();

      _locationService.onMessageReceived = (data) {
        if (data['type'] == 'passenger_otp') {
          setState(() {
            _receivedOtp = data['otp'];
          });
          _locationService.setReceivedOtp(data['otp']);
          _showOtpReceivedDialog();
        } else if (data.containsKey('latitude') &&
            data.containsKey('longitude')) {
          print("📩 Received from server: $data");

          final newPassengerLatLng = LatLng(
            data['latitude'],
            data['longitude'],
          );
          print('🟢 Passenger location updated: $newPassengerLatLng');
          setState(() {
            _passengerLatLng = newPassengerLatLng;
            _updatePolyline();
          });
        }
      };

      _locationService.onPositionUpdate = (position) {
        final updatedDriverLatLng = LatLng(
          position.latitude,
          position.longitude,
        );
        print('📍 Driver location updated: $updatedDriverLatLng');

        setState(() {
          _driverLatLng = updatedDriverLatLng;
          _updatePolyline();
        });

        // Only animate camera if map controller is ready
        if (_mapController != null) {
          _mapController.animateCamera(
            CameraUpdate.newLatLng(updatedDriverLatLng),
          );
        }
      };

      await _locationService.startTracking();

      setState(() {
        _isTracking = _locationService.isTracking;
        _connectionStatus =
            _locationService.isConnected ? "Connected" : "Disconnected";
      });
    } catch (e) {
      setState(() {
        _connectionStatus = "Error: $e";
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _driverLatLng = LatLng(position.latitude, position.longitude);
      });
      print('📍 Initial driver location: $_driverLatLng');
      _updatePolyline();
    } catch (e) {
      print('Error getting current location: $e');
      // Fallback to Delhi coordinates only if location access fails
      setState(() {
        _driverLatLng = const LatLng(28.7041, 77.1025);
      });
    }
  }

  void _updatePolyline() {
    print('🔵 Called _updatePolyline');
    print('Driver Location: $_driverLatLng');
    print('Passenger Location: $_passengerLatLng');

    if (_driverLatLng != null && _passengerLatLng != null) {
      // Calculate distance between driver and passenger
      double distanceInMeters = Geolocator.distanceBetween(
        _driverLatLng!.latitude,
        _driverLatLng!.longitude,
        _passengerLatLng!.latitude,
        _passengerLatLng!.longitude,
      );

      print(
        '📏 Distance between driver and passenger: ${distanceInMeters.toStringAsFixed(2)} meters',
      );

      // Always create polyline if both locations exist, even if they're very close
      final polyline = Polyline(
        polylineId: const PolylineId('route'),
        color: Colors.red, // Changed to red for better visibility
        width: 8, // Increased width for better visibility
        points: [_driverLatLng!, _passengerLatLng!],
        patterns: [
          PatternItem.dash(15),
          PatternItem.gap(8),
        ], // More visible pattern
      );

      setState(() {
        _routePolyline = polyline;
      });

      print('✅ Polyline updated with points: ${polyline.points}');

      // Auto-zoom to show both points if they're close
      if (distanceInMeters < 100) {
        // Less than 100 meters
        _fitBothMarkers();
      }
    } else {
      print('❌ One or both LatLngs are null. Polyline not created.');
      setState(() {
        _routePolyline = null;
      });
    }
  }

  void _fitBothMarkers() {
    if (_driverLatLng != null &&
        _passengerLatLng != null &&
        _mapController != null) {
      // Calculate bounds that include both markers
      double minLat =
          _driverLatLng!.latitude < _passengerLatLng!.latitude
              ? _driverLatLng!.latitude
              : _passengerLatLng!.latitude;
      double maxLat =
          _driverLatLng!.latitude > _passengerLatLng!.latitude
              ? _driverLatLng!.latitude
              : _passengerLatLng!.latitude;
      double minLng =
          _driverLatLng!.longitude < _passengerLatLng!.longitude
              ? _driverLatLng!.longitude
              : _passengerLatLng!.longitude;
      double maxLng =
          _driverLatLng!.longitude > _passengerLatLng!.longitude
              ? _driverLatLng!.longitude
              : _passengerLatLng!.longitude;

      // Add some padding to the bounds
      double latPadding = (maxLat - minLat) * 0.5;
      double lngPadding = (maxLng - minLng) * 0.5;

      // Ensure minimum padding for very close points
      if (latPadding < 0.001) latPadding = 0.001;
      if (lngPadding < 0.001) lngPadding = 0.001;

      _mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(minLat - latPadding, minLng - lngPadding),
            northeast: LatLng(maxLat + latPadding, maxLng + lngPadding),
          ),
          100.0, // Padding in pixels
        ),
      );
    }
  }

  void _showOtpReceivedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: const Text('OTP Received'),
            content: Text('Passenger has provided OTP: $_receivedOtp'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showOtpVerificationDialog();
                },
                child: const Text('Verify OTP'),
              ),
            ],
          ),
    );
  }

  void _showOtpVerificationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: const Text('Enter OTP'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Enter OTP from passenger:'),
                const SizedBox(height: 16),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: '****',
                    border: OutlineInputBorder(),
                    counterText: '',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _otpController.clear();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _verifyOtp,
                child: const Text('Verify'),
              ),
            ],
          ),
    );
  }

  void _verifyOtp() {
    String enteredOtp = _otpController.text.trim();

    if (enteredOtp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter OTP'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    bool isValid = _locationService.verifyOtp(enteredOtp);

    if (isValid) {
      _locationService.sendOtpVerification(true);
      Navigator.pop(context);
      _updateRideStatus('in_progress');
      _otpController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP verified! Ride started.'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      _locationService.sendOtpVerification(false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid OTP. Try again.'),
          backgroundColor: Colors.red,
        ),
      );
      _otpController.clear();
    }
  }

  void _updateRideStatus(String status) {
    setState(() {
      _rideStatus = status;
    });
    _locationService.updateRideStatus(status);
  }

  void _requestOtp() {
    _locationService.requestOtpFromPassenger();
    _updateRideStatus('waiting_for_otp');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('OTP request sent to passenger'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      _locationService.sendMessage(_messageController.text.trim());
      _messageController.clear();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Message sent')));
    }
  }

  Widget _buildRideControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Passenger: ${widget.passengerName}'),
          Text('Destination: ${widget.destinationAddress}'),
          const SizedBox(height: 8),
          _buildLocationInfo(),
          const SizedBox(height: 8),
          _buildStatusButtons(),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Get.toNamed(Routes.driverCabTracking.value, arguments: 39);
            },
            child: Text("Notifiy Arrival "),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Send message...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.blue),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInfo() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Driver: ${_driverLatLng?.latitude.toStringAsFixed(6) ?? 'Unknown'}, ${_driverLatLng?.longitude.toStringAsFixed(6) ?? 'Unknown'}',
            style: const TextStyle(fontSize: 12, color: Colors.blue),
          ),
          Text(
            'Passenger: ${_passengerLatLng?.latitude.toStringAsFixed(6) ?? 'Unknown'}, ${_passengerLatLng?.longitude.toStringAsFixed(6) ?? 'Unknown'}',
            style: const TextStyle(fontSize: 12, color: Colors.green),
          ),
          if (_driverLatLng != null && _passengerLatLng != null)
            Text(
              'Distance: ${Geolocator.distanceBetween(_driverLatLng!.latitude, _driverLatLng!.longitude, _passengerLatLng!.latitude, _passengerLatLng!.longitude).toStringAsFixed(0)} meters',
              style: const TextStyle(fontSize: 12, color: Colors.orange),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusButtons() {
    switch (_rideStatus) {
      case 'on_way_to_pickup':
        return ElevatedButton(
          onPressed: _requestOtp,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          child: const Text('Arrived - Request OTP'),
        );
      case 'waiting_for_otp':
        return Column(
          children: [
            const Text('Waiting for passenger OTP...'),
            OutlinedButton(
              onPressed: _showOtpVerificationDialog,
              child: const Text('Enter OTP Manually'),
            ),
          ],
        );
      case 'in_progress':
        return ElevatedButton(
          onPressed: () => _updateRideStatus('completed'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Complete Ride'),
        );
      case 'completed':
        return ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('End Tracking'),
        );
      default:
        return const SizedBox();
    }
  }

  @override
  void dispose() {
    _locationService.disconnect();
    _messageController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver Tracking"),
        backgroundColor: Colors.blue,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: _locationService.isConnected ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _locationService.isConnected ? 'ONLINE' : 'OFFLINE',
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            color: _isTracking ? Colors.green.shade100 : Colors.orange.shade100,
            child: Row(
              children: [
                Icon(
                  _isTracking ? Icons.gps_fixed : Icons.gps_off,
                  color: _isTracking ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  _isTracking ? 'Tracking Active' : 'Tracking Inactive',
                  style: TextStyle(
                    color: _isTracking ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _driverLatLng ?? const LatLng(28.7041, 77.1025),
                zoom: 16,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
                // Move camera to driver location if available
                if (_driverLatLng != null) {
                  controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: _driverLatLng!,
                        zoom:
                            18, // Higher zoom for better visibility of close points
                      ),
                    ),
                  );
                }
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              trafficEnabled: true,
              markers: {
                if (_driverLatLng != null)
                  Marker(
                    markerId: const MarkerId('driver'),
                    position: _driverLatLng!,
                    infoWindow: InfoWindow(
                      title: 'Driver (You)',
                      snippet:
                          'Lat: ${_driverLatLng!.latitude.toStringAsFixed(6)}, Lng: ${_driverLatLng!.longitude.toStringAsFixed(6)}',
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue,
                    ),
                  ),
                if (_passengerLatLng != null)
                  Marker(
                    markerId: const MarkerId('passenger'),
                    position: _passengerLatLng!,
                    infoWindow: InfoWindow(
                      title: 'Passenger: ${widget.passengerName}',
                      snippet:
                          'Lat: ${_passengerLatLng!.latitude.toStringAsFixed(6)}, Lng: ${_passengerLatLng!.longitude.toStringAsFixed(6)}',
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueOrange,
                    ),
                  ),
              },
              polylines: _routePolyline != null ? {_routePolyline!} : {},
            ),
          ),
          _buildRideControls(),
        ],
      ),
    );
  }
}
