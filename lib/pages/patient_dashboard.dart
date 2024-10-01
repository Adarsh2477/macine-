// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:fl_chart/fl_chart.dart';
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:ohctech/pages/viewdashyboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/patient.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'OSIGRAFH.dart';
import 'osi_graph_patient.dart';
import 'patient_profile.dart';
import 'bmi_graph.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';

class patientDashBoard extends StatefulWidget {
  const patientDashBoard({Key? key}) : super(key: key);

  @override
  // patientDashBoardState createState() => patientDashBoardState();
  State<patientDashBoard> createState() => _patientDashBoardState();
}

class _patientDashBoardState extends State<patientDashBoard> {

  bool _isButtonClicked = false;
  List<String> _selectedItems = [];
  List<String> _options = []; // Store the options fetched from the API

  // Fetch options from the API
  Future<void> _fetchUserData() async {
    await Future.delayed(Duration(seconds: 0));
    final response = await http.get(Uri.parse(companyurl+'api2/parameter_graph.php'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _options = data.map<String>((item) => item['key_param_name']).toList();
        // _options = data.map<String>((item) =>
        // '${item['key_param_name']} (${item['key_param_id']})').toList();
      });
    } else {
      throw Exception('Failed to load options');
    }
  }

  // Future<void> _fetchUserData() async {
  //   await Future.delayed(Duration(seconds: 0));
  //   final response = await http.get(Uri.parse(companyurl+'api2/parameter_graph.php'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body);
  //     setState(() {
  //       _userOptions = data.map((item) => ValueItem(label: item['key_param_name'], value: User.fromJson(item))).toList();
  //     });
  //   } else {
  //     throw Exception('Failed to load user data');
  //   }
  // }

  final List<ValueItem> _selectedOptions = [];
  List<Map<String, dynamic>> data1 = [];
  List<Map<String, dynamic>> data2 = [];
  List<Map<String, dynamic>> data3 = [];
  List<Map<String, dynamic>> data4 = [];
  bool heightVisible = true;
  bool weightVisible = true;
  bool bmiVisible = true;
  bool ppbsVisible = true;
  bool fbsVisible = true;
  bool rbsVisible = true;
  bool opdVisible = true;
  bool injuryVisible = true;
  bool sicnessVisible = true;
  bool sbpVisible = true;
  bool dbpVisible = true;
  TextEditingController fordays = TextEditingController();

  TextEditingController _startdateController = TextEditingController();
  List<Map<String, dynamic>> chartData = [];
  Future<void> fetchData6() async {
    await Future.delayed(Duration(seconds: 0));
    final response = await http.post(
      Uri.parse(companyurl+'api2/paraetergrafh.php?id=${empid}'),
      body: {
        "startDate": _startdateController.text,
        "endDate": _enddateController.text,
        "parameters": _selectedItems.toString(),
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        List<dynamic> rawData = json.decode(response.body);
        chartData = rawData.map<Map<String, dynamic>>((param) {
          String paramName = param['key_param_name'];
          List<Map<String, dynamic>> checkupData =
          List<Map<String, dynamic>>.from(param['checkup_parameter']);
          List<Map<String, dynamic>> formattedCheckupData =
          checkupData.map((checkup) {
            return {
              'date': checkup['date'],
              'value': double.tryParse(checkup['value'].toString()) ?? 0.0,
            };
          }).toList();
          return {
            'paramName': paramName,
            'checkupData': formattedCheckupData,
          };
        }).toList();
        print(chartData);
      });
    }
  }

  Future<void> fetchosi() async {
    // Replace 'your_php_api_url' with the actual URL of your PHP script.

    await Future.delayed(Duration(seconds: 0));
    final response = await http.post(Uri.parse(companyurl+'api2/buttonclickosigeaph.php?id=${empid}'),
        body: {
          "startDate":_startdateController.text,
          "endDate": _enddateController.text
        });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      print(responseData);
      setState(() {
        data4 = responseData.cast<Map<String, dynamic>>();
        // Convert height values to doubles with validation
        data4.forEach((item) {
          item['month'] = parseDouble(item['month']);
          item['opd'] = parseDouble(item['opd']);
          item['injury'] = parseDouble(item['injury']);
          item['sickness'] = parseDouble(item['sickness']);
        });
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<void> fetchData3() async {
    // Replace 'your_php_api_url' with the actual URL of your PHP script.

    await Future.delayed(Duration(seconds: 0));
    final response = await http.get(Uri.parse(companyurl+'api2/osigrafh.php?id=${empid}'),
      );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      print(responseData);
      setState(() {
        data4 = responseData.cast<Map<String, dynamic>>();
        // Convert height values to doubles with validation
        data4.forEach((item) {
          item['month'] = parseDouble(item['month']);
          item['opd'] = parseDouble(item['opd']);
          item['injury'] = parseDouble(item['injury']);
          item['sickness'] = parseDouble(item['sickness']);
        });
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  double parseDouble(dynamic value) {
    try {
      return double.parse(value.toString());
    } catch (e) {
      // Handle the case when parsing fails
      return 0.0; // or any default value you prefer
    }
  }
  Future<void> fetchfbs() async {
    // Replace 'your_php_api_url' with the actual URL of your PHP script.

    await Future.delayed(Duration(seconds: 0));
    final response = await http.post(Uri.parse(companyurl+'api2/chartpbsppbs.php?id=${empid}'),
        body: {
          "startDate":_startdateController.text,
          "endDate": _enddateController.text
        });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      print(responseData);
      setState(() {
        data3 = responseData.cast<Map<String, dynamic>>();
        // Convert height values to doubles with validation
        data3.forEach((item) {
          item['dat'] = parseDouble1(item['date']);
          item['fbs'] = parseDouble1(item['fbs']);
          item['ppbs'] = parseDouble1(item['ppbs']);
          item['rbs'] = parseDouble1(item['rbs']);
        });
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<void> fetchData2() async {
    // Replace 'your_php_api_url' with the actual URL of your PHP script.

    await Future.delayed(Duration(seconds: 0));
    final response = await http.get(Uri.parse(companyurl+'api2/chart_bmi.php?id=${empid}'),
        );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      print(responseData);
      setState(() {
        data3 = responseData.cast<Map<String, dynamic>>();
        // Convert height values to doubles with validation
        data3.forEach((item) {
          item['dat'] = parseDouble1(item['date']);
          item['fbs'] = parseDouble1(item['fbs']);
          item['ppbs'] = parseDouble1(item['ppbs']);
          item['rbs'] = parseDouble1(item['rbs']);
        });
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  double parseDouble1(dynamic value) {
    try {
      return double.parse(value.toString());
    } catch (e) {
      // Handle the case when parsing fails
      return 0.0; // or any default value you prefer
    }
  }
  Future<void> fetchsbp() async {
    // Replace 'your_php_api_url' with the actual URL of your PHP script.

    await Future.delayed(Duration(seconds: 0));
    final response = await http.post(Uri.parse(companyurl+'api2/chartbpsbp.php?id=${empid}'),
        body: {
          "startDate":_startdateController.text,
          "endDate": _enddateController.text
        });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      print(responseData);
      setState(() {
        data2 = responseData.cast<Map<String, dynamic>>();
        // Convert height values to doubles with validation
        data2.forEach((item) {
          item['dat'] = parseDouble2(item['date']);
          item['sbp'] = parseDouble2(item['sbp']);
          item['dbp'] = parseDouble2(item['dbp']);
        });
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<void> fetchData1() async {
    // Replace 'your_php_api_url' with the actual URL of your PHP script.

    await Future.delayed(Duration(seconds: 0));
    final response = await http.get(Uri.parse(companyurl+'api2/chart_bmi.php?id=${empid}'),
        );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      print(responseData);
      setState(() {
        data2 = responseData.cast<Map<String, dynamic>>();
        // Convert height values to doubles with validation
        data2.forEach((item) {
          item['dat'] = parseDouble2(item['date']);
          item['sbp'] = parseDouble2(item['sbp']);
          item['dbp'] = parseDouble2(item['dbp']);
        });
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  double parseDouble2(dynamic value) {
    try {
      return double.parse(value.toString());
    } catch (e) {
      // Handle the case when parsing fails
      return 0.0; // or any default value you prefer
    }
  }
  Future<void> fetchchart() async {
    await Future.delayed(Duration(seconds: 0));
    final response =
    await http.post(Uri.parse(companyurl+'api2/chart.php?id=${empid}'),
        body: {
          "startDate":_startdateController.text,
          "endDate": _enddateController.text
        }
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      print(responseData);
      setState(() {
        data1 = responseData.cast<Map<String, dynamic>>();
        // Convert height values to doubles with validation
        data1.forEach((item) {
          item['height'] = parseDouble3(item['height']);
          item['weight'] = parseDouble3(item['weight']);
          item['bmi'] = parseDouble3(item['bmi']);
          item['dat'] =parseDouble3(item['date']);
        });
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchData() async {
    await Future.delayed(Duration(seconds: 0));
    final response =
    await http.get(Uri.parse(companyurl+'api2/chart_bmi.php?id=${empid}'),

    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      print(responseData);
      setState(() {
        data1 = responseData.cast<Map<String, dynamic>>();
        // Convert height values to doubles with validation
        data1.forEach((item) {
          item['height'] = parseDouble3(item['height']);
          item['weight'] = parseDouble3(item['weight']);
          item['bmi'] = parseDouble3(item['bmi']);
          item['dat'] =parseDouble3(item['date']);
        });
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  double parseDouble3(dynamic value) {
    try {
      return double.parse(value.toString());
    } catch (e) {
      // Handle the case when parsing fails
      return 0.0; // or any default value you prefer
    }
  }

  Future<void> _startDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1600),
      lastDate: DateTime(8101),
    );

    if (picked != null && picked != DateTime.now()) {
      // Format the selected date as needed
      String formattedDate = "${picked.year}-${picked.month}-${picked.day}";
      _startdateController.text = formattedDate;
    }
  }
  TextEditingController _enddateController = TextEditingController();

  Future<void> _endDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1500),
      lastDate: DateTime(8101),
    );
    if (picked != null && picked != DateTime.now()) {
      // Format the selected date as needed
      String formattedDate = "${picked.year}-${picked.month}-${picked.day}";
      _enddateController.text = formattedDate;
    }
  }
  var dropdownValuetiming;
  String empid = "";
  String username = "";
  String companyurl = "";
  String patientname = "";
  Future<void> _loadCompanyCode() async {
    final prefs = await SharedPreferences.getInstance();
    empid = prefs.getString('empid') ?? '';
    username = prefs.getString('username') ?? '';
    companyurl = prefs.getString('companyurl') ?? '';
  }
//widget.userId
  late Patient patient;
  // Medicine medicine;
  List _posts = [];
  void _firstLoad() async {
    await Future.delayed(Duration(seconds: 0));
    try {
      final res =
      await http.get(Uri.parse(
          companyurl + 'api2/patient_details_login.php?id=${empid}'));
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
  @override
  void initState() {
    super.initState();
    _loadCompanyCode();
    _firstLoad();
    fetchchart();
    fetchosi();
    fetchsbp();
    fetchfbs();
    // fetchData();
    // fetchData1();
    // fetchData2();
    // fetchData3();
    DateTime currentDate = DateTime.now();
    DateTime oneYearAgo = currentDate.subtract(Duration(days: 365)); // Adding one year (approximately)
    _startdateController.text = DateFormat('yyyy-MM-dd').format(oneYearAgo);
    _enddateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _fetchUserData();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double con1Ht = height * 0.1;
    double con2Ht = height * 0.12;
    double con3Ht = height * 0.5;
    double sbxHt = height * 0.017;
    double h1Font = MediaQuery.of(context).size.height * 0.03;
    double h2Font = MediaQuery.of(context).size.height * 0.017;
    double h3Font = MediaQuery.of(context).size.height * 0.02;

    DashedDivider() {
      return Container(
        alignment: Alignment.center,
        child: Text(
          "- - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
          overflow: TextOverflow.clip,
          style: TextStyle(fontSize: h2Font, color: Colors.grey.shade100),
        ),
      );
    }

    getCard(para, valueS, widthCard) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 15,
        child: Container(
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.lightBlue[200],
          ),
          height: height / 10,
          width: width / 3 + widthCard,
          child: Center(
            child: Column(
              children: [
                Text(
                  para,
                  style: TextStyle(
                    fontSize: h1Font,
                  ),
                ),
                SizedBox(
                  height: h3Font,
                ),

                Container(
                  child:
                  Text(
                    valueS,
                    style: TextStyle(
                      fontSize: h3Font,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    getContainer(String s1, String s2, String s3, String s4) {
      return Container(
        height: con3Ht * 0.14,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s1,
                      style: TextStyle(
                          fontSize: h3Font * 0.8, fontWeight: FontWeight.bold)),
                  Text(s2,
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          fontSize: h3Font * 0.7,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal)),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(s3,
                      style: TextStyle(
                          fontSize: h3Font * 0.8, fontWeight: FontWeight.bold)),
                  Text(s4,
                      style: TextStyle(
                          fontSize: h3Font * 0.7,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal)),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body:  ListView.builder(
          itemCount: PatientModel.patients?.length ?? 0,
          itemBuilder: (context, index) {
            var data = PatientModel.patients[index];
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),
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
                                                data.patient_name ?? '',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight
                                                        .bold),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: Text(
                                              data.emp_code ?? '',
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
                          height: 30,
                        ),
                        Card(
                          elevation: 15,
                          child: ExpansionTile(
                            // backgroundColor: Color.fromARGB(255, 17, 171, 222),
                              title: Text(
                                "Employee Health Dashboard",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ), //header title
                              children: [
                                Center(
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Center(
                                                  child: SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal,
                                                      child: Row(children: <Widget>[
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Card(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                          elevation: 15,
                                                          child: Container(
                                                            margin: EdgeInsets.all(2),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                                              color: Colors.lightBlue[200],
                                                            ),
                                                            height: height / 10,
                                                            width: width / 3 ,
                                                            child: Center(
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    'Weight',
                                                                    style: TextStyle(
                                                                      fontSize: h1Font,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: h3Font,
                                                                  ),

                                                                  Container(
                                                                    child:data.weight1!.isNotEmpty // Check if the array is not empty
                                                                        ?
                                                                    Text(
                                                                      data.weight1![index].weight??'',
                                                                      style: TextStyle(
                                                                        fontSize: h3Font,
                                                                      ),
                                                                    )
                                                                        : Text(
                                                                      '', // Message to display when array is empty
                                                                      style: TextStyle(
                                                                          fontSize: 15, fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Card(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                          elevation: 15,
                                                          child: Container(
                                                            margin: EdgeInsets.all(2),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                                              color: Colors.lightBlue[200],
                                                            ),
                                                            height: height / 10,
                                                            width: width / 3 ,
                                                            child: Center(
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    'Height',
                                                                    style: TextStyle(
                                                                      fontSize: h1Font,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: h3Font,
                                                                  ),

                                                                  Container(
                                                                    child:data.hight!.isNotEmpty // Check if the array is not empty
                                                                        ?
                                                                    Text(
                                                                      data.hight![index].height??'',
                                                                      style: TextStyle(
                                                                        fontSize: h3Font,
                                                                      ),
                                                                    )
                                                                        : Text(
                                                                      '', // Message to display when array is empty
                                                                      style: TextStyle(
                                                                          fontSize: 15, fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ]))),
                                            ]))),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(children: <Widget>[
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            elevation: 15,
                                            child: Container(
                                              margin: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                color: Colors.lightBlue[200],
                                              ),
                                              height: height / 10,
                                              width: width / 3 ,
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'BMI',
                                                      style: TextStyle(
                                                        fontSize: h1Font,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h3Font,
                                                    ),

                                                    Container(
                                                      child:data.bmi1!.isNotEmpty // Check if the array is not empty
                                                          ?
                                                      Text(
                                                        data.bmi1![index].bmi??'',
                                                        style: TextStyle(
                                                          fontSize: h3Font,
                                                        ),
                                                      )
                                                          : Text(
                                                        '', // Message to display when array is empty
                                                        style: TextStyle(
                                                            fontSize: 15, fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            elevation: 15,
                                            child: Container(
                                              margin: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                color: Colors.lightBlue[200],
                                              ),
                                              height: height / 10,
                                              width: width / 3 ,
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'BP',
                                                      style: TextStyle(
                                                        fontSize: h1Font,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h3Font,
                                                    ),

                                                    Container(
                                                      child:data.bp!.isNotEmpty // Check if the array is not empty
                                                          ?
                                                      Text(
                                                        data.bp.toString(),style: TextStyle(
                                                        fontSize: h3Font,
                                                      ),
                                                      )
                                                          : Text(
                                                        '', // Message to display when array is empty
                                                        style: TextStyle(
                                                            fontSize: 15, fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          ///'${data.emp_code ?? ''}/${data.emp_code}'
                                          //getCard("BP", '${data.bmi1![index].bmi??''}/${data.bmi1![index].bmi??''}', 10),
                                        ]))),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(children: <Widget>[
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            elevation: 15,
                                            child: Container(
                                              margin: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                color: Colors.lightBlue[200],
                                              ),
                                              height: height / 10,
                                              width: width / 3 ,
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Pulse',
                                                      style: TextStyle(
                                                        fontSize: h1Font,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h3Font,
                                                    ),

                                                    Container(
                                                      child:data.pulse1!.isNotEmpty // Check if the array is not empty
                                                          ?
                                                      Text(
                                                        data.pulse1![index].pulse??'',
                                                        style: TextStyle(
                                                          fontSize: h3Font,
                                                        ),
                                                      )
                                                          : Text(
                                                        '', // Message to display when array is empty
                                                        style: TextStyle(
                                                            fontSize: 15, fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          //getCard("PULSE", data.pulse1![index].pulse??'', 10),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            elevation: 15,
                                            child: Container(
                                              margin: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                color: Colors.lightBlue[200],
                                              ),
                                              height: height / 10,
                                              width: width / 3 ,
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'FBS',
                                                      style: TextStyle(
                                                        fontSize: h1Font,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h3Font,
                                                    ),

                                                    Container(
                                                      child:data.fbs!.isNotEmpty // Check if the array is not empty
                                                          ?
                                                      Text(
                                                        data.fbs![index].fbs??'',
                                                        style: TextStyle(
                                                          fontSize: h3Font,
                                                        ),
                                                      )
                                                          : Text(
                                                        '', // Message to display when array is empty
                                                        style: TextStyle(
                                                            fontSize: 15, fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          //getCard("FBS", data.fbs![index].fbs??'', 10),
                                        ]))),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(children: <Widget>[
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          elevation: 15,
                                          child: Container(
                                            margin: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                              color: Colors.lightBlue[200],
                                            ),
                                            height: height / 10,
                                            width: width / 3 ,
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'RBS',
                                                    style: TextStyle(
                                                      fontSize: h1Font,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: h3Font,
                                                  ),

                                                  Container(
                                                    child:data.rbs!.isNotEmpty // Check if the array is not empty
                                                        ?
                                                    Text(
                                                      data.rbs![index].rbs??'',
                                                      style: TextStyle(
                                                        fontSize: h3Font,
                                                      ),
                                                    )
                                                        : Text(
                                                      '', // Message to display when array is empty
                                                      style: TextStyle(
                                                          fontSize: 15, fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          elevation: 15,
                                          child: Container(
                                            margin: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                              color: Colors.lightBlue[200],
                                            ),
                                            height: height / 10,
                                            width: width / 3 ,
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'PPBS',
                                                    style: TextStyle(
                                                      fontSize: h1Font,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: h3Font,
                                                  ),

                                                  Container(
                                                    child:data.ppbs!.isNotEmpty // Check if the array is not empty
                                                        ?
                                                    Text(
                                                      data.ppbs![index].ppbs??'',
                                                      style: TextStyle(
                                                        fontSize: h3Font,
                                                      ),
                                                    )
                                                        : Text(
                                                      '', // Message to display when array is empty
                                                      style: TextStyle(
                                                          fontSize: 15, fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        //getCard("PPBS", data.ppbs![index].ppbs??'', 10),
                                      ])),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 15,
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      color: Colors.lightBlue[200],
                                    ),
                                    height: height / 10,
                                    width: width / 2 ,
                                    child: Center(
                                      child:Column(
                                        children: [
                                          Text(
                                            'Health Index',
                                            style: TextStyle(
                                              fontSize: h1Font,
                                            ),
                                          ),
                                          SizedBox(
                                            height: h3Font,
                                          ),

                                          Container(
                                            child:data.Healt_hindex!.isNotEmpty // Check if the array is not empty
                                                ?
                                            Text(
                                              data.Healt_hindex![index].health_index ??'',
                                              style: TextStyle(
                                                fontSize: h3Font,
                                              ),
                                            )
                                                : Text(
                                              '', // Message to display when array is empty
                                              style: TextStyle(
                                                  fontSize: 15, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Card(
                                      //   shape: RoundedRectangleBorder(
                                      //     borderRadius: BorderRadius.circular(20),
                                      //   ),
                                      //   elevation: 15,
                                      //   child: Container(
                                      //     margin: EdgeInsets.all(2),
                                      //     decoration: BoxDecoration(
                                      //       borderRadius: BorderRadius.all(Radius.circular(20)),
                                      //       color: Colors.lightBlue[200],
                                      //     ),
                                      //     height: height / 10,
                                      //     width: width / 3 ,
                                      //     child: Center(
                                      //       child: Column(
                                      //         children: [
                                      //           Text(
                                      //             'Rbs',
                                      //             style: TextStyle(
                                      //               fontSize: h1Font,
                                      //             ),
                                      //           ),
                                      //           SizedBox(
                                      //             height: h3Font,
                                      //           ),
                                      //
                                      //           Container(
                                      //             child:data.rbs!.isNotEmpty // Check if the array is not empty
                                      //                 ?
                                      //             Text(
                                      //               data.rbs![index].rbs??'',
                                      //               style: TextStyle(
                                      //                 fontSize: h3Font,
                                      //               ),
                                      //             )
                                      //                 : Text(
                                      //               '', // Message to display when array is empty
                                      //               style: TextStyle(
                                      //                   fontSize: 15, fontWeight: FontWeight.bold),
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),

                                      //getCard("Health Index", data.Healt_hindex![index].health_index, 200),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text("PATIENT BASIC INFO",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(height: 25),
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
                                              "Emp Code",
                                              style: TextStyle(
                                                  fontWeight: FontWeight
                                                      .bold)),
                                          Text(data
                                              .emp_code??
                                              '',
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
                                          Text("Father Name",
                                              style: TextStyle(
                                                  fontWeight: FontWeight
                                                      .bold)),
                                          Text(data.father_name??
                                              '',
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
                                          Text("Employer",
                                              style: TextStyle(

                                                  fontWeight: FontWeight
                                                      .bold)),
                                          Text(data
                                              .employer_contractor ??
                                              '',
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
                                                  "Designation",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold)),),
                                          ),
                                          Container(
                                            child: Expanded(
                                              child: Text(data
                                                  .designation ??
                                                  '',textAlign: TextAlign.right,
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
                                          Text("Date of Birth",
                                              style: TextStyle(

                                                  fontWeight: FontWeight
                                                      .bold)),
                                          Text(
                                              data.dob ?? '',
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
                                          Text("Age",
                                              style: TextStyle(

                                                  fontWeight: FontWeight
                                                      .bold)),
                                          Text(data.age ?? '',
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
                                          Text("Location",
                                              style: TextStyle(

                                                  fontWeight: FontWeight
                                                      .bold)),
                                          Text(
                                              data.ohc_type_id ??
                                                  '',
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
                                          Text(data.doj ?? '',
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
                        // Container(
                        //   padding: EdgeInsets.only(10),
                        //   // padding: EdgeInsets.all(con3Ht * 0.05),
                        //   height: 20,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     boxShadow: <BoxShadow>[
                        //       BoxShadow(
                        //         color: Colors.grey,
                        //         offset: const Offset(
                        //           5.0,
                        //           5.0,
                        //         ),
                        //         blurRadius: 10.0,
                        //         spreadRadius: 5,
                        //       ),
                        //     ],
                        //     borderRadius: BorderRadius.all(Radius.circular(15)),
                        //   ),
                        //   child: Column(
                        //     children: [
                        //       Container(
                        //         height: 20,
                        //         decoration: BoxDecoration(),
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //           children: [
                        //             Row(
                        //               mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //               children: [
                        //                 Text("Code"),
                        //                 Text("8605"),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       // 4.2 DIVIDER
                        //
                        //       getContainer(
                        //           "FATHER NAME", "", "RAVINDRA CHAUDHARI", ""),
                        //       getContainer("CONTRACTOR", "", "AGA SERVICES", ""),
                        //       getContainer(
                        //           "DESIGNATION", "", "ASSISTANT OFFICER", ""),
                        //       getContainer("DATE OF JOINING", "", "01-JAN-1970", ""),
                        //       getContainer("DATE OF BIRTH", "", "13-MAR-2001", ""),
                        //       getContainer("AGE", "", "21", ""),
                        //       getContainer("OHC TYPE", "", "DISPENSARY", ""),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child:
                            Card(
                                elevation: 15,
                                child: ExpansionTile(
                                    backgroundColor: Colors.white,
                                    title: Text("Patient Latest Visit Data",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    //header title
                                    children: [
                                      SizedBox(height: 10),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 0,
                                            right: 0,
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
                                        child:
                                        Column(
                                          children: [
                                            Card(
                                                elevation: 10,
                                                child: ExpansionTile(
                                                    backgroundColor: Colors
                                                        .white,
                                                    title: Text("Previous Opd Visit",
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
                                                        child:
                                                        data.PreviousOPD!.isNotEmpty // Check if the array is not empty
                                                            ?
                                                        Column(
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
                                                                                "Date & Time",
                                                                                style: TextStyle(

                                                                                    fontWeight: FontWeight
                                                                                        .bold)),),
                                                                        ),
                                                                        Container(
                                                                          child: Expanded(
                                                                            child: Text(
                                                                                data.PreviousOPD![index].appointment_date??
                                                                                    '',textAlign: TextAlign.right,
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
                                                                            "Diagnosis",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Expanded(
                                                                          child: Text(
                                                                              data.PreviousOPD![index].Diagnosis??
                                                                                  '',textAlign: TextAlign.right,
                                                                              style: TextStyle(

                                                                                  fontWeight: FontWeight
                                                                                      .bold)),
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
                                                                            "Treatment",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Expanded(
                                                                          child: Text(
                                                                              data.PreviousOPD![index].Treatment.toString() ?? 'NA',textAlign: TextAlign.right,
                                                                              style: TextStyle(

                                                                                  fontWeight: FontWeight
                                                                                      .bold)),
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
                                                                            "Complaints.",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Expanded(
                                                                          child: Text(
                                                                              data.PreviousOPD![index].complaints.toString() ?? 'NA',textAlign: TextAlign.right,
                                                                              style: TextStyle(

                                                                                  fontWeight: FontWeight
                                                                                      .bold)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                            : Text(
                                                          'No Previous opd Visits', // Message to display when array is empty
                                                          style: TextStyle(
                                                              fontSize: 15, fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    ])),
                                            Card(
                                                elevation: 15,
                                                child: ExpansionTile(
                                                    backgroundColor: Colors
                                                        .white,
                                                    title: Text("Previous Injury",
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
                                                        child:
                                                        data.Previousinj!.isNotEmpty // Check if the array is not empty
                                                            ?
                                                        Column(
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
                                                                            "Date & Time",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Text(
                                                                            data.Previousinj?[index]?.appointment_date ??
                                                                                '',
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
                                                                            "Complaints",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Expanded(
                                                                          child: Text(
                                                                              data.Previousinj?[index]?.complaints ??
                                                                                  '',textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                  fontWeight: FontWeight
                                                                                      .bold)),
                                                                        ),
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
                                                                            "Diagnosis",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Expanded(
                                                                          child: Text(
                                                                              data.Previousinj?[index]?.Diagnosis ??
                                                                                  '',textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                  fontWeight: FontWeight
                                                                                      .bold)),
                                                                        ),
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
                                                                            "Treatment",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Expanded(
                                                                          child: Text(
                                                                              data.Previousinj?[index]?.Treatment ??
                                                                                  'NA',textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                  fontWeight: FontWeight
                                                                                      .bold)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  // Padding(
                                                                  //   padding: const EdgeInsets
                                                                  //       .all(
                                                                  //       6.0),
                                                                  //   child: Row(
                                                                  //     mainAxisAlignment:
                                                                  //     MainAxisAlignment
                                                                  //         .spaceBetween,
                                                                  //     children: [
                                                                  //       Text(
                                                                  //           "Followups",
                                                                  //           style: TextStyle(
                                                                  //
                                                                  //               fontWeight: FontWeight
                                                                  //                   .bold)),
                                                                  //       Text(
                                                                  //
                                                                  //               'NA',
                                                                  //           style: TextStyle(
                                                                  //               fontWeight: FontWeight
                                                                  //                   .bold)),
                                                                  //     ],
                                                                  //   ),
                                                                  // ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],

                                                        )
                                                            : Text(
                                                          'No Previous injury Visits', // Message to display when array is empty
                                                          style: TextStyle(
                                                              fontSize: 15, fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    ])),
                                            Card(
                                                elevation: 15,
                                                child: ExpansionTile(
                                                    backgroundColor: Colors
                                                        .white,
                                                    title: Text("Previous Emergency",
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
                                                        child:data.PreviousEmergency!.isNotEmpty // Check if the array is not empty
                                                            ?
                                                        Column(
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
                                                                            "Date & Time",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Text( data.PreviousEmergency![index].appointment_date??
                                                                            '',
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
                                                                            "Complaints",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Expanded(
                                                                          child: Text( data.PreviousEmergency![index].complaints ??
                                                                              '',textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                  fontWeight: FontWeight
                                                                                      .bold)),
                                                                        ),
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
                                                                            "Treatment",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Expanded(
                                                                          child: Text(
                                                                              data.PreviousEmergency![index].Treatment??'',
                                                                              textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                  fontWeight: FontWeight
                                                                                      .bold)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                            : Text(
                                                          'No Previous Emergency Visits', // Message to display when array is empty
                                                          style: TextStyle(
                                                              fontSize: 15, fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    ])),
                                            Card(
                                                elevation: 15,
                                                child: ExpansionTile(
                                                    backgroundColor: Colors
                                                        .white,
                                                    title: Text("Previous Sickness Absenteeism",
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
                                                        child:
                                                        data.Previousic!.isNotEmpty // Check if the array is not empty
                                                            ?Column(
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
                                                                            "Date & Time",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Text(
                                                                            data.Previousic![index].appointment_date ??
                                                                                '',
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
                                                                            "Diagnosis",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Expanded(
                                                                          child: Text(
                                                                              data.Previousic![index].Diagnosis ??
                                                                                  '',textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                  fontWeight: FontWeight
                                                                                      .bold)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                            : Text(
                                                          'No Previous Sickness Absenteeism Visits', // Message to display when array is empty
                                                          style: TextStyle(
                                                              fontSize: 15, fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    ])),
                                            Card(
                                                elevation: 15,
                                                child: ExpansionTile(
                                                    backgroundColor: Colors
                                                        .white,
                                                    title: Text("Training",
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
                                                        child:
                                                        data.training!.isNotEmpty // Check if the array is not empty
                                                            ?Column(
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
                                                                            "Training Name:",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Expanded(
                                                                          child: Text(
                                                                              data
                                                                                  .training![index].training_name ??
                                                                                  '',textAlign: TextAlign.right,
                                                                              style: TextStyle(

                                                                                  fontWeight: FontWeight
                                                                                      .bold)),
                                                                        ),
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
                                                                            "To Date:",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Text(
                                                                            data
                                                                                .training![index].to_date ??
                                                                                '',
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
                                                                            "From Date:",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Text(
                                                                            data
                                                                                .training![index].from_date ??
                                                                                '',
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
                                                                            "Trainer Name:",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Text(
                                                                            data
                                                                                .training![index].trainer_name ??
                                                                                '',
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
                                                                            "Completion Date:",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Text(
                                                                            data
                                                                                .training![index].completion_date ??
                                                                                '',
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
                                                        )
                                                            : Text(
                                                          'No Previous Training Visits', // Message to display when array is empty
                                                          style: TextStyle(
                                                              fontSize: 15, fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    ])),
                                            Card(
                                                elevation: 15,
                                                child: ExpansionTile(
                                                    backgroundColor: Colors
                                                        .white,
                                                    title: Text("Previous Medical Examination",
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
                                                        child:data.Previousmed!.isNotEmpty // Check if the array is not empty
                                                            ? Column(
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
                                                                            "Date & Time:",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Text(
                                                                            data.Previousmed![index].checkup_date??
                                                                                '',
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
                                                                        Expanded(
                                                                          child: Text(
                                                                              "Medications:",
                                                                              style: TextStyle(

                                                                                  fontWeight: FontWeight
                                                                                      .bold)),
                                                                        ),
                                                                        Text(
                                                                            data
                                                                                .Previousmed![index].Medications ??
                                                                                '',textAlign: TextAlign.right,
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
                                                        )
                                                            : Text(
                                                          'No Previous Medical Examination Visits', // Message to display when array is empty
                                                          style: TextStyle(
                                                              fontSize: 15, fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    ])),
                                            Card(
                                                elevation: 15,
                                                child: ExpansionTile(
                                                    backgroundColor: Colors.white,
                                                    title: Text("Past Present Illness",
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
                                                        child:
                                                        data.illnes!.isNotEmpty // Check if the array is not empty
                                                            ?Column(
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
                                                                                'Diagnosis date')),
                                                                        DataColumn(
                                                                            label: Text(
                                                                                'Illness')),
                                                                        DataColumn(
                                                                            label: Text(
                                                                                'Medicine')),
                                                                        DataColumn(
                                                                            label: Text(
                                                                                'Frequency')),
                                                                      ],
                                                                      rows: data
                                                                          .illnes!
                                                                          .map(
                                                                              (item) =>
                                                                              DataRow(
                                                                                  cells: <
                                                                                      DataCell>[
                                                                                    DataCell(
                                                                                        Text(
                                                                                            item
                                                                                                .diagnosis_date
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
                                                                                    DataCell(
                                                                                        Text(
                                                                                            item
                                                                                                .medicine_frequency ??
                                                                                                ''
                                                                                                    .toString())),
                                                                                  ])
                                                                      ).toList(),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                            : Text(
                                                          'No Past Present Illness Visits', // Message to display when array is empty
                                                          style: TextStyle(
                                                              fontSize: 15, fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    ])),

                                            Card(
                                                elevation: 15,
                                                child: ExpansionTile(
                                                    backgroundColor: Colors
                                                        .white,
                                                    title: Text("Health Advices",
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
                                                        child:data.HealthAdvices!.isNotEmpty // Check if the array is not empty
                                                            ? Column(
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
                                                                            "Date & Time:",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Expanded(
                                                                          child: Text(
                                                                              data
                                                                                  .HealthAdvices![index].appointment_date
                                                                                  ??'NA',textAlign: TextAlign.right,
                                                                              style: TextStyle(

                                                                                  fontWeight: FontWeight
                                                                                      .bold)),
                                                                        ),
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
                                                                            "Advices:",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Expanded(
                                                                          child: Text(
                                                                              data
                                                                                  .HealthAdvices![index].Advices ??
                                                                                  '',textAlign: TextAlign.right,
                                                                              style: TextStyle(
                                                                                  fontWeight: FontWeight
                                                                                      .bold)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                            : Text(
                                                          'No Previous Health Advices Visits', // Message to display when array is empty
                                                          style: TextStyle(
                                                              fontSize: 15, fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    ])),
                                            // Card(
                                            //     elevation: 15,
                                            //     child: ExpansionTile(
                                            //         backgroundColor: Colors
                                            //             .white,
                                            //         title: Text(" Significant Health Risks",
                                            //             style: TextStyle(
                                            //                 fontSize: 15,
                                            //                 fontWeight: FontWeight
                                            //                     .bold)),
                                            //         //header title
                                            //         children: [
                                            //           SizedBox(height: 10),
                                            //           Container(
                                            //             padding: EdgeInsets
                                            //                 .only(
                                            //                 left: 20,
                                            //                 right: 20,
                                            //                 top: 20,
                                            //                 bottom: 20),
                                            //             // padding: EdgeInsets.all(con3Ht * 0.05),
                                            //             decoration: BoxDecoration(
                                            //               color: Colors
                                            //                   .white,
                                            //               boxShadow: <
                                            //                   BoxShadow>[
                                            //                 BoxShadow(
                                            //                   color: Colors
                                            //                       .grey,
                                            //                   offset: const Offset(
                                            //                     5.0,
                                            //                     5.0,
                                            //                   ),
                                            //                   blurRadius: 10.0,
                                            //                   spreadRadius: 5,
                                            //                 ),
                                            //               ],
                                            //               borderRadius:
                                            //               BorderRadius.all(
                                            //                   Radius
                                            //                       .circular(
                                            //                       0)),
                                            //             ),
                                            //             child: Column(
                                            //               children: [
                                            //                 Container(
                                            //                   decoration: BoxDecoration(),
                                            //                   child: Column(
                                            //                     mainAxisAlignment:
                                            //                     MainAxisAlignment
                                            //                         .spaceAround,
                                            //                     children: [
                                            //                       Padding(
                                            //                         padding: const EdgeInsets
                                            //                             .all(
                                            //                             5),
                                            //                         child: Row(
                                            //                           mainAxisAlignment:
                                            //                           MainAxisAlignment
                                            //                               .spaceBetween,
                                            //                           children: [
                                            //                             Text(
                                            //                                 "Primary Pho.No",
                                            //                                 style: TextStyle(
                                            //
                                            //                                     fontWeight: FontWeight
                                            //                                         .bold)),
                                            //                             Text(
                                            //                                 data
                                            //                                     .primary_contact_no ??
                                            //                                     '',
                                            //                                 style: TextStyle(
                                            //
                                            //                                     fontWeight: FontWeight
                                            //                                         .bold)),
                                            //                           ],
                                            //                         ),
                                            //                       ),
                                            //                       Padding(
                                            //                         padding: const EdgeInsets
                                            //                             .all(
                                            //                             6.0),
                                            //                         child: Row(
                                            //                           mainAxisAlignment:
                                            //                           MainAxisAlignment
                                            //                               .spaceBetween,
                                            //                           children: [
                                            //                             Text(
                                            //                                 "Secondary Pho.No",
                                            //                                 style: TextStyle(
                                            //
                                            //                                     fontWeight: FontWeight
                                            //                                         .bold)),
                                            //                             Text(
                                            //                                 data
                                            //                                     .primary_phone ??
                                            //                                     '',
                                            //                                 style: TextStyle(
                                            //                                     fontWeight: FontWeight
                                            //                                         .bold)),
                                            //                           ],
                                            //                         ),
                                            //                       ),
                                            //                     ],
                                            //                   ),
                                            //                 ),
                                            //               ],
                                            //             ),
                                            //           ),
                                            //         ])),
                                            Card(
                                                elevation: 15,
                                                child: ExpansionTile(
                                                    backgroundColor: Colors
                                                        .white,
                                                    title: Text("Additional Treatment Recommendations",
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
                                                        child:
                                                        data.TreatmentReco!.isNotEmpty // Check if the array is not empty
                                                            ?
                                                        Column(
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
                                                                            "Date & Time:",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Text(
                                                                            data
                                                                                .TreatmentReco![index].Time ??
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
                                                                            "Recommendations:",
                                                                            style: TextStyle(

                                                                                fontWeight: FontWeight
                                                                                    .bold)),
                                                                        Text(
                                                                            data
                                                                                .TreatmentReco![index].external_treatments ??
                                                                                '',
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
                                                        )
                                                            : Text(
                                                          'No  Treatment Recommendations ', // Message to display when array is empty
                                                          style: TextStyle(
                                                              fontSize: 15, fontWeight: FontWeight.bold),
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
                          height: 5,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: _startdateController,
                                readOnly: true,
                                onTap: () {
                                  // Open date picker when TextField is clicked
                                  _startDate(context);
                                },
                                decoration: InputDecoration(
                                  labelText: 'Start Date',
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: _enddateController,
                                readOnly: true,
                                onTap: () {
                                  // Open date picker when TextField is clicked
                                  _endDate(context);
                                },
                                decoration: InputDecoration(
                                  labelText: 'End Date',
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Select Health Parameters',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                MultiSelectDialogField(
                                  items: _options
                                      .map((e) => MultiSelectItem<String>(e, e))
                                      .toList(),
                                  initialValue: _selectedItems,
                                  onConfirm: (values) {
                                    setState(() {
                                      _selectedItems = values;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Display the chart only if the button has been clicked
                        _isButtonClicked ? buildChartDisplay() : SizedBox(),
                        SizedBox(
                          height: 1,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                fetchchart();
                                fetchosi();
                                fetchsbp();
                                fetchfbs();
                                fetchData6();
                                _isButtonClicked = true;
                              });
                            },
                            child: Text('GO'),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text("BMI GRAPH", // Message to display when array is empty
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              
                              series: <ChartSeries>[
                                if(heightVisible)
                                  LineSeries<Map<String, dynamic>, String>(
                                    dataSource: data1,
                                    xValueMapper: (datum, _) => datum['date'].toString(),
                                    yValueMapper: (datum, _) {
                                      final height = datum['height'];
                                      return double.tryParse(height.toString()) ?? 0.0;
                                    },
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                                if(weightVisible)
                                  LineSeries<Map<String, dynamic>, String>(
                                    dataSource: data1,
                                    xValueMapper: (datum, _) => datum['date'].toString(),
                                    yValueMapper: (datum, _) {
                                      final weight = datum['weight'];
                                      return double.tryParse(weight.toString()) ?? 0.0;
                                    },
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                                if(bmiVisible)
                                  LineSeries<Map<String, dynamic>, String>(
                                    dataSource: data1,
                                    xValueMapper: (datum, _) => datum['date'].toString(),
                                    yValueMapper: (datum, _) {
                                      final bmi = datum['bmi'];
                                      return double.tryParse(bmi.toString()) ?? 0.0;
                                    },
                                    dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                              ],
                              zoomPanBehavior: ZoomPanBehavior(
                                enablePanning: true,
                                enablePinching: true,
                                enableDoubleTapZooming: true,
                              ),

                            ),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     SizedBox(
                        //       height: 300,
                        //       child:
                        //       Container(
                        //         height: 300,
                        //         child: SfCartesianChart(
                        //           primaryXAxis: CategoryAxis(),
                        //           series: <ChartSeries>[
                        //             if(heightVisible)
                        //               LineSeries<Map<String, dynamic>, String>(
                        //                 dataSource: data1,
                        //                 xValueMapper: (datum, _) => datum['date'].toString(),
                        //                 yValueMapper: (datum, _) {
                        //                   final height = datum['height'];
                        //                   return double.tryParse(height.toString()) ?? 0.0;
                        //                 },
                        //                 dataLabelSettings: DataLabelSettings(isVisible: true),
                        //               ),
                        //             if(weightVisible)
                        //               LineSeries<Map<String, dynamic>, String>(
                        //                 dataSource: data1,
                        //                 xValueMapper: (datum, _) => datum['date'].toString(),
                        //                 yValueMapper: (datum, _) {
                        //                   final weight = datum['weight'];
                        //                   return double.tryParse(weight.toString()) ?? 0.0;
                        //                 },
                        //                 dataLabelSettings: DataLabelSettings(isVisible: true),
                        //               ),
                        //             if(bmiVisible)
                        //               LineSeries<Map<String, dynamic>, String>(
                        //                 dataSource: data1,
                        //                 xValueMapper: (datum, _) => datum['date'].toString(),
                        //                 yValueMapper: (datum, _) {
                        //                   final bmi = datum['bmi'];
                        //                   return double.tryParse(bmi.toString()) ?? 0.0;
                        //                 },
                        //                 dataLabelSettings: DataLabelSettings(isVisible: true),
                        //               ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 5),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      heightVisible = !heightVisible; // Toggle visibility
                                    });
                                  },
                                  child: Text(heightVisible ? 'Height' : 'Height'),
                                ),
                                SizedBox(height: 5),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      weightVisible = !weightVisible; // Toggle visibility
                                    });
                                  },
                                  child: Text(weightVisible ? 'Weight' : 'Weight'),
                                ),
                                SizedBox(height: 5),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      bmiVisible = !bmiVisible; // Toggle visibility
                                    });
                                  },

                                  child: Text(bmiVisible ? 'BMI' : 'BMI'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text("OSI GRAPH", // Message to display when array is empty
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 300,
                              child:
                              // Container(
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(16.0),
                              //     child:
                              //     LineChart(
                              //       LineChartData(
                              //         extraLinesData: ExtraLinesData(extraLinesOnTop: true),
                              //
                              //         gridData: FlGridData(show: true, ),
                              //         titlesData: const FlTitlesData(rightTitles: AxisTitles(sideTitles: SideTitles()),topTitles: AxisTitles(sideTitles: SideTitles())),
                              //         borderData: FlBorderData(
                              //           show: true,
                              //           border: Border.all(
                              //             color: const Color(0xff37434d),
                              //             width: 0.5,
                              //           ),
                              //         ),
                              //         // minX: 0,
                              //         // minY: 0,
                              //         lineBarsData: [
                              //           LineChartBarData(
                              //             spots: List.generate(
                              //               data4.length,
                              //                   (index) => FlSpot(data4[index]['MONTH'], data4[index]['OPD_COUNT']),
                              //             ),
                              //             isCurved: false,
                              //             color: Colors.blue,
                              //             dotData: FlDotData(show: true),
                              //             belowBarData: BarAreaData(show: false,spotsLine:const BarAreaSpotsLine()),
                              //             barWidth: heightVisible ? 5 : 0,
                              //           ),
                              //           LineChartBarData(
                              //             spots: List.generate(
                              //               data4.length,
                              //                   (index) => FlSpot(data4[index]['MONTH'], data4[index]['INJURY_COUNT']),
                              //             ),
                              //             isCurved: false,
                              //             color: Colors.yellow,
                              //             dotData: FlDotData(show: true),
                              //             barWidth: weightVisible ? 5 : 0,
                              //             belowBarData: BarAreaData(show: false,spotsLine:const BarAreaSpotsLine()),
                              //           ),
                              //           LineChartBarData(
                              //             spots: List.generate(
                              //               data4.length,
                              //                   (index) => FlSpot(data4[index]['MONTH'], data4[index]['SICKNESS_COUNT']),
                              //             ),
                              //             isCurved: false,
                              //             color: Colors.green,
                              //             barWidth: bmiVisible ? 5 : 0,
                              //             dotData: FlDotData(show: true),
                              //             belowBarData: BarAreaData(show: false),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // )

                              Container(
                                height: 300,
                                child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(),
                                  series: <ChartSeries>[
                                    if (opdVisible)
                                      LineSeries<Map<String, dynamic>, String>(
                                        dataSource: data4,
                                        xValueMapper: (datum, _) => datum['month'].toString(),
                                        yValueMapper: (datum, _) {
                                          final height = datum['opd'];
                                          return double.tryParse(height.toString()) ?? 0.0;
                                        },
                                        dataLabelSettings: DataLabelSettings(isVisible: true),
                                      ),
                                    if (injuryVisible)
                                      LineSeries<Map<String, dynamic>, String>(
                                        dataSource: data4,
                                        xValueMapper: (datum, _) => datum['month'].toString(),
                                        yValueMapper: (datum, _) {
                                          final weight = datum['injury'];
                                          return double.tryParse(weight.toString()) ?? 0.0;
                                        },
                                        dataLabelSettings: DataLabelSettings(isVisible: true),
                                      ),
                                    if (sicnessVisible)
                                      LineSeries<Map<String, dynamic>, String>(
                                        dataSource: data4,
                                        xValueMapper: (datum, _) => datum['month'].toString(),
                                        yValueMapper: (datum, _) {
                                          final bmi = datum['sickness'];
                                          return double.tryParse(bmi.toString()) ?? 0.0;
                                        },
                                        dataLabelSettings: DataLabelSettings(isVisible: true),
                                      ),
                                  ],
                                  zoomPanBehavior: ZoomPanBehavior(
                                    enablePanning: true,
                                    enablePinching: true,
                                    enableDoubleTapZooming: true,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 5),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      opdVisible = !opdVisible; // Toggle visibility
                                    });
                                  },
                                  child: Text(opdVisible ? 'OPD' : 'OPD'),
                                ),
                                SizedBox(height: 5),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      injuryVisible = !injuryVisible; // Toggle visibility
                                    });
                                  },
                                  child: Text(injuryVisible ? 'INJURY' : 'INJURY'),
                                ),
                                SizedBox(height: 5),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      sicnessVisible = !sicnessVisible; // Toggle visibility
                                    });
                                  },

                                  child: Text(sicnessVisible ? 'SICKNESS' : 'SICKNESS'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text("BP GRAPH", // Message to display when array is empty
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 300,
                              child:
                              // Container(
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(16.0),
                              //     child:
                              //     LineChart(
                              //       LineChartData(
                              //         extraLinesData: ExtraLinesData(extraLinesOnTop: true),
                              //
                              //         gridData: FlGridData(show: true, ),
                              //         titlesData: const FlTitlesData(rightTitles: AxisTitles(sideTitles: SideTitles()),topTitles: AxisTitles(sideTitles: SideTitles())),
                              //         borderData: FlBorderData(
                              //           show: true,
                              //           border: Border.all(
                              //             color: const Color(0xff37434d),
                              //             width: 0.5,
                              //           ),
                              //         ),
                              //         // minX: 0,
                              //         // minY: 0,
                              //         lineBarsData: [
                              //           LineChartBarData(
                              //             spots: List.generate(
                              //               data2.length,
                              //                   (index) => FlSpot(data2[index]['dat'], data2[index]['sbp']),
                              //             ),
                              //             isCurved: false,
                              //             color: Colors.blue,
                              //             dotData: FlDotData(show: true),
                              //             belowBarData: BarAreaData(show: false,spotsLine:const BarAreaSpotsLine()),
                              //             barWidth: heightVisible ? 5 : 0,
                              //           ),
                              //           LineChartBarData(
                              //             spots: List.generate(
                              //               data2.length,
                              //                   (index) => FlSpot(data2[index]['dat'], data2[index]['dbp']),
                              //             ),
                              //             isCurved: false,
                              //             color: Colors.black45,
                              //             dotData: FlDotData(show: true),
                              //             barWidth: weightVisible ? 5 : 0,
                              //             belowBarData: BarAreaData(show: false,spotsLine:const BarAreaSpotsLine()),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // )

                              Container(
                                height: 300,
                                child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(),
                                  series: <ChartSeries>[
                                    if (sbpVisible)
                                      LineSeries<Map<String, dynamic>, String>(
                                        dataSource: data2,
                                        xValueMapper: (datum, _) => datum['date'].toString(),
                                        yValueMapper: (datum, _) {
                                          final height = datum['sbp'];
                                          return double.tryParse(height.toString()) ?? 0.0;
                                        },
                                        dataLabelSettings: DataLabelSettings(isVisible: true),
                                      ),
                                    if (dbpVisible)
                                      LineSeries<Map<String, dynamic>, String>(
                                        dataSource: data2,
                                        xValueMapper: (datum, _) => datum['date'].toString(),
                                        yValueMapper: (datum, _) {
                                          final weight = datum['dbp'];
                                          return double.tryParse(weight.toString()) ?? 0.0;
                                        },
                                        dataLabelSettings: DataLabelSettings(isVisible: true),
                                      ),
                                    // LineSeries<Map<String, dynamic>, String>(
                                    //   dataSource: data2,
                                    //   xValueMapper: (datum, _) => datum['date'].toString(),
                                    //   yValueMapper: (datum, _) {
                                    //     final bmi = datum['bmi'];
                                    //     return double.tryParse(bmi.toString()) ?? 0.0;
                                    //   },
                                    //   dataLabelSettings: DataLabelSettings(isVisible: true),
                                    // ),
                                  ],
                                  zoomPanBehavior: ZoomPanBehavior(
                                    enablePanning: true,
                                    enablePinching: true,
                                    enableDoubleTapZooming: true,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 5),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      sbpVisible = !sbpVisible; // Toggle visibility
                                    });
                                  },
                                  child: Text(sbpVisible ? 'SBP' : 'SBP'),
                                ),
                                SizedBox(height: 5),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      dbpVisible = !dbpVisible; // Toggle visibility
                                    });
                                  },
                                  child: Text(dbpVisible ? 'DBP' : 'DBP'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text("BS GRAPH", // Message to display when array is empty
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 300,
                              child:
                              // Container(
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(16.0),
                              //     child:
                              //     LineChart(
                              //       LineChartData(
                              //         extraLinesData: ExtraLinesData(extraLinesOnTop: true),
                              //
                              //         gridData: FlGridData(show: true, ),
                              //         titlesData: const FlTitlesData(rightTitles: AxisTitles(sideTitles: SideTitles()),topTitles: AxisTitles(sideTitles: SideTitles())),
                              //         borderData: FlBorderData(
                              //           show: true,
                              //           border: Border.all(
                              //             color: const Color(0xff37434d),
                              //             width: 0.5,
                              //           ),
                              //         ),
                              //         // minX: 0,
                              //         // minY: 0,
                              //         lineBarsData: [
                              //           LineChartBarData(
                              //             spots: List.generate(
                              //               data3.length,
                              //                   (index) => FlSpot(data3[index]['dat'], data3[index]['ppbs']),
                              //             ),
                              //             isCurved: false,
                              //             color: Colors.blue,
                              //             dotData: FlDotData(show: true),
                              //             belowBarData: BarAreaData(show: false,spotsLine:const BarAreaSpotsLine()),
                              //             barWidth: heightVisible ? 5 : 0,
                              //           ),
                              //           LineChartBarData(
                              //             spots: List.generate(
                              //               data3.length,
                              //                   (index) => FlSpot(data3[index]['dat'], data3[index]['fbs']),
                              //             ),
                              //             isCurved: false,
                              //             color: Colors.black45,
                              //             dotData: FlDotData(show: true),
                              //             barWidth: weightVisible ? 5 : 0,
                              //             belowBarData: BarAreaData(show: false,spotsLine:const BarAreaSpotsLine()),
                              //           ),
                              //           LineChartBarData(
                              //             spots: List.generate(
                              //               data3.length,
                              //                   (index) => FlSpot(data3[index]['dat'], data3[index]['rbs']),
                              //             ),
                              //             isCurved: false,
                              //             color: Colors.green,
                              //             barWidth: bmiVisible ? 5 : 0,
                              //             dotData: FlDotData(show: true),
                              //             belowBarData: BarAreaData(show: false),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // )

                              Container(
                                height: 300,
                                child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(),
                                  series: <ChartSeries>[
                                    if(ppbsVisible)
                                      LineSeries<Map<String, dynamic>, String>(
                                        dataSource: data3,
                                        xValueMapper: (datum, _) => datum['date'].toString(),
                                        yValueMapper: (datum, _) {
                                          final height = datum['ppbs'];
                                          return double.tryParse(height.toString()) ?? 0.0;
                                        },
                                        dataLabelSettings: DataLabelSettings(isVisible: true),
                                      ),
                                    if(fbsVisible)
                                      LineSeries<Map<String, dynamic>, String>(
                                        dataSource: data3,
                                        xValueMapper: (datum, _) => datum['date'].toString(),
                                        yValueMapper: (datum, _) {
                                          final weight = datum['fbs'];
                                          return double.tryParse(weight.toString()) ?? 0.0;
                                        },
                                        dataLabelSettings: DataLabelSettings(isVisible: true),
                                      ),
                                    if(rbsVisible)
                                      LineSeries<Map<String, dynamic>, String>(
                                        dataSource: data3,
                                        xValueMapper: (datum, _) => datum['date'].toString(),
                                        yValueMapper: (datum, _) {
                                          final bmi = datum['rbs'];
                                          return double.tryParse(bmi.toString()) ?? 0.0;
                                        },
                                        dataLabelSettings: DataLabelSettings(isVisible: true),
                                      ),
                                  ],
                                  zoomPanBehavior: ZoomPanBehavior(
                                    enablePanning: true,
                                    enablePinching: true,
                                    enableDoubleTapZooming: true,
                                    
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 5),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      ppbsVisible = !ppbsVisible; // Toggle visibility
                                    });
                                  },
                                  child: Text(ppbsVisible ? 'PPBS' : 'PPBS'),
                                ),
                                SizedBox(height: 5),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      fbsVisible = !fbsVisible; // Toggle visibility
                                    });
                                  },
                                  child: Text(fbsVisible ? 'FBS' : 'FBS'),
                                ),
                                SizedBox(height: 5),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      rbsVisible = !rbsVisible; // Toggle visibility
                                    });
                                  },

                                  child: Text(rbsVisible ? 'RBS' : 'RBS'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // MyHomePage(),
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
        )
    );
  }
  Widget buildChartDisplay() {
    return chartData.isEmpty
        ? Center(child: Text('No Parameters selected')) // Placeholder widget when no items are selected
        : SizedBox(
      height: 380,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: chartData.length,
        itemBuilder: (context, index) {
          return  // Set width to fill the screen
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: _buildChart(chartData[index]),

          );
        },
      ),
    );
  }
  Widget _buildChart(Map<String, dynamic> chartData) {
    String paramName = chartData['paramName'];
    List<Map<String, dynamic>> checkupData = chartData['checkupData'];
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text(
              '$paramName',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
          SizedBox(height: 8.0),
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: [
              LineSeries<Map<String, dynamic>, String>(
                dataSource: checkupData,
                xValueMapper: (datum, _) => datum['date'].toString(),
                yValueMapper: (datum, _) => datum['value'],
                name: paramName,
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),

            ],
            zoomPanBehavior: ZoomPanBehavior(
              enablePanning: true,
              enablePinching: true,
              enableDoubleTapZooming: true,
              zoomMode: ZoomMode.xy,
            ),
          ),
        ],
      ),
    );
  }
}

// class bmigrafh extends StatelessWidget {
//   const bmigrafh({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//     //     Text("BMI GRAPH", // Message to display when array is empty
//     // style: TextStyle(
//     // fontSize: 20, fontWeight: FontWeight.bold)),
//     //     SizedBox(
//     //       height: 10,
//     //     ),
//     //     MyApp(),
//         SizedBox(
//           height: 20,
//         ),
//         Text("OSI GRAPH", // Message to display when array is empty
//             style: TextStyle(
//                 fontSize: 20, fontWeight: FontWeight.bold)),
//         SizedBox(
//           height: 10,
//         ),
//          LineChartExample(),
//         Text("BP GRAPH", // Message to display when array is empty
//             style: TextStyle(
//                 fontSize: 20, fontWeight: FontWeight.bold)),
//         SizedBox(
//           height: 10,
//         ),
//         BPSDP(),
//         Text("BS GRAPH", // Message to display when array is empty
//             style: TextStyle(
//                 fontSize: 20, fontWeight: FontWeight.bold)),
//         SizedBox(
//           height: 10,
//         ),
//         rbcfbc(),
//       ],
//     );
//   }
// }
//                         ),

//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
//
//   static const _headerStyle = TextStyle(
//     fontSize: 12,
//     color: Colors.blue,
//   );
// }
//
// class User {
//   final String name;
//   final int id;
//
//   User({required this.name, required this.id});
//
//   @override
//   String toString() {
//     return 'User(name: $name, id: $id)';
//   }
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final MultiSelectController<User> _controller = MultiSelectController();
//
//   final List<ValueItem> _selectedOptions = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       child:
//       Scaffold(
//           backgroundColor: Colors.grey.shade300,
//           body: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('WRAP', style: MyHomePage._headerStyle),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   MultiSelectDropDown<User>(
//                     showClearIcon: true,
//                     controller: _controller,
//                     onOptionSelected: (options) {
//                       debugPrint(options.toString());
//                     },
//                     options: <ValueItem<User>>[
//                       ValueItem(
//                           label: 'Option 1', value: User(name: 'User 1', id: 1)),
//                       ValueItem(
//                           label: 'Option 2', value: User(name: 'User 2', id: 2)),
//                       ValueItem(
//                           label: 'Option 3', value: User(name: 'User 3', id: 3)),
//                       ValueItem(
//                           label: 'Option 4', value: User(name: 'User 4', id: 4)),
//                       ValueItem(
//                           label: 'Option 5', value: User(name: 'User 5', id: 5)),
//                     ],
//                     maxItems: 4,
//                     selectionType: SelectionType.multi,
//                     chipConfig: const ChipConfig(
//                         wrapType: WrapType.wrap, backgroundColor: Colors.red),
//                     optionTextStyle: const TextStyle(fontSize: 16),
//                     selectedOptionIcon: const Icon(
//                       Icons.check_circle,
//                       color: Colors.pink,
//                     ),
//                     selectedOptionTextColor: Colors.blue,
//                     searchEnabled: true,
//                     dropdownMargin: 2,
//                     onOptionRemoved: (index, option) {
//                       debugPrint('Removed: $option');
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }
