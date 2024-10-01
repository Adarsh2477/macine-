// ignore_for_file: prefer_const_constructors, duplicate_import, unnecessary_import, use_build_context_synchronously, sort_child_properties_last, unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ohctech/pages/patient_profile.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/routes.dart';
import 'Emp_code_login.dart';
import 'emailOtp.dart';
import 'home.dart';
// import '../widgets/drawer.dart';
// import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var usrnm = preferences.getString('usrnm');
  runApp(MaterialApp(
    // home: usrnm == null ? LoginPage() : HomePage(),
  ));
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> _showToast(String message, Color backgroundColor) {
    return Fluttertoast.showToast(
      msg: message,
      backgroundColor: backgroundColor,
    );
  }

  Future<void> login(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _showToast('You Are Online 👌', Colors.green);
      }
    } on SocketException catch (_) {
      _showToast('You Are Offline 🤷‍♀️', Colors.red);
      return;
    }

    var url = companyurl + 'api2/login.php';
    http.Response response = await http.post(Uri.parse(url), body: {
      "username": username.text,
      "password": password.text,
      // "company_code": companyCode,
    });
    print(url);
    print(response);
    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);
        print(data);
        print(url);
        print(companyCode);
        final userRole = data['role_id'];
        final userid = data['emp_id'];
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('username', data['user_name']);
        prefs.setString('empid', data['emp_id']);
        if (userRole == '12') {
          _showToast('Login Successfully', Colors.black);
          if (_formKey.currentState!.validate()) {
            setState(() {
              changeButton = true;
            });
           // Navigator.push(context,
               // MaterialPageRoute(builder: (context) => patientProfile()));
             await Navigator.pushNamed(context, MyRoutes.homeRoute);
            setState(() {
              changeButton = false;
            });
          } else {
            username.text = "";
            password.text = "";
            _showToast('Invalid Credentials', Colors.black);
            print("invalid username password");
            return;
          }
        } else {
          _showToast('Login Successfully', Colors.black);
          if (_formKey.currentState!.validate()) {
            setState(() {
              changeButton = true;
            });
            await Future.delayed(Duration(seconds: 1));
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => patientProfile()));
            await Navigator.pushNamed(context, MyRoutes.homeRoute);
            setState(() {
              changeButton = false;
            });
            // String userName = username.text;
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => MyDrawer(
            //       text: userName,
            //     ),
            //   ),
            // );
          } else {
            username.text = "";
            password.text = "";
            _showToast('Invalid Credentials', Colors.black);
            print("invalid username password");
            return;
          }
        }
      }catch(e){
        username.text = "";
        password.text = "";
        _showToast('Invalid Credentials', Colors.black);
        print("invalid username password");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Error'),
            content: Text('Invalid Username Password.'),
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
          content: Text('server error.'),
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
              Image.asset(
                "assets/images/logo.jpeg",
                fit: BoxFit.contain,
                height: 200,
                width: 300,
              ),
              Text(
                "Welcome",
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
                    controller: username,
                    decoration: InputDecoration(
                      hintText: "Enter Username",
                      labelText: "Username",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Username Cannot be Empty!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      labelText: "Password",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password Cannot be Empty!";
                      } else if (value.length < 6) {
                        return "Password length should be at least 6 characters!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
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
                            'Login via Email Otp ',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      ),
                  //     Text("/",style: TextStyle(
                  //       fontSize: 20,
                  //       color: Colors.black,)),
                  //     Container(child:
                  //     GestureDetector(
                  //       onTap: () {
                  //         // Navigate to a new screen when text is clicked
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(builder: (context) => Emp_code_login()),
                  //         );
                  //       },
                  //       child: Text(
                  //         'Emp Code Login',
                  //         style: TextStyle(
                  //           fontSize: 18.0,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 10.0,
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
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(changeButton ? 50 : 8)),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
