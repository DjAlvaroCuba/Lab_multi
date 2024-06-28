import 'package:flutter/material.dart';
import 'package:lab_final/page/evento_page.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LAB_FINAL_', 
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductPage(), 
      routes: {
        '/votos': (context) => ProductPage(), 
      },
    );
  }
}
