import 'package:bandnamesapp/src/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text('Server Status: ${socketService.serverStatus}')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: (){
          // Emitir:
          // { nombre: 'Flutter', Mensaje: 'Hola desde flutter' }
          socketService.socket.emit('emitir-mensaje', {
            'nombre': 'Flutter',
            'Mensaje': 'Hola desde flutter'
          });
        },
      ),
    );
  }
}