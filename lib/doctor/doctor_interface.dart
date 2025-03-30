import 'package:flutter/material.dart';

class DoctorInterface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor's Interface"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text(
          "Welcome to the Doctor's Interface",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
