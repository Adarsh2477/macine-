// ignore_for_file: prefer_const_constructors, duplicate_import, unnecessary_import, use_build_context_synchronously, sort_child_properties_last, unused_import
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ohctech/pages/hitachilogin.dart';
import 'dart:convert';
// import 'package:ohctech/pages/home.dart';
import 'package:ohctech/pages/login.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/routes.dart';
import 'Emp_code_login.dart';
class Companycode extends StatefulWidget {
  @override
  State<Companycode> createState() => _CompanycodeState();
}

class _CompanycodeState extends State<Companycode> {
  bool changeButton = false;

  final _formKey = GlobalKey<FormState>();

  TextEditingController CompanyCode = TextEditingController();

  Future<dynamic> login(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      http.Response response = await http.post(Uri.parse
    // ('https://mobile.ohctech.in/api2/company_login_api.php')
         ('http://192.168.1.12/tvsmotors/api2/company_login_api.php')
          //('http://103.196.222.49:85/tvs/api2/company_login_api.php')
          , body: {
            'company_code': CompanyCode.text,
          });
      if (response.statusCode == 200) {
        var data;
        // var data = response.body;
        // print(data + " DM");
        if (response.body != 'error') {
          data = json.decode(response.body);
          print(data['company_url']);
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('companyCode', CompanyCode.text);
          prefs.setString('companyurl', data['company_url']);
          Fluttertoast.showToast(
            msg: 'Login Successfully',
            backgroundColor: Colors.black,
          );
          if (_formKey.currentState!.validate()) {
            setState(() {
              changeButton = true;
            });

            await Future.delayed(Duration(seconds: 1));
            if (CompanyCode.text.toLowerCase() == 'tvs' || CompanyCode.text.toUpperCase() == 'TVS') {
              // Navigate to Hitachi page
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => hitachilogin(),
                ),
              );
            } else {
              // Navigate to a different page
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Emp_code_login(),
                ),
              );
            }
            // await Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => Emp_code_login(),
            //   ),
            // );

            setState(() {
              changeButton = false;
            });
          }
        } else {
          print(data);
          CompanyCode.text = "";
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text('Login Error'),
                  content: Text('Invalid Company Code.'),
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
    }else{
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Network Error'),
          content: Text('No internet connection available.'),
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
                      controller: CompanyCode,
                      decoration: InputDecoration(
                        hintText: "Enter Company code",
                        labelText: "Company code",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Company code cannot be empty!";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 60.0,
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
