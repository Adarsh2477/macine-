
import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:ohctech/models/Doctor.dart';
import 'package:http/http.dart'as http;
import 'package:ohctech/pages/datetime_selection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Appintment.dart';
import '../models/patient.dart';
import 'appintment_selection_wigit.dart';
class patientappointmet extends StatefulWidget {
  final Patient patient;

  const patientappointmet(
      {Key? key, required this.patient,})
  // ignore: unnecessary_null_comparison
      : super(key: key);
  @override
  _patientappointmetState createState() => _patientappointmetState();
}

class _patientappointmetState extends State<patientappointmet> {
  String companyCode = "";
  String companyurl = "";

  Future<void> _loadCompanyCode() async {
    final prefs = await SharedPreferences.getInstance();
    companyCode = prefs.getString('companyCode') ?? "";
    companyurl = prefs.getString('companyurl') ?? "";
  }

  late Appintment appintment;
  List _posts = [];
  void _firstLoad() async {
    await Future.delayed(Duration(seconds: 1));
    try {
      final res =
      await http.get(Uri.parse(companyurl+'api2/appointment_type_api.php'));
      setState(() {
        _posts = json.decode(res.body);
        print(_posts);
      });
    } catch (err) {
    }
    AppintmentModel.appintment = List.from(_posts)
        .map<Appintment>((appintment) => Appintment.fromJson(appintment))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _loadCompanyCode();
    _firstLoad();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Selection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: AppintmentModel.appintment?.length?? 0,
          itemBuilder: (context, index) {
            final appintment =AppintmentModel.appintment[index];
            return appintmentselection(appintment:appintment,patient: widget.patient,);
          },
        ),
      ),
    );
  }
}
