import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';

enum ServerStatus{
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;

  SocketService(){
    _initConfig();
  }

  void _initConfig(){
    // Dart client
    IO.Socket socket = IO.io('http://192.168.0.5:4000', <String, dynamic> {
      'transports': ['websocket'],
      'autoConnect': true
    });

    socket.onConnect((_) => print('connect'));

    socket.onDisconnect((_) => print('disconnect'));
  }
}