import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class RideTrackingService {
  WebSocketChannel? _channel;
  void connect(String rideId) {
    final url = 'ws://82.25.104.152:9000/ws/ride-tracking/$rideId/';

    _channel = WebSocketChannel.connect(Uri.parse(url));
  }

  // Listen to driver location updates
  Stream<Map<String, double>> get locationStream {
    return _channel!.stream.map((event) {
      final data = jsonDecode(event);
      return {'latitude': data['latitude'], 'longitude': data['longitude']};
    });
  }

  void disconnect() {
    _channel?.sink.close();
  }
}
