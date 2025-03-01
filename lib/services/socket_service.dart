import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  late IO.Socket socket;

  factory SocketService() => _instance;

  SocketService._internal();

  void initSocket() {
    socket = IO.io('ws://10.0.2.2:3001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false, 
      'reconnection': true,
      'reconnectionAttempts': 5,
      'reconnectionDelay': 2000,
    });
    socket.connect();
    socket.onConnect((_) {
      print('Connected to WebSocket Server');
    });

    socket.onDisconnect((_) {
      print('Disconnected from WebSocket Server');
    });

    socket.onConnectError((err) {
      print('Connection Error: $err');
    });

    socket.onError((err) {
      print('Socket Error: $err');
    });
  }

  void connect() => socket.connect();
  void disconnect() => socket.disconnect();
  void joinRoom(String roomId){
    socket.emit('join_room', {
      "data": {"chatRoomId": roomId}
    });
  }
  IO.Socket getSocket() => socket;
}