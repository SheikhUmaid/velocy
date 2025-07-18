import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class DriverLocationService {
  WebSocketChannel? _channel;
  StreamSubscription<Position>? _positionSubscription;
  void Function(Position position)? onPositionUpdate;

  bool _isConnected = false;
  bool _isTracking = false;
  String? _currentRideId;
  String? _receivedOtp;

  static const int _maxReconnectAttempts = 5;
  static const Duration _reconnectDelay = Duration(seconds: 3);
  int _reconnectAttempts = 0;
  Timer? _reconnectTimer;

  static const LocationSettings _locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
  );

  void Function(Map<String, dynamic> message)? onMessageReceived;

  bool get _isChannelActive => _channel != null && _isConnected;

  Future<void> connect(String rideId) async {
    try {
      _currentRideId = rideId;
      final url = 'ws://82.25.104.152:9000/ws/ride-tracking/$rideId/';
      _channel = WebSocketChannel.connect(Uri.parse(url));

      _channel!.stream.listen(
        (event) {
          try {
            final data = jsonDecode(event);
            print('🌐 Server message: $data');
            if (onMessageReceived != null) {
              onMessageReceived!(data);
            }
          } catch (e) {
            print('❌ Error parsing message: $e');
          }
        },
        onError: (error) {
          print('❌ WebSocket error: $error');
          _isConnected = false;
          _attemptReconnection();
        },
        onDone: () {
          print('🔌 WebSocket closed.');
          _isConnected = false;
          _attemptReconnection();
        },
      );

      _isConnected = true;
      _reconnectAttempts = 0;
      print('✅ WebSocket connected to: $url');
    } catch (e) {
      print('❌ Connection error: $e');
      _attemptReconnection();
    }
  }

  void _attemptReconnection() {
    if (_reconnectAttempts < _maxReconnectAttempts && _currentRideId != null) {
      _reconnectAttempts++;
      print('🔄 Reconnect attempt $_reconnectAttempts/$_maxReconnectAttempts');
      _reconnectTimer = Timer(_reconnectDelay, () {
        connect(_currentRideId!);
      });
    } else {
      print('❌ Max reconnection attempts reached.');
    }
  }

  Future<void> startTracking() async {
    if (_isTracking) return;

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw Exception('Location services disabled');

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions permanently denied');
      }

      _positionSubscription = Geolocator.getPositionStream(
        locationSettings: _locationSettings,
      ).listen(
        (Position position) {
          _sendLocationUpdate(position);
        },
        onError: (error) {
          print('❌ Location error: $error');
        },
      );

      _isTracking = true;
      print('📍 Location tracking started.');
    } catch (e) {
      print('❌ Error starting tracking: $e');
      throw e;
    }
  }

  void _sendLocationUpdate(Position position) {
    if (_isChannelActive) {
      final locationData = {
        'type': 'driver_location',
        'latitude': position.latitude,
        'longitude': position.longitude,
        'accuracy': position.accuracy,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      _channel!.sink.add(jsonEncode(locationData));
      print(
        '📤 Driver location sent: ${position.latitude}, ${position.longitude}',
      );
    }

    //  Trigger UI callback
    if (onPositionUpdate != null) {
      onPositionUpdate!(position);
    }
  }

  void stopTracking() {
    _positionSubscription?.cancel();
    _isTracking = false;
    print('⏹️ Location tracking stopped.');
  }

  void updateRideStatus(String status) {
    if (_isChannelActive) {
      final data = {
        'type': 'ride_status',
        'status': status,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      _channel!.sink.add(jsonEncode(data));
      print('📤 Ride status sent: $status');
    }
  }

  void sendMessage(String message) {
    if (_isChannelActive) {
      final data = {
        'type': 'driver_message',
        'message': message,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      _channel!.sink.add(jsonEncode(data));
      print('📤 Message sent: $message');
    }
  }

  void requestOtpFromPassenger() {
    if (_isChannelActive) {
      final data = {
        'type': 'request_otp',
        'message': 'Driver has arrived. Please provide OTP.',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      _channel!.sink.add(jsonEncode(data));
      print('📤 OTP request sent to passenger');
    }
  }

  void sendOtpVerification(bool isValid) {
    if (_isChannelActive) {
      final data = {
        'type': 'otp_verification',
        'is_valid': isValid,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      _channel!.sink.add(jsonEncode(data));
      print('OTP verification sent: $isValid');
    }
  }

  void setReceivedOtp(String otp) {
    _receivedOtp = otp;
    print(' OTP received and stored: $otp');
  }

  bool verifyOtp(String enteredOtp) {
    final isValid = _receivedOtp != null && _receivedOtp == enteredOtp;
    print('OTP verification: $enteredOtp vs $_receivedOtp = $isValid');
    return isValid;
  }

  bool get isConnected => _isConnected;
  bool get isTracking => _isTracking;

  void disconnect() {
    stopTracking();
    _reconnectTimer?.cancel();
    _channel?.sink.close(status.goingAway);
    _isConnected = false;
    _currentRideId = null;
    _reconnectAttempts = 0;
    print('🔌 WebSocket disconnected.');
  }
}
