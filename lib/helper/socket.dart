import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static IO.Socket? socket;

  void connect() {
    socket = IO.io(
        // 'https://mosque-node-h0996g-h0996gs-projects.vercel.app',
        'https://fiqhpath-deb34fe08f93.herokuapp.com',
        // 'http://192.168.1.19:3000',
        <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': true,
        });

    socket!.connect();

    socket!.onConnect((_) {
      print('Connected to socket server');
    });

    socket!.onDisconnect((_) {
      print('Disconnected from socket server');
    });
  }

  void joinLesson(String lessonId) {
    print('Joining lesson $lessonId');
    socket!.emit('joinLesson', lessonId);
    socket!.off('newComment');
  }

  void leaveLesson(String lessonId) {
    print('Leaving lesson $lessonId');
    socket!.emit('leaveLesson', lessonId);
  }

  void sendComment(
      String lessonId, String comment, String userId, String username) {
    socket!.emit('newComment', {
      'lessonId': lessonId,
      'comment': comment,
      'user': {
        '_id': userId,
        'username': username,
      },
      'createdAt': DateTime.now().toIso8601String(),
    });
  }

  void listenForNewComments(Function(dynamic) callback) {
    socket!.on('newComment', (data) {
      final parsedData = data is String ? jsonDecode(data) : data;
      callback(parsedData);
    });
  }
}
