import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static IO.Socket? socket;

  void initSocket() {
    socket = IO.io('http://192.168.1.20:3000',
        IO.OptionBuilder().setTransports(['websocket']).build());
    socket!.connect();
    socket!.onConnect((_) {
      print('Connected to WebSocket Server');
    });
    socket!.on('newComment', (data) {
      // Handle the new comment
      print('New comment received: $data');
    });
  }
}
