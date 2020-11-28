import 'package:bandnamesapp/src/pages/home.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: <String, WidgetBuilder>{
        'home': (BuildContext context) => Home(), 
      },
    );
  }
}