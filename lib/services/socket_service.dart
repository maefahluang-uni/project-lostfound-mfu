import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  late IO.Socket _socket;

  factory SocketService() {
    return _instance;
  }
  static final String? socketUrl = dotenv.env['SOCKET_URL'];

  SocketService._internal();

  Future<void> initSocket() async {
    _socket = IO.io(socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'reconnection': true,
      'reconnectionAttempts': 5,
      'reconnectionDelay': 2000,
    });

    _socket.connect();
    _socket.onConnect((_) {
      print("Socket Connected");
    });

    _socket.onDisconnect((_) {
      print("Socket Disconnected");
    });
  }

  void joinRoom(String chatRoomId) {
    print("JOINING ROOM!");
    _socket.emit('join_room', {
      "data": {"chatRoomId": chatRoomId}
    });
    print("Joined room: $chatRoomId");
  }

  void listenForRefresh(Function(String) onRefresh) {
    _socket.on("refresh", (data) {
      print("Refresh received for room: $data");
      onRefresh(data);
    });
  }
  
    void disconnect() {
    _socket.disconnect();
  }
}