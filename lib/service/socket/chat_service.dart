import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class RideChatService {
  WebSocketChannel? _channel;

  void connect({required String rideId, required String token}) {
    final url = Uri.parse(
      'ws://82.25.104.152/ws/chat/$rideId/?token=$token', // Replace with your actual domain
    );

    _channel = WebSocketChannel.connect(url);
  }

  Stream<Map<String, String>> get messages {
    return _channel!.stream.map((event) {
      final data = jsonDecode(event);
      return {'message': data['message'], 'sender': data['sender']};
    });
  }

  void sendMessage(String message) {
    final data = jsonEncode({'message': message});
    _channel?.sink.add(data);
  }

  void disconnect() {
    _channel?.sink.close();
  }
}
