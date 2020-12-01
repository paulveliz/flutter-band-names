import 'package:bandnamesapp/src/pages/home.dart';
import 'package:bandnamesapp/src/pages/status.dart';
import 'package:bandnamesapp/src/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(create: (_) =>  new SocketService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: <String, WidgetBuilder>{
          'home': (BuildContext context) => Home(), 
          'status': (BuildContext context) => StatusPage(), 
        },
      ),
    );
  }
}