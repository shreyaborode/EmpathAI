import 'package:flutter/material.dart';
import '../caregiver/caregiver_interface.dart';
import '../dashboard.dart';
import '../diagnosis/patient_diagnosis.dart';
import '../doctor/doctor_interface.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        backgroundColor: Colors.teal.shade100,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCustomButton(context, 'Doctor\'s Interface', DoctorInterface()),
            SizedBox(height: 15),
            buildCustomButton(context, 'Caregiver\'s Interface', CaregiverInterface()),
            SizedBox(height: 15),
            buildCustomButton(context, 'Patient Diagnosis', PatientDiagnosis()),
            SizedBox(height: 15),
            buildCustomButton(context, 'Alzheimer\'s Patient', DashboardScreen()),
          ],
        ),
      ),
    );
  }

  Widget buildCustomButton(BuildContext context, String title, Widget screen) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.purple.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        },
        child: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
