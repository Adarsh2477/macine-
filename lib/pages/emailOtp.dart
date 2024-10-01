// Import necessary packages
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Otpvaerfication.dart';
import 'login.dart';
class emailotplogin extends StatefulWidget {
  @override
  _otploginState createState() => _otploginState();
}

class _otploginState extends State<emailotplogin> {
  bool changeButton = false;
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
  }
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  Future<dynamic> login(BuildContext context) async {
      http.Response response = await http.post(Uri.parse
        (companyurl + 'api2/emailsender.php'), body: {
        'offiial_email_id': emailController.text,
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('email_id', data['offiial_email_id'].toString());
          prefs.setString('emp_code',data['emp_code'].toString());
          prefs.setString('empid', data['emp_id']?? '');
          prefs.setString('patientname', data['patient_name']?? '');
          print(data);
          // var data = response.body;
          // print(data + " DM");
          if (data['status'] == 'true') {
            Fluttertoast.showToast(
              msg: 'Otp Send Successfully',
              backgroundColor: Colors.black,
            );
            if (_formKey.currentState!.validate()) {
              setState(() {
                changeButton = true;
              });

              await Future.delayed(Duration(seconds: 1));
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => otplogin(),
                ),
              );
              setState(() {
                changeButton = false;
              });
            }
          } else {
            print(data);
            emailController.text = "";
            Fluttertoast.showToast(
              msg: 'Invalid Email',
              backgroundColor: Colors.black,
            );
            showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(
                    title: Text('Error'),
                    content: Text('Invalid Email.'),
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
              "Email Login",
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
                        hintText: "Enter Email",
                        labelText: "Email",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email cannot be empty!";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30.0,
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
                          "Send Otp",
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