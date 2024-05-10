      import 'package:flutter/material.dart';
      import 'package:lab9_cuba/routes.dart';
      

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rutas Nombradas',
      initialRoute: "/",
      routes: routes
    );
  }
}