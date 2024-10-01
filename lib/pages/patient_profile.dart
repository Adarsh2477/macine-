// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
// import 'package:fl_chart/fl_chart.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:ohctech/pages/patient_appintment.dart';
import 'package:ohctech/pages/patient_dashboard.dart';
import 'package:ohctech/pages/viewdashyboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import "package:flutter/services.dart";
import 'package:ohctech/models/patient.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Emp_code_login.dart';
import 'appointment_edit.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'appointment_opd_edit.dart';
import 'company_code_login.dart';
import 'dropdown.dart';
import 'emailOtp.dart';
import 'fitnesstraking.dart';
import 'login.dart';
class patientProfile extends StatefulWidget {

  // final String userId;
  // const patientProfile({Key key, @required this.userId}) : super(key: key);

  @override
  // patientProfileState createState() => patientProfileState();
  State<patientProfile> createState() => _patientProfileState();
}

class _patientProfileState extends State<patientProfile> {
  bool _loading = false;

  void progress() {
    setState(() {
      _loading = true;
    });

    // Simulating a loading process, you can replace this with your actual logic.
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _loading = false;
      });
    });
  }
  String empid = "";
  String id = "";
  String emp_code = "";
  String username = "";
  String companyurl = "";
  String patientname = "";

  Future<void> _loadCompanyCode() async {
    final prefs = await SharedPreferences.getInstance();
    empid = prefs.getString('empid') ?? "";
    username = prefs.getString('username') ?? "";
    emp_code = prefs.getString('emp_code') ?? "";
    patientname = prefs.getString('patientname') ?? "";
    companyurl = prefs.getString('companyurl') ?? "";
  }

//widget.userId
  late Patient patient;

  // Medicine medicine;
  List _posts = [];

  void _firstLoad() async {
    await Future.delayed(Duration(seconds: 1));
    try {
      final res =
      await http.get(
          Uri.parse(companyurl + 'api2/patient_details_login.php?id=${empid}'));
      setState(() {
        _posts = json.decode(res.body);
        print(_posts);
        print(companyurl);
      });
    } catch (err) {}
    PatientModel.patients = List.from(_posts)
        .map<Patient>((patient) => Patient.fromMap(patient))
        .toList();
  }
  //

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear(); // Clear all stored data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Companycode()), // Navigate to your login page
    );
  }


  _launchURL(id, pdf_url, c_url) async {

    var url = c_url + pdf_url + id.toString();
    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<void> deleterecrd(String id) async {
    await Future.delayed(Duration(seconds: 1));
    try {
      final response = await http.post(
          Uri.parse(companyurl + 'api2/delete_madicine.php'),
          body: {"id": id,
            "status":"CANCELLED"
          });
      var res = jsonDecode(response.body);
      if (res["success"] == "true") {
        print("record delete");
      } else {
        print("some issue");
      }
    } catch (e) {
      print(e);
    }
    // _firstLoad();
  }

  @override
  void initState() {
    super.initState();
    _loadCompanyCode();
    _firstLoad();
    // fetchData();
    // fetchData1();
    // fetchData2();
    // fetchData3();
  }

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: () async {
          // Your custom logic to handle the back button press
          // For example, show a confirmation dialog
          var confirm = await showExitConfirmationDialog(context);
          return confirm;
        },
        child: Scaffold(appBar: AppBar(title: Text("PATIENT DASHBOARD"),
        ),
            floatingActionButton: FloatingActionButton(
              elevation: 0.0,
              child: Icon(Icons.refresh_outlined),
              backgroundColor: Color.fromARGB(255, 3, 188, 255),
              onPressed: () {
                _firstLoad();
                progress();
              },
            ),
            drawer:  Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(patientname,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                    accountEmail: Text(emp_code,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user.png'), // Replace with your profile image
                    ),
                  ),
                  ListTile(
                    title: Text('HOME'),
                    onTap: () {
                      // Add your item 1 action here
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => patientProfile()));
                    },
                  ),
                  ListTile(
                    title: Text('DASHBOARD'),
                    onTap: () {
                      // Add your item 1 action here
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => patientDashBoard()));
                    },
                  ),
                  ListTile(
                    title: Text('FITNESS TRACKING'),
                    onTap: () {
                      // Add your item 1 action here
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => homepage1()));
                    },
                  ),
                  // ExpansionTile(
                  //   title: Text('MY PROFILE'),
                  //   children: [
                  //     ListTile(
                  //       title: Text('Subitem 1'),
                  //       onTap: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => ChartPage()));
                  //         // Add your subitem 1 action here
                  //       },
                  //     ),
                  // // //     // ListTile(
                  // // //     //   title: Text('Subitem 2'),
                  // // //     //   onTap: () {
                  // // //
                  // // //     //     // Add your subitem 2 action here
                  // // //     //   },
                  // // //     // ),
                  //   ],
                  // ),
                  ListTile(
                    title: Text('LOGOUT'),
                    onTap: () {
                      _logout();
                      // Add your item 2 action here
                    },
                  ),
                ],
              ),
            ),
            resizeToAvoidBottomInset: false,
            body:
            Stack(
              children: [
                ListView.builder(
              itemCount: PatientModel.patients?.length ?? 0,
              itemBuilder: (context, index) {
                var data = PatientModel.patients[index];
                return
                  SingleChildScrollView(
                  child:
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Row(children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 80,
                                      backgroundImage: AssetImage(
                                        'assets/images/user.png', // Replace with your image path
                                      ),
                                    ),

                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(10
                                        ),
                                        // padding: EdgeInsets.all(width * 0.03),
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    data.patient_name ?? 'NA',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight
                                                            .bold),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: Text(
                                                  data.emp_code ?? 'NA',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight
                                                          .bold),
                                                ),
                                              ),
                                              SizedBox(height: 10,),

                                            ])),
                                  )
                                ])
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: const Offset(
                                        5.0,
                                        5.0,
                                      ),
                                      blurRadius: 10.0,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0)),
                                ),
                                child: Column(children: [
                                  Container(
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Father Name", style: TextStyle(

                                                  fontWeight: FontWeight
                                                      .bold),),
                                              Text(data.father_name ?? 'NA',
                                                style: TextStyle(
                                                    fontWeight: FontWeight
                                                        .bold),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Gender", style: TextStyle(

                                                  fontWeight: FontWeight
                                                      .bold),),
                                              Text(
                                                data.gender ?? 'NA',
                                                style: TextStyle(

                                                    fontWeight: FontWeight
                                                        .bold),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Date of birth",
                                                style: TextStyle(

                                                    fontWeight: FontWeight
                                                        .bold),),
                                              Text(data.dob ?? 'NA',
                                                style: TextStyle(

                                                    fontWeight: FontWeight
                                                        .bold),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Age", style: TextStyle(

                                                  fontWeight: FontWeight
                                                      .bold),),
                                              Text(data.age.toString() ?? 'NA',
                                                style: TextStyle(

                                                    fontWeight: FontWeight
                                                        .bold),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(height: 20,),
                                  // ElevatedButton(
                                  //   onPressed: () {
                                  //     // Action to perform when the button is pressed
                                  //     Navigator.push(
                                  //                 context,
                                  //                 MaterialPageRoute(
                                  //                     builder: (context) =>
                                  //                         patientappointmet(
                                  //                           patient: data,)));
                                  //   },
                                  //   child: Text('Appointment'),
                                  //   style: ElevatedButton.styleFrom(
                                  //     primary: Colors.grey, // Change this color as needed
                                  //   ),
                                  // ),
                                  IconButton(
                                    icon: Icon(Icons.edit_calendar),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  patientappointmet(
                                                    patient: data,)));
                                    },
                                  ),
                                  Center(child: Text('Click here for appointment',style: TextStyle(fontWeight: FontWeight.bold),)),
                                ])),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child:
                                Card(
                                    elevation: 15,
                                    child: ExpansionTile(
                                        backgroundColor: Colors.white,
                                        title: Text("Patient Basic Info",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        //header title
                                        children: [
                                          SizedBox(height: 10),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                right: 30,
                                                top: 10,
                                                bottom: 10),
                                            // padding: EdgeInsets.all(con3Ht * 0.05),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  offset: const Offset(
                                                    5.0,
                                                    5.0,
                                                  ),
                                                  blurRadius: 10.0,
                                                  spreadRadius: 5,
                                                ),
                                              ],
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(0)),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text(
                                                                "Patient Category",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                            Text(data
                                                                .patient_cat_id ??
                                                                'NA',
                                                                style: TextStyle(

                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text("Phone number",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                            Text(data
                                                                .primary_phone ??
                                                                'NA',
                                                                style: TextStyle(

                                                                    fontWeight: FontWeight
                                                                        .bold)),

                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text("Aadhar no",
                                                                style: TextStyle(

                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                            Text(data
                                                                .aadhar_no ??
                                                                'NA',
                                                                style: TextStyle(

                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          children: [
                                                            Container(
                                                              child: Expanded(
                                                                child: Text(
                                                                    "Village",
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold)),),
                                                            ),
                                                            Container(
                                                              child: Expanded(
                                                                child: Text(data
                                                                    .village ??
                                                                    'NA',textAlign: TextAlign.right,
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text("Post",
                                                                style: TextStyle(

                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                            Text(
                                                                data.post ?? 'NA',
                                                                style: TextStyle(

                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text("Ps",
                                                                style: TextStyle(

                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                            Text(data.ps ?? 'NA',
                                                                style: TextStyle(

                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text("District",
                                                                style: TextStyle(

                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                            Text(
                                                                data.district ??
                                                                    'NA',
                                                                style: TextStyle(

                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text("State",
                                                                style: TextStyle(

                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                            Text(data.state ??
                                                                'NA',
                                                                style: TextStyle(

                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text("Tehsil",
                                                                  style: TextStyle(

                                                                      fontWeight: FontWeight
                                                                          .bold)),
                                                            ),
                                                            Expanded(
                                                              child: Text(data.tehsil ??
                                                                  'NA',textAlign: TextAlign.right,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .bold)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text("Pin code",
                                                                style: TextStyle(

                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                            Text(
                                                                data.pin_code ??
                                                                    'NA',
                                                                style: TextStyle(

                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text(
                                                                "Date of joining",
                                                                style: TextStyle(

                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                            Text(data.doj ?? 'NA',
                                                                style: TextStyle(

                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                      // Padding(
                                                      //   padding: const EdgeInsets.all(5),
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //     MainAxisAlignment.spaceBetween,
                                                      //     children: [
                                                      //       Text("Ohc location",style: TextStyle(
                                                      //           fontWeight: FontWeight.bold)),
                                                      //       Text(  "Dispensary",style: TextStyle(
                                                      //
                                                      //           fontWeight: FontWeight.bold) ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      // Padding(
                                                      //   padding: const EdgeInsets.all(8.0),
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //     MainAxisAlignment.spaceBetween,
                                                      //     children: [
                                                      //       Text("Status",style: TextStyle(
                                                      //
                                                      //           fontWeight: FontWeight.bold)),
                                                      //       Text( data.status ?? '',style: TextStyle(
                                                      //
                                                      //           fontWeight: FontWeight.bold) ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ])),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child:
                                Card(
                                    elevation: 15,
                                    child: ExpansionTile(
                                        backgroundColor: Colors.white,
                                        title: Text("Contacts",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        //header title
                                        children: [
                                          SizedBox(height: 10),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                top: 20,
                                                bottom: 30),
                                            // padding: EdgeInsets.all(con3Ht * 0.05),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  offset: const Offset(
                                                    5.0,
                                                    5.0,
                                                  ),
                                                  blurRadius: 10.0,
                                                  spreadRadius: 5,
                                                ),
                                              ],
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(0)),
                                            ),
                                            child: Column(
                                              children: [
                                                Card(
                                                    elevation: 15,
                                                    child: ExpansionTile(
                                                        backgroundColor: Colors
                                                            .white,
                                                        title: Text("Contacts",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight
                                                                    .bold)),
                                                        //header title
                                                        children: [
                                                          SizedBox(height: 10),
                                                          Container(
                                                            padding: EdgeInsets
                                                                .only(
                                                                left: 20,
                                                                right: 20,
                                                                top: 20,
                                                                bottom: 20),
                                                            // padding: EdgeInsets.all(con3Ht * 0.05),
                                                            decoration: BoxDecoration(
                                                              color: Colors
                                                                  .white,
                                                              boxShadow: <
                                                                  BoxShadow>[
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey,
                                                                  offset: const Offset(
                                                                    5.0,
                                                                    5.0,
                                                                  ),
                                                                  blurRadius: 10.0,
                                                                  spreadRadius: 5,
                                                                ),
                                                              ],
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                      0)),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  decoration: BoxDecoration(),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                          children: [
                                                                            Container(
                                                                              child: Expanded(
                                                                                child: Text(
                                                                                    "Email",
                                                                                    style: TextStyle(

                                                                                        fontWeight: FontWeight
                                                                                            .bold)),),
                                                                            ),
                                                                            Container(
                                                                              child: Expanded(
                                                                                child: Text(
                                                                                    data
                                                                                        .email_id ??
                                                                                        'NA',textAlign: TextAlign.right,
                                                                                    style: TextStyle(

                                                                                        fontWeight: FontWeight
                                                                                            .bold)),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                                "Phone no.",
                                                                                style: TextStyle(

                                                                                    fontWeight: FontWeight
                                                                                        .bold)),
                                                                            Text(
                                                                                data
                                                                                    .primary_phone ??
                                                                                    'NA',
                                                                                style: TextStyle(

                                                                                    fontWeight: FontWeight
                                                                                        .bold)),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ])),
                                                Card(
                                                    elevation: 15,
                                                    child: ExpansionTile(
                                                        backgroundColor: Colors
                                                            .white,
                                                        title: Text("Emergency",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight
                                                                    .bold)),
                                                        //header title
                                                        children: [
                                                          SizedBox(height: 10),
                                                          Container(
                                                            padding: EdgeInsets
                                                                .only(
                                                                left: 20,
                                                                right: 20,
                                                                top: 20,
                                                                bottom: 20),
                                                            // padding: EdgeInsets.all(con3Ht * 0.05),
                                                            decoration: BoxDecoration(
                                                              color: Colors
                                                                  .white,
                                                              boxShadow: <
                                                                  BoxShadow>[
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey,
                                                                  offset: const Offset(
                                                                    5.0,
                                                                    5.0,
                                                                  ),
                                                                  blurRadius: 10.0,
                                                                  spreadRadius: 5,
                                                                ),
                                                              ],
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                      0)),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  decoration: BoxDecoration(),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                                "Primary Person ",
                                                                                style: TextStyle(

                                                                                    fontWeight: FontWeight
                                                                                        .bold)),
                                                                            Text(
                                                                                data
                                                                                    .primary_contact_person ??
                                                                                    'NA',
                                                                                style: TextStyle(

                                                                                    fontWeight: FontWeight
                                                                                        .bold)),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                                "Primary Pho.No",
                                                                                style: TextStyle(

                                                                                    fontWeight: FontWeight
                                                                                        .bold)),
                                                                            Text(
                                                                                data
                                                                                    .primary_contact_no ??
                                                                                    'NA',
                                                                                style: TextStyle(

                                                                                    fontWeight: FontWeight
                                                                                        .bold)),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                                "Secondary Person",
                                                                                style: TextStyle(

                                                                                    fontWeight: FontWeight
                                                                                        .bold)),
                                                                            Text(
                                                                                data
                                                                                    .secondary_contact_person ??
                                                                                    'NA',
                                                                                style: TextStyle(

                                                                                    fontWeight: FontWeight
                                                                                        .bold)),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            6.0),
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                                "Secondary Pho.No",
                                                                                style: TextStyle(

                                                                                    fontWeight: FontWeight
                                                                                        .bold)),
                                                                            Text(
                                                                                data
                                                                                    .secondary_contact_no ??
                                                                                    'NA',
                                                                                style: TextStyle(
                                                                                    fontWeight: FontWeight
                                                                                        .bold)),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ])),
                                              ],
                                            ),
                                          ),
                                        ])),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child:
                                Card(
                                    elevation: 15,
                                    child: ExpansionTile(
                                        backgroundColor: Colors.white,
                                        title: Text("Examination History",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        //header title
                                        children: [
                                          SizedBox(height: 10),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                right: 30,
                                                top: 10,
                                                bottom: 10),
                                            // padding: EdgeInsets.all(con3Ht * 0.05),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  offset: const Offset(
                                                    5.0,
                                                    5.0,
                                                  ),
                                                  blurRadius: 10.0,
                                                  spreadRadius: 5,
                                                ),
                                              ],
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(0)),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 30),
                                                  child: SingleChildScrollView(
                                                    scrollDirection: Axis
                                                        .horizontal,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(height: 10),
                                                        DataTable(
                                                          columns: [
                                                            DataColumn(
                                                                label: Text(
                                                                    'S.N0')),
                                                            DataColumn(
                                                                label: Text(
                                                                    'Medical Examination Type')),
                                                            DataColumn(
                                                                label: Text(
                                                                    'Medical Examination Date')),
                                                            DataColumn(
                                                                label: Text(
                                                                    'Review By Doctor')),
                                                            DataColumn(
                                                                label: Text(
                                                                    'Medical forms')),
                                                            DataColumn(label: Text(
                                                                'Other Supporting Documents')),
                                                          ],
                                                          rows: data
                                                              .checkupform!
                                                              .map(
                                                                  (item) =>
                                                                  DataRow(
                                                                      cells: <
                                                                          DataCell>[
                                                                        DataCell(
                                                                            Text(
                                                                                item
                                                                                    .srno
                                                                                    .toString())),
                                                                        // Replace 'data1' with the actual key from your API response.
                                                                        DataCell(
                                                                            Text(
                                                                                item
                                                                                    .checkup_type_id
                                                                                    .toString())),
                                                                        // Replace 'data2' with the actual key from your API response.
                                                                        DataCell(
                                                                            Text(
                                                                                item
                                                                                    .checkup_date
                                                                                    .toString())),
                                                                        DataCell(
                                                                            Text(
                                                                                item
                                                                                    .doctor_last_attended ??
                                                                                    'NA'
                                                                                        .toString())),
                                                                        DataCell(
                                                                          IconButton(
                                                                            icon: Icon(
                                                                                Icons
                                                                                    .picture_as_pdf),
                                                                            onPressed: () {
                                                                              _launchURL(
                                                                                  item
                                                                                      .checkup_id,
                                                                                  "checkup_form_pdf.php?checkup_id=",
                                                                                  companyurl);
                                                                            },
                                                                          ),
                                                                        ),
                                                                        DataCell(
                                                                            data.checkupform![index].Docu!.isNotEmpty &&
                                                                          item.checkup_id == data.checkupform![index].Docu![index].checkup_id?
                                                                            IconButton(
                                                                              icon: Icon(
                                                                                  Icons.picture_as_pdf),
                                                                              onPressed: () {
                                                                                _launchURL(
                                                                                    data.checkupform![index].Docu![index].checkup_id,
                                                                                    "api2/checkup_medical_mobile_document.php?checkup_id=",
                                                                                    companyurl);
                                                                                },):SizedBox()),
                                                                      ])
                                                          ).toList(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ])),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child:
                                Card(
                                    elevation: 15,
                                    child: ExpansionTile(
                                        backgroundColor: Colors.white,
                                        title: Text("Opd And Injury",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        //header title
                                        children: [
                                          SizedBox(height: 10),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 30),
                                            child:
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 10),
                                                  DataTable(
                                                    columns: [
                                                      DataColumn(
                                                          label: Text('S.N0')),
                                                      DataColumn(label: Text(
                                                          'Appointment type')),
                                                      DataColumn(label: Text(
                                                          'Appointment Date')),
                                                      DataColumn(label: Text(
                                                          'Attended By')),
                                                      DataColumn(label: Text(
                                                          'Prescription')),
                                                      DataColumn(label: Text(
                                                          'Other Supporting Documents')),
                                                    ],
                                                    rows: data.appointment
                                                    !.map(
                                                          (item) =>
                                                          DataRow(
                                                              cells: <DataCell>[
                                                                DataCell(Text(
                                                                    item.srno
                                                                        .toString())),
                                                                // Replace 'data1' with the actual key from your API response.
                                                                DataCell(Text(
                                                                    item.type
                                                                        .toString())),
                                                                // Replace 'data2' with the actual key from your API response.
                                                                DataCell(
                                                                    Text(item
                                                                        .appointment_date
                                                                        .toString())),
                                                                DataCell(
                                                                    Text(item
                                                                        .doctor_last_attended
                                                                        .toString())),
                                                                DataCell(
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      if (item
                                                                          .type ==
                                                                          'OPD')
                                                                        IconButton(
                                                                            icon: Icon(
                                                                                Icons
                                                                                    .picture_as_pdf),
                                                                            onPressed: () {
                                                                              _launchURL(
                                                                                  item
                                                                                      .appointment_id,
                                                                                  "opd_form_pdf.php?appointment_id_pdf=",
                                                                                  companyurl);
                                                                            }
                                                                        ),
                                                                      if (item
                                                                          .type ==
                                                                          'INJURY')
                                                                        IconButton(
                                                                            icon: Icon(
                                                                                Icons
                                                                                    .picture_as_pdf),
                                                                            onPressed: () {
                                                                              _launchURL(
                                                                                  item
                                                                                      .appointment_id,
                                                                                  "injury_form_pdf.php?appointment_id_pdf=",
                                                                                  companyurl);
                                                                            }
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                DataCell(
                                                                    data.appointment![index].Docuu!.isNotEmpty &&
                                                                        item.appointment_id == data.appointment![index].Docuu![index].appointment_id?
                                                                    IconButton(
                                                                      icon: Icon(
                                                                          Icons.picture_as_pdf),
                                                                      onPressed: () {
                                                                        _launchURL(
                                                                            data.appointment![index].Docuu![index].appointment_id,
                                                                            "api2/medical_mobile_document.php?appointment_id=",
                                                                            companyurl);
                                                                      },):SizedBox()),
                                                              ]),
                                                    ).toList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ])),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child:
                                Card(
                                    elevation: 15,
                                    child: ExpansionTile(
                                        backgroundColor: Colors.white,
                                        title: Text("Sickness",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        //header title
                                        children: [
                                          SizedBox(height: 10),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                right: 30,
                                                top: 10,
                                                bottom: 10),
                                            // padding: EdgeInsets.all(con3Ht * 0.05),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  offset: const Offset(
                                                    5.0,
                                                    5.0,
                                                  ),
                                                  blurRadius: 10.0,
                                                  spreadRadius: 5,
                                                ),
                                              ],
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(0)),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 30),
                                                  child: SingleChildScrollView(
                                                    scrollDirection: Axis
                                                        .horizontal,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(height: 10),
                                                        DataTable(
                                                          columns: [
                                                            DataColumn(
                                                                label: Text(
                                                                    'S.N0')),
                                                            DataColumn(
                                                                label: Text(
                                                                    'Ailment Name')),
                                                            DataColumn(
                                                                label: Text(
                                                                    'Sickness Date')),
                                                            DataColumn(
                                                                label: Text(
                                                                    'Doctor Last Attended')),
                                                            DataColumn(
                                                                label: Text(
                                                                    '')),
                                                          ],
                                                          rows: data.sickness
                                                          !.map(
                                                                (item) =>
                                                                DataRow(
                                                                    cells: <
                                                                        DataCell>[
                                                                      DataCell(
                                                                          Text(
                                                                              item
                                                                                  .srno
                                                                                  .toString() ??
                                                                                  'NA')),
                                                                      // Replace 'data1' with the actual key from your API response.
                                                                      DataCell(
                                                                          Text(
                                                                              item
                                                                                  .ailment_name
                                                                                  .toString() ??
                                                                                  'NA')),
                                                                      // Replace 'data2' with the actual key from your API response.
                                                                      DataCell(
                                                                          Text(
                                                                              item
                                                                                  .sickness_date
                                                                                  .toString() ??
                                                                                  'NA')),
                                                                      DataCell(
                                                                          Text(
                                                                              item
                                                                                  .doctor_last_attended
                                                                                  .toString() ??
                                                                                  'NA')),
                                                                      DataCell(
                                                                        IconButton(
                                                                          icon: Icon(
                                                                              Icons
                                                                                  .picture_as_pdf),
                                                                          onPressed: () {
                                                                            if (item
                                                                                .fitness_status ==
                                                                                'APPROVED') {
                                                                              _launchURL(
                                                                                  item
                                                                                      .sickness_id,
                                                                                  "fitness_certificate.php?flex_sickness_id=",
                                                                                  companyurl);
                                                                            } else {
                                                                              _launchURL(
                                                                                  item
                                                                                      .sickness_id,
                                                                                  "unfit_certificate.php?flex_sickness_id=",
                                                                                  companyurl);
                                                                            }
                                                                            //_launchURL(item.sickness_id,"fitness_certificate.php?flex_sickness_id=",companyurl);
                                                                            // Navigator.of(context).push(
                                                                            //   MaterialPageRoute(
                                                                            //     builder: (context) => SicknessPreview(patient: data ,patient1: item,),
                                                                            //   ),
                                                                            // );

                                                                          },
                                                                        ),
                                                                      ),
                                                                    ]),
                                                          ).toList(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ])),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child:
                                Card(
                                    elevation: 15,
                                    child: ExpansionTile(
                                        backgroundColor: Colors.white,
                                        title: Text("Document",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        //header title
                                        children: [
                                          SizedBox(height: 10),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                right: 30,
                                                top: 10,
                                                bottom: 10),
                                            // padding: EdgeInsets.all(con3Ht * 0.05),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  offset: const Offset(
                                                    5.0,
                                                    5.0,
                                                  ),
                                                  blurRadius: 10.0,
                                                  spreadRadius: 5,
                                                ),
                                              ],
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(0)),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 30),
                                                  child: SingleChildScrollView(
                                                    scrollDirection: Axis
                                                        .horizontal,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(height: 10),
                                                        DataTable(
                                                          columns: [
                                                            DataColumn(
                                                                label: Text(
                                                                    'S.N0')),
                                                            DataColumn(
                                                                label: Text(
                                                                    'Document Name')),
                                                            DataColumn(
                                                                label: Text(
                                                                    'Uploaded Date')),
                                                            DataColumn(
                                                                label: Text(
                                                                    'Download link')),
                                                            DataColumn(
                                                                label: Text(
                                                                    'Old Document')),
                                                          ],
                                                          rows: data
                                                              .Document!
                                                              .map(
                                                                  (item) =>
                                                                  DataRow(
                                                                      cells: <
                                                                          DataCell>[
                                                                        DataCell(
                                                                            Text(
                                                                                item
                                                                                    .srno
                                                                                    .toString())),
                                                                        // Replace 'data1' with the actual key from your API response.
                                                                        DataCell(
                                                                            Text(
                                                                                item
                                                                                    .docname
                                                                                    .toString())),
                                                                        // Replace 'data2' with the actual key from your API response.
                                                                        DataCell(
                                                                            Text(
                                                                                item
                                                                                    .UploadedDate
                                                                                    .toString())),
                                                                        DataCell(
                                                                            IconButton(
                                                                              icon: Icon(
                                                                                  Icons.picture_as_pdf),
                                                                              onPressed: () {
                                                                                _launchURL(
                                                                                    item.empid,
                                                                                    "api2/document_profile.php?emp_id=",
                                                                                    companyurl);
                                                                              },)),
                                                                        DataCell(
                                                                            data.Document![index].Docufile!.isNotEmpty?
                                                                            IconButton(
                                                                              icon: Icon(
                                                                                  Icons.picture_as_pdf),
                                                                              onPressed: () {
                                                                                _launchURL(
                                                                                  data.Document![index].Docufile![index].file_name,
                                                                                    "download_doc_emp_wise.php?file=" ,companyurl);
                                                                              },):SizedBox()),
                                                                      ])
                                                          ).toList(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ])),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child:
                                Card(
                                    elevation: 15,
                                    child: ExpansionTile(
                                        backgroundColor: Colors.white,
                                        title: Text("Chronic Illness",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        //header title
                                        children: [
                                          SizedBox(height: 10),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                right: 30,
                                                top: 10,
                                                bottom: 10),
                                            // padding: EdgeInsets.all(con3Ht * 0.05),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  offset: const Offset(
                                                    5.0,
                                                    5.0,
                                                  ),
                                                  blurRadius: 10.0,
                                                  spreadRadius: 5,
                                                ),
                                              ],
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(0)),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 30),
                                                  child: SingleChildScrollView(
                                                    scrollDirection: Axis
                                                        .horizontal,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(height: 10),
                                                        DataTable(
                                                          columns: [
                                                            DataColumn(
                                                                label: Text(
                                                                    'S.N0')),
                                                            DataColumn(
                                                                label: Text(
                                                                    'Chronic Illness')),
                                                            DataColumn(
                                                                label: Text(
                                                                    'Chronic Medication')),
                                                          ],
                                                          rows: data
                                                              .chronicIllness!
                                                              .map(
                                                                  (item) =>
                                                                  DataRow(
                                                                      cells: <
                                                                          DataCell>[
                                                                        DataCell(
                                                                            Text(
                                                                                item
                                                                                    .srno
                                                                                    .toString())),
                                                                        // Replace 'data1' with the actual key from your API response.
                                                                        DataCell(
                                                                            Text(
                                                                                item
                                                                                    .diseases
                                                                                    .toString())),
                                                                        // Replace 'data2' with the actual key from your API response.
                                                                        DataCell(
                                                                            Text(
                                                                                item
                                                                                    .medicine_name
                                                                                    .toString())),
                                                                      ])
                                                          ).toList(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ])),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child:
                                Card(
                                    elevation: 15,
                                    child: ExpansionTile(
                                        backgroundColor: Colors.white,
                                        title: Text("Appointment Details ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                        //header title
                                        children: [
                                          SizedBox(height: 10),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                right: 30,
                                                top: 10,
                                                bottom: 10),
                                            // padding: EdgeInsets.all(con3Ht * 0.05),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  offset: const Offset(
                                                    5.0,
                                                    5.0,
                                                  ),
                                                  blurRadius: 10.0,
                                                  spreadRadius: 5,
                                                ),
                                              ],
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(0)),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 30),
                                                  child: SingleChildScrollView(
                                                    scrollDirection: Axis
                                                        .horizontal,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(height: 10),
                                                        DataTable(
                                                          columns: [
                                                            DataColumn(
                                                                label: Text(
                                                                    'S.N0')),
                                                            // DataColumn(label: Text('Doctor Name')),
                                                            DataColumn(
                                                                label: Text(
                                                                    ' Date')),
                                                            DataColumn(
                                                                label: Text(
                                                                    'Time' ?? "")),
                                                            // DataColumn(label: Text(' Day')),
                                                            DataColumn(
                                                                label: Text(
                                                                    'Appointment Type')),
                                                            DataColumn(
                                                                label: Text(
                                                                    'Status')),
                                                            DataColumn(
                                                                label: Text(
                                                                    'Cancel')),
                                                            DataColumn(
                                                                label: Text('')),
                                                          ],
                                                          rows: data
                                                              .Appointmentview
                                                          !.map(
                                                                (item) =>
                                                                DataRow(
                                                                    cells: <
                                                                        DataCell>[
                                                                      DataCell(
                                                                          Text(
                                                                              item
                                                                                  .srno
                                                                                  .toString())),
                                                                      // Replace 'data1' with the actual key from your API response.
                                                                      // DataCell(Text(item['doctor_id'].toString())), // Replace 'data2' with the actual key from your API response.
                                                                      DataCell(
                                                                          Text(
                                                                              item
                                                                                  .date
                                                                                  .toString())),
                                                                      DataCell(
                                                                          Text(
                                                                              item
                                                                                  .time
                                                                                  .toString())),
                                                                      // DataCell(Text(item['day'].toString())),
                                                                      DataCell(
                                                                          Text(
                                                                              item
                                                                                  .app_type
                                                                                  .toString())),
                                                                      DataCell(
                                                                          Text(
                                                                              item
                                                                                  .status
                                                                                  .toString())),
                                                    DataCell(
                                                      item.status == 'Approved'
                                                          ? SizedBox() // Hide the cancel icon if status is approved
                                                          : IconButton(
                                                        icon: Icon(Icons.delete),
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return AlertDialog(
                                                                title: Text("Cancel Appointment"),
                                                                content: Text(
                                                                    "Are you sure you want to cancel this appointment?"),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      Navigator.of(context).pop(); // Close the dialog
                                                                    },
                                                                    child: Text("No"),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      deleterecrd(item.id ?? '');
                                                                      // Navigator.of(context).pop();
                                                                      Navigator.of(context).push(
                                                                        MaterialPageRoute(
                                                                          builder: (context) => patientProfile(),
                                                                        ),
                                                                      );
                                                                      // Close the dialog
                                                                    },
                                                                    child: Text("Yes"),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    DataCell(
                                                        item.status == 'Approved'
                                                            ? SizedBox() // Hide the edit icon if status is approved
                                                            : IconButton(
                                                          icon: Icon(Icons.edit),
                                                          onPressed: () {
                                                            if (item.app_type == 'Annual Medical Checkup') {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => appointmentedit(
                                                                    patient: data,
                                                                    appintment: item,
                                                                  ),
                                                                ),
                                                              );
                                                            } else {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => updateopdappoint(
                                                                    patient: data,
                                                                    appintment: item,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                    ),
                                                                    ]),
                                                          ).toList(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ])),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
                if (_loading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ),
                  ),
            ]
            ),

        ),
      );
  }
  Future<bool> showExitConfirmationDialog(BuildContext context) async {
    // Custom logic for back button press
    // For example, show a confirmation dialog
     var exit = await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Confirm Exit'),
            content: Text('Are you sure you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
    },
                child: Text('Yes'),
              ),
            ],
          ),
    );

    // If the user confirms, exit the app
    return exit ?? false;
  }
}