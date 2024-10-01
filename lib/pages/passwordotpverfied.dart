// ignore_for_file: prefer_const_constructors, duplicate_import, unnecessary_import, use_build_context_synchronously, sort_child_properties_last, unused_import
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ohctech/pages/hitachilogin.dart';
import 'dart:convert';
// import 'package:ohctech/pages/home.dart';
import 'package:ohctech/pages/login.dart';
import 'package:connectivity/connectivity.dart';
import 'package:ohctech/pages/patient_profile.dart';
import 'package:ohctech/pages/resetpassword.dart';
import 'package:ohctech/pages/setpasswordhitachi.dart';
import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/routes.dart';
import 'Emp_code_login.dart';
class otpverfied extends StatefulWidget {
  @override
  State<otpverfied> createState() => _otpverfiedState();
}

class _otpverfiedState extends State<otpverfied> {

  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();
  String companyCode = "";
  String companyurl = "";
  String empid = "";
  String emp_code="";
  String offiial_email_id="";
  String id = "";
  String password = "";

  Future<void> _loadCompanyCode() async {
    final prefs = await SharedPreferences.getInstance();
    companyCode = prefs.getString('companyCode') ?? "";
    empid = prefs.getString('empid') ?? "";
    emp_code= prefs.getString('emp_code') ?? "";
    companyurl = prefs.getString('companyurl') ?? "";
    password = prefs.getString('password') ?? "";
    offiial_email_id=prefs.getString('offiial_email_id')??'';
  }
  @override
  void initState() {
    super.initState();
    _loadCompanyCode();
  }
  TextEditingController Newpassword = TextEditingController();
  TextEditingController Conformpassword = TextEditingController();
  Future<dynamic> login(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    print(offiial_email_id);
    print(emp_code);
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      http.Response response = await http.post(Uri.parse
        (companyurl+'api2/passwordotpverfied.php')
          , body: {
            'email_id':offiial_email_id.toString(),
            'emp_code':emp_code.toString(),
            'password': password.toString(),
            'otp':Newpassword.text,
          });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          Fluttertoast.showToast(
            msg: 'Login Successfully',
            backgroundColor: Colors.black,
          );
          if (_formKey.currentState!.validate()) {
            setState(() {
              changeButton = true;
            });

            await Future.delayed(Duration(seconds: 1));
            // Navigate to a different page
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => passwordset(),
              ),
            );

            setState(() {
              changeButton = false;
            });
          }
        } else {
          // Password does not exist, show the other page
          print(data);
          Newpassword.text = "";
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text('Login Error'),
                  content: Text('Invalid password.'),
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
        // Show error message or handle the error accordingly
      }
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
                SizedBox(
                  height: 90.0,
                ),
                Column(
                  children: [
                    Center(child: Text(
                          'your otp has been send '
                          'registered email id',style:
                        TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),)),
                    Text(offiial_email_id,style:
                    TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),)
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  child: Column(children: [
                    TextFormField(
                      controller: Newpassword,
                      decoration: InputDecoration(
                        hintText: "Enter Otp",
                        labelText: "OTP",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Otp cannot be empty!";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    InkWell(
                      onTap: () => login(context),
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        width: changeButton ? 50 : 150,
                        height: 50,
                        alignment: Alignment.center,
                        child: changeButton
                            ? Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                            : Text(
                          "verified",
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
              ],
            )),
      ),
    );
  }
}
