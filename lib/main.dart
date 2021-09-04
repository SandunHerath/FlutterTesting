import 'package:flutter/material.dart';
import 'Screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF1FCBCE),
        accentColor: Color(0xFFD3ECF1),
        scaffoldBackgroundColor: Color(0xFFF3F5F7),
      ),
      home:HomeScreen(),
    );
  }
}