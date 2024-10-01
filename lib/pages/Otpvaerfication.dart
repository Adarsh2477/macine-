// Import necessary packages
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ohctech/pages/patient_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class otplogin extends StatefulWidget {
  const otplogin({Key? key}) : super(key: key);

  @override
  State<otplogin> createState() => _otploginState();
}

class _otploginState extends State<otplogin> {
  bool _isLoading = false;

  bool isLoggedIn = false;
  void _handleResendOTP() {
    // Simulating the resend OTP process
    setState(() {
      _isLoading = true; // Start loading
    });

    // Simulate an asynchronous operation, such as sending OTP via API
    Future.delayed(Duration(seconds: 3), () {
      // After OTP is sent, stop loading
      setState(() {
        _isLoading = false;
      });
      // Add code to handle what should happen after OTP is resent
      // For example, showing a confirmation message
    });
  }

  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();
  String companyCode = "";
  String companyurl = "";
  String email_id = "";
  String empid = "";
  String emp_code = "";
  String patientname = "";
  late Timer _timer;
  int _timerDurationInSeconds = 5 * 60; // 5 minutes

  Future<void> _loadCompanyCode() async {
    final prefs = await SharedPreferences.getInstance();
    emp_code = prefs.getString('emp_code') ?? "";
    patientname = prefs.getString('patientname') ?? "";
    companyCode = prefs.getString('companyCode') ?? "";
    companyurl = prefs.getString('companyurl') ?? "";
    email_id = prefs.getString('email_id') ?? "";
    empid = prefs.getString('empid') ?? "";
  }
  @override
  void initState() {
    super.initState();
    _loadCompanyCode();
    login1(context);
    _startTimer();
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
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerDurationInSeconds > 0) {
          _timerDurationInSeconds--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  Future<dynamic> login1(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    http.Response response = await http.post(Uri.parse
      (companyurl + 'api2/email_otp.php'), body: {
      'offiial_email_id': email_id.toString(),
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
    }
  }
  Future<dynamic> login(BuildContext context) async {
    http.Response response = await http.post(Uri.parse
      (companyurl + 'api2/email_verify.php'), body: {
      'email_id': email_id, 'otp': otpController.text
    });
    if (response.statusCode == 200) {
      try {
        var data;
        // var data = response.body;
        // print(data + " DM");
        if (response.body == 'true') {
          data = json.decode(response.body);
          Fluttertoast.showToast(
            msg: 'Otp velidate Successfully',
            backgroundColor: Colors.black,
          );
          if (_formKey.currentState!.validate()) {
            setState(() {
              changeButton = true;
            });
            Fluttertoast.showToast(
              msg: 'Login Successful',
              backgroundColor: Colors.black,
            );
            await Future.delayed(Duration(seconds: 1));
            final prefs = await SharedPreferences.getInstance();
            // Mark user as logged in
            prefs.setBool('isLoggedIn', true);

            // Navigate to profile page
            _navigateToProfilePage();
            // await Future.delayed(Duration(seconds: 1));
            // await Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => patientProfile(),
            //   ),
            // );

            setState(() {
              changeButton = false;
            });
          }
        } else {
          print(data);
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text('Please Enter Vailed otp'),
                  content: Text('Invalid Otp.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
          );
        }
      }catch(e){
        print(e);
      }
    }else{
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
                    "Otp Verification",
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
                        controller: otpController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          hintText: "Enter Otp",
                          labelText: "Otp",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Otp cannot be empty!";
                          }
                          return null;
                        },
                      ),
                      Text('Time remaining: ${_timerDurationInSeconds ~/ 60}:${(_timerDurationInSeconds % 60).toString().padLeft(2, '0')}'),
                      // SizedBox(height: 20),
                      // Text('Please check your email for the OTP.'),
                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!_isLoading) {
                            _handleResendOTP();
                          }
                          login1(context);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Resend OTP',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(width: 10), // Add some spacing between text and progress indicator
                            if (_isLoading) CircularProgressIndicator(), // Show progress indicator if loading
                          ],
                        ),
                      ),
                      // Container(child:
                      // GestureDetector(
                      //   onTap: () {
                      //     // Navigate to a new screen when text is clicked
                      //    login1(context);
                      //   },
                      //   child: Text(
                      //     'Resend Otp',
                      //     style: TextStyle(
                      //       fontSize: 20.0,
                      //       color: Colors.blue,
                      //     ),
                      //   ),
                      // ),
                      // ),
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
                            "Login",
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
