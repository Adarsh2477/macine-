import 'package:flutter/material.dart';
import 'package:ohctech/models/patient.dart';
import 'package:ohctech/pages/button.dart';
import 'package:ohctech/pages/login.dart';
import 'package:ohctech/pages/patient_profile.dart';

class AppointmentSucess extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text('Sucessfully Booked',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              child: ElevatedButton(
                child: Text('Evaluate'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
