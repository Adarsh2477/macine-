import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ohctech/models/patient.dart';
import 'package:ohctech/pages/login.dart';
import 'package:ohctech/utils/routes.dart';
import 'package:pricing_cards/pricing_cards.dart';
// import 'package:ohctech/widgets/drawer.dart';
import 'package:fluid_action_card/FluidActionCard/fluid_action_card.dart';
import 'package:heroicons/heroicons.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../widgets/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String empid = "";
  String username = "";
  String companyurl = "";
  Future<void> _loadCompanyCode() async {
    final prefs = await SharedPreferences.getInstance();
    empid = prefs.getString('empid') ?? "";
    username = prefs.getString('username') ?? "";
    companyurl = prefs.getString('companyurl') ?? "";
  }


  @override
  void initState() {
    super.initState();
      _loadCompanyCode();
      // getUserdetails();
      loadData();
  }

  // void getUserdetails() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //
  //   setState(() {
  //     usrname = preferences.getString('usrname')?? '';
  //   });
  // }

  // void logout(BuildContext context) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.remove("usrname")??'';
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
  //     return LoginPage();
  //   }));
  //
  //   Fluttertoast.showToast(
  //     msg: 'You are logged out!!',
  //     backgroundColor: Colors.black,
  //   );
  //
  //   await Future.delayed(Duration(seconds: 1));
  //   await Navigator.pushNamed(context, MyRoutes.loginRoute);
  // }
  void loadData() async {
    await Future.delayed(Duration(seconds: 1));
    var urlOPD = companyurl + 'api2/patient_count.php';
    print(urlOPD);
    print(username);
    var response = await http.get(Uri.parse(urlOPD));

    var patientJson = response.body.toString();

    var decodedData = jsonDecode(patientJson);
    var patientsData = decodedData;

    print(patientsData);
    print(urlOPD);
    PatientModel.patients = List.from(patientsData)
        .map<Patient>((patient) => Patient.fromMap(patient))
        .toList();

    setState(() {});
  }

  Future<void> moveToOpd(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    await Navigator.pushNamed(context, MyRoutes.opdRoute);
  }

  Future<void> moveToInjury(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    await Navigator.pushNamed(context, MyRoutes.injuryRoute);
  }

  Future<void> moveToMedExam(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    await Navigator.pushNamed(context, MyRoutes.medExamRoute);
  }

  Future<void> moveToReports(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    await Navigator.pushNamed(context, MyRoutes.reportsRoute);
  }

  Future<void> moveToSickness(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    await Navigator.pushNamed(context, MyRoutes.sicknessRoute);
  }

  Future<void> moveToapprovedOpd(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    await Navigator.pushNamed(context, MyRoutes.approvedOpdRoute);
  }

  Future<void> moveToapprovedInjury(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    await Navigator.pushNamed(context, MyRoutes.approvedInjuryRoute);
  }

  Future<void> moveToapprovedMedical(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    await Navigator.pushNamed(context, MyRoutes.approvedMedicalRoute);
  }

  Future<void> moveToapprovedSickness(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    await Navigator.pushNamed(context, MyRoutes.approvedSicknessRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "OHC TECH - Daily Statistics",
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: Icon(Icons.refresh_outlined),
          backgroundColor: Color.fromARGB(255, 3, 188, 255),
          onPressed: () {
            loadData();
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 2,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: 30.w,
                      height: 27.h,
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Color(0xfff8683a),
                        elevation: 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            (PatientModel.patients.isNotEmpty)
                                ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: PatientModel.patients.length,
                              itemBuilder: (context, index) {
                                var patient =
                                PatientModel.patients[index];
                                return ListTile(
                                  leading: Image.asset(
                                    "assets/images/st1.png",
                                    fit: BoxFit.contain,
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                  title: Text(
                                    'OPD',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 25.sp,
                                        color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    'Approved Case: (${patient.approved_opd_count})               Pending Case: (${patient.pending_opd_count}) ',
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      color:
                                      Color.fromARGB(255, 239, 237, 237),
                                    ),
                                  ),
                                );
                              },
                            )
                                : Center(
                              child: CircularProgressIndicator(),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(10),
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        Colors.cyan[300]),
                                  ),
                                  child: Text(
                                    'Approved ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    moveToapprovedOpd(context);
                                  },
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(10),
                                    backgroundColor:
                                    MaterialStateProperty.all(Colors.amber),
                                  ),
                                  child: Text(
                                    'Pending ',
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    moveToOpd(context);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: 30.w,
                      height: 27.h,
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Color.fromARGB(255, 189, 3, 3),
                        elevation: 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            (PatientModel.patients.isNotEmpty)
                                ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: PatientModel.patients.length,
                              itemBuilder: (context, index) {
                                var patient =
                                PatientModel.patients[index];
                                return ListTile(
                                  leading: Image.asset(
                                    "assets/images/injury1.png",
                                    fit: BoxFit.contain,
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                  title: Text(
                                    'INJURY',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 25.sp,
                                        color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    'Approved Case: (${patient.approved_injury_count})               Pending Case: (${patient.pending_injury_count}) ',
                                    style: TextStyle(
                                        fontSize: 12.0.sp,
                                        color: Color.fromARGB(
                                            255, 239, 237, 237)),
                                  ),
                                );
                              },
                            )
                                : Center(
                              child: CircularProgressIndicator(),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(10),
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        Colors.cyan[300]),
                                  ),
                                  child: Text(
                                    'Approved ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    moveToapprovedInjury(context);
                                  },
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(10),
                                    backgroundColor:
                                    MaterialStateProperty.all(Colors.amber),
                                  ),
                                  child: Text(
                                    'Pending ',
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    moveToInjury(context);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: 30.w,
                      height: 27.h,
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Color.fromARGB(255, 49, 130, 222),
                        elevation: 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            (PatientModel.patients.isNotEmpty)
                                ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: PatientModel.patients.length,
                              itemBuilder: (context, index) {
                                var patient =
                                PatientModel.patients[index];
                                return ListTile(
                                  leading: Image.asset(
                                    "assets/images/medexam.png",
                                    fit: BoxFit.contain,
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                  title: Text(
                                    'EXAMINATION',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 22.sp,
                                        color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    'Approved Case: (${patient.approved_medical_count})               Pending Case: (${patient.pending_medical_count}) ',
                                    style: TextStyle(
                                        fontSize: 12.0.sp,
                                        color: Color.fromARGB(
                                            255, 239, 237, 237)),
                                  ),
                                );
                              },
                            )
                                : Center(
                              child: CircularProgressIndicator(),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(10),
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        Colors.cyan[300]),
                                  ),
                                  child: Text(
                                    'Approved ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    moveToapprovedMedical(context);
                                  },
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(10),
                                    backgroundColor:
                                    MaterialStateProperty.all(Colors.amber),
                                  ),
                                  child: Text(
                                    'Pending ',
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    moveToMedExam(context);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: 30.w,
                      height: 27.h,
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Color.fromARGB(255, 25, 170, 17),
                        elevation: 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            (PatientModel.patients.isNotEmpty)
                                ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: PatientModel.patients.length,
                              itemBuilder: (context, index) {
                                var patient =
                                PatientModel.patients[index];
                                return ListTile(
                                  leading: Image.asset(
                                    "assets/images/fittt.png",
                                    fit: BoxFit.contain,
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                  title: Text(
                                    'FITNESS',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 25.sp,
                                        color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    'Approved Case: (${patient.approved_sickness_count})               Pending Case: (${patient.pending_sickness_count}) ',
                                    style: TextStyle(
                                        fontSize: 12.0.sp,
                                        color: Color.fromARGB(
                                            255, 239, 237, 237)),
                                  ),
                                );
                              },
                            )
                                : Center(
                              child: CircularProgressIndicator(),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(10),
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        Colors.cyan[300]),
                                  ),
                                  child: Text(
                                    'Approved ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    moveToapprovedSickness(context);
                                  },
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(10),
                                    backgroundColor:
                                    MaterialStateProperty.all(Colors.amber),
                                  ),
                                  child: Text(
                                    'Pending ',
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    moveToSickness(context);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        drawer: MyDrawer(text: username,empid: empid,),
      );
    });
  }
}
