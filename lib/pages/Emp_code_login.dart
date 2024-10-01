// Import necessary packages
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ohctech/pages/patient_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Otpvaerfication.dart';
import 'emailOtp.dart';
import 'login.dart';
class Emp_code_login extends StatefulWidget {
  @override
  _otploginState createState() => _otploginState();
}

class _otploginState extends State<Emp_code_login> {
  Future<void> _startDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1500),
      lastDate: DateTime(8101),
    );

    if (picked != null && picked != DateTime.now()) {
      // Format the selected date as needed
      String formattedDate = "${picked.day}-${picked.month}-${picked.year}";
      otpController.text = formattedDate;
    }
  }
  bool changeButton = false;
  bool isLoggedIn = false;
  final _formKey = GlobalKey<FormState>();
  String companyCode = "";
  String companyurl = "";

  Future<void> _loadCompanyCode() async {
    final prefs = await SharedPreferences.getInstance();
    companyCode = prefs.getString('companyCode') ?? "";
    companyurl = prefs.getString('companyurl') ?? "";
  }
  @override
  void initState() {
    super.initState();
    _loadCompanyCode();
    _checkLoggedInStatus();
  }

  Future<void> _checkLoggedInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      // Navigate to profile page if already logged in
      _navigateToProfilePage();
    }
  }

  void _navigateToProfilePage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => patientProfile(),
    ));
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  Future<dynamic> login(BuildContext context) async {
    http.Response response = await http.post(Uri.parse
      (companyurl + 'api2/emp_code_login.php'), body: {
      'emp_code': emailController.text,
      'dob': otpController.text,
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('emp_code', emailController.text);
      prefs.setString('empid', data['emp_id']?? '');
      prefs.setString('patientname', data['patient_name']?? '');
      if (data['status'] == 'true') {
        if (_formKey.currentState!.validate()) {
          setState(() {
            changeButton = true;
          });

          await Future.delayed(Duration(seconds: 1));
          Fluttertoast.showToast(
            msg: 'Login Successful',
            backgroundColor: Colors.black,
          );

          // Mark user as logged in
          prefs.setBool('isLoggedIn', true);

          // Navigate to profile page
          _navigateToProfilePage();
          setState(() {
            changeButton = false;
          });
        }
      } else {
        print(data);
        emailController.text = "";
        otpController.text = "";
        Fluttertoast.showToast(
          msg: 'Invalid Emp_code',
          backgroundColor: Colors.black,
        );
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text('Login Error'),
                content: Text('Invalid Emp_code. & Dob'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              ),
        );
      }

    } else {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Login Error'),
              content: Text('server error'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Material(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.jpeg",
                    fit: BoxFit.contain,
                    height: 200,
                    width: 300,
                  ),
                  Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Column(children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          hintText: "Enter Emp Code",
                          labelText: "Emp Code",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Emp code cannot be empty!";
                          }
                          return null;
                        },
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Column(children: [
                      TextFormField(
                        controller: otpController,
                        readOnly: true,
                                onTap: () {
                                  // Open date picker when TextField is clicked
                                  _startDate(context);
                                },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          hintText: "Enter Date Of Birth",
                          labelText: " Date Of Birth",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Dob code cannot be empty!";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        child:
                        GestureDetector(
                          onTap: () {
                            // Navigate to a new screen when text is clicked
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => emailotplogin()),
                            );
                          },
                          child: Center(
                            child: Text(
                              'Login Via Email Otp ',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      InkWell(
                        onTap: () =>  login(context),
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          width: changeButton ? 50 : 150,
                          height: 50,
                          alignment: Alignment.center,
                          child: changeButton
                              ? const Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                              : Text(
                            "LOGIN",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius:
                              BorderRadius.circular(changeButton ? 50 : 8)),
                        ),
                      ),
                    ]),
                  )
                ]
            ),

          ),
        ),
      );
  }
}