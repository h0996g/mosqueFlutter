import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connect() {
    socket = IO.io('http://192.168.6.68:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.connect();

    socket.onConnect((_) {
      print('Connected to socket server');
    });

    socket.onDisconnect((_) {
      print('Disconnected from socket server');
    });
  }

  void joinLesson(String lessonId) {
    print('Joining lesson $lessonId');
    socket.emit('joinLesson', lessonId);
  }

  void leaveLesson(String lessonId) {
    print('Leaving lesson $lessonId');
    socket.emit('leaveLesson', lessonId);
  }

  void sendComment(
      String lessonId, String comment, String userId, String onModel) {
    socket.emit('newComment', {
      'lessonId': lessonId,
      'comment': comment,
      'userId': userId,
      'onModel': onModel,
    });
  }

  void listenForNewComments(Function(dynamic) callback) {
    socket.on('newComment', (data) {
      final parsedData = data is String ? jsonDecode(data) : data;
      callback(parsedData);
    });
  }
}
