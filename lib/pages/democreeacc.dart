// Import necessary packages
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Otpvaerfication.dart';
import 'emailOtp.dart';
import 'login.dart';
import 'package:ohctech/pages/demologin.dart';
import 'package:ohctech/pages/patient_profile.dart';
import 'package:ohctech/pages/setpasswordhitachi.dart';

class createaccount extends StatefulWidget {
  @override
  _createaccountState createState() => _createaccountState();
}

class _createaccountState extends State<createaccount> {
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
    setState(() {
      companyCode = prefs.getString('companyCode') ?? "";
      empid = prefs.getString('empid') ?? "";
      username = prefs.getString('username') ?? "";
      emp_code = prefs.getString('emp_code') ?? "";
      patientname = prefs.getString('patientname') ?? "";
      companyurl = prefs.getString('companyurl') ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCompanyCode();
  }

  TextEditingController EmailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpqasswordController = TextEditingController();
  Future<dynamic> login(BuildContext context) async {
    final response = await http.post(
      Uri.parse('https://tvsm.ohctech.com/api2/democeate.php'),
      body: {
        'email': EmailController.text,
        'patientname': nameController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);  // Add this line to debug and see what the server is returning
      if (data['status'] == 'success') {
        if (_formKey.currentState!.validate()) {
          setState(() {
            changeButton = true;
          });

          await Future.delayed(Duration(seconds: 1));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => demoligin()),
          );
          Fluttertoast.showToast(
            msg: 'Account creation successful',
            backgroundColor: Colors.black,
          );
          setState(() {
            changeButton = false;
          });
        }
      } else {
        passwordController.clear();
        confirmpqasswordController.clear();
        Fluttertoast.showToast(
          msg: 'Invalid Password',
          backgroundColor: Colors.black,
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Password Error'),
          content: Text('Server error'),
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
    return Material(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 90),
              Text(
                "CREATE ACCOUNT",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: EmailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: "Enter Email",
                        labelText: "Enter Email",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email cannot be empty!";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: "Enter Name",
                        labelText: "Enter Name",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name cannot be empty!";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: confirmpqasswordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => login(context),
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
                          "Create Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(changeButton ? 50 : 8),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
