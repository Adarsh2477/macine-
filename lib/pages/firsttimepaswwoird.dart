
// Import necessary packages
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ohctech/pages/patient_profile.dart';
import 'package:ohctech/pages/setpasswordhitachi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Otpvaerfication.dart';
import 'emailOtp.dart';
import 'login.dart';
class firsttime extends StatefulWidget {
  @override
  _otploginState createState() => _otploginState();
}

class _otploginState extends State<firsttime> {
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();
  String companyCode = "";
  String companyurl = "";
  String empid = "";
  String id = "";
  String emp_code = "";
  String username = "";
  String patientname = "";

  Future<void> _loadCompanyCode() async {
    final prefs = await SharedPreferences.getInstance();
    companyCode = prefs.getString('companyCode') ?? "";
    empid = prefs.getString('empid') ?? "";
    username = prefs.getString('username') ?? "";
    emp_code = prefs.getString('emp_code') ?? "";
    patientname = prefs.getString('patientname') ?? "";
    companyurl = prefs.getString('companyurl') ?? "";
  }
  @override
  void initState() {
    super.initState();
    _loadCompanyCode();
  }
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpqasswordController = TextEditingController();

  Future<dynamic> login(BuildContext context) async {
    http.Response response = await http.post(Uri.parse
      (companyurl+'api2/setpassword.php?emp_code=${emp_code}'), body: {
      'id': empid.toString(),
      'emp_code':emp_code.toString(),
      'password':passwordController.text,
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        if (_formKey.currentState!.validate()) {
          setState(() {
            changeButton = true;
          });

          await Future.delayed(Duration(seconds: 1));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => passwordset()),
          );
          Fluttertoast.showToast(
            msg: 'Passsword Set Successful',
            backgroundColor: Colors.black,
          );
          setState(() {
            changeButton = false;
          });
        }
      } else {
        print(data);
        passwordController.text = "";
        confirmpqasswordController.text="";
        Fluttertoast.showToast(
          msg: 'Invalid Password',
          backgroundColor: Colors.black,
        );
      }

    } else {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('password  Error'),
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
                  SizedBox(height: 90,),
                  Text(
                    "SET PASSWORD",
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
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          hintText: "Enter Password",
                          labelText: "Enter Password",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty!";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters long!";
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
                        controller: confirmpqasswordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          hintText: "Enter Confirm Password",
                          labelText: "Enter Confirm Password",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty!";
                          }
                          if (value != passwordController.text) {
                            return "Passwords do not match!";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters long!";
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
                            "Set Password",
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