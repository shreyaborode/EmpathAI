import 'package:flutter/material.dart';
import 'Patient/startpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alzheimer\'s App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: StartPage(),
    );
  }
}
