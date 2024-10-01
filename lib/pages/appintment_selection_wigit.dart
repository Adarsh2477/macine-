import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:ohctech/models/Doctor.dart';

import '../models/Appintment.dart';
import '../models/patient.dart';
import 'datetime_selection.dart';
import 'medical_exam_date_sel.dart';

class appintmentselection extends StatelessWidget {
  final Patient patient;
  final Appintment appintment;
  const appintmentselection(
      {Key? key, required this.patient,required this.appintment})
  // ignore: unnecessary_null_comparison
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(onTap: () {
        if(appintment.opd=="Annual Medical Checkup"){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => medicalexmdate(appintment: appintment,patient: patient,)));
        }else{
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookingPage(appintment: appintment,patient: patient,)));
        }
      },
        child: Card(
          elevation: 4, // Adjust the elevation for a shadow effect
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  appintment.opd ?? "",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Icon(
                Icons.arrow_forward,
                size: 48, // Adjust the icon size as needed
                color: Colors.amber,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
