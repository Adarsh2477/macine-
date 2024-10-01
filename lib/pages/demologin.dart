import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ohctech/pages/democreeacc.dart';
import 'package:ohctech/pages/demopatentprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class demoligin extends StatefulWidget {
  @override
  _demoliginState createState() => _demoliginState();
}

class _demoliginState extends State<demoligin> {
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
      builder: (context) => demopatientProfile(),
    ));
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  Future<dynamic> login(BuildContext context) async {
    http.Response response = await http.post(Uri.parse
      ("https://tvsm.ohctech.com/api2/demoemail.php"), body: {
      'email': emailController.text,
      'password': otpController.text,
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final prefs = await SharedPreferences.getInstance();

      // Use null-aware operators (?? '') to handle potential null values
      prefs.setString('emp_code', data['emp_code'] ?? '');
      prefs.setString('empid', data['emp_id'] ?? '');
      prefs.setString('patientname', data['patient_name'] ?? '');
      prefs.setString('companyurl', data['company_url'] ?? '');

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
          msg: 'Invalid email id',
          backgroundColor: Colors.black,
        );
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Error'),
            content: Text('Invalid email id'),
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
        builder: (context) => AlertDialog(
          title: Text('Login Error'),
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
    return WillPopScope(
      onWillPop: () async {
        // Disable the back button
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
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
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          hintText: "Enter Email",
                          labelText: "Email Id",
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: otpController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          hintText: "Enter Password",
                          labelText: " Password",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty!";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to a new screen when text is clicked
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => createaccount()),
                            );
                          },
                          child: Center(
                            child: Text(
                              'CREATE ACCOUNT',
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
