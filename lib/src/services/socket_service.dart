import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';

enum ServerStatus{
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  SocketService(){
    _initConfig();
  }

  void _initConfig(){
    // Dart client
    this._socket = IO.io('http://192.168.0.5:4000', <String, dynamic> {
      'transports' : ['websocket'],
      'autoConnect': true
    });

    this._socket.onConnect((_){
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.onDisconnect((_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    // socket.on('nuevo-mensaje', ( payload ){
    //   print('Nuevo-mensaje:');
    //   print(payload['nombre']);
    //   print(payload['mensaje']);
    //   print(payload['mensaje2']);
    // });


  }
}