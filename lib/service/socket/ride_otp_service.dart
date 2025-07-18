import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class RideOTPService {
  WebSocketChannel? _channel;
  Function(String)? onOTPReceived;

  void connectToOTPChannel({required Function(String) onOTP}) {
    final url = 'ws://82.25.104.152/ws/rider/otp/';
    _channel = WebSocketChannel.connect(Uri.parse(url));
    this.onOTPReceived = onOTP;

    _channel!.stream.listen((message) {
      final data = jsonDecode(message);
      if (data['type'] == 'otp') {
        onOTP(data['otp']); // Send OTP back to UI
      }
    });
  }

  void disconnect() {
    _channel?.sink.close();
  }
}
