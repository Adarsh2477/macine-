// ignore_for_file: prefer_const_constructors, camel_case_types, unused_field, non_constant_identifier_names, prefer_final_fields, annotate_overrides
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohctech/models/patient.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:ohctech/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';


class medicalUpdate extends StatefulWidget {
  final Patient patient;
  const medicalUpdate({Key? key, required this.patient})
      : super(key: key);
  @override
  State<medicalUpdate> createState() => _medicalUpdateState();
}

class _medicalUpdateState extends State<medicalUpdate> {

  String companyCode = "";
  String companyurl = "";

  Future<void> _loadCompanyCode() async {
    final prefs = await SharedPreferences.getInstance();
    companyCode = prefs.getString('companyCode') ?? "";
    companyurl = prefs.getString('companyurl') ?? "";
  }
  TextEditingController patientName = TextEditingController();
  TextEditingController ticketNo = TextEditingController();
  TextEditingController patientid = TextEditingController();
  TextEditingController emp_code = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController checkupdate = TextEditingController();
  TextEditingController validUpto = TextEditingController();
  TextEditingController _controller = TextEditingController();

  List<String> selecthealthrisk = [];
  List<dynamic> healthrisk =[];
  List<String> selecthealthadvices = [];
  List<dynamic> healthadvices =[];
  List<String> selectpastiillness = [];
  List<dynamic> pastiillness =[];
  List<String> selectcroniciillness = [];
  List<dynamic> croniciillness =[];
  List<String> selecthabit = [];
  List<dynamic> habit =[];
  @override
  var map;
  List<dynamic> fitnestatus =[];
  Future<void> fetchfitnesstus() async {
    final response = await http.get(Uri.parse(
        'http://192.168.248.56/tvsmotors/api2/medical_fitnessst.php'));
    if (response.statusCode == 200) {
      setState(() {
        fitnestatus = json.decode(response
            .body); // Assuming the response body is a JSON array of appointments
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  }
  Future<void> intimedate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1500),
      lastDate: DateTime(8101),
    );

    if (picked != null && picked != DateTime.now()) {
      // Format the selected date as needed
      String formattedDate = "${picked.day}-${picked.month}-${picked.year}";
      checkupdate.text = formattedDate;
    }
  }

  Future<void> clearencedate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1500),
      lastDate: DateTime(8101),
    );

    if (picked != null && picked != DateTime.now()) {
      // Format the selected date as needed
      String formattedDate = "${picked.day}-${picked.month}-${picked.year}";
      validUpto.text = formattedDate;
    }
  }
  Future<void> fetchhealthrisk() async {
    final response = await http.get(Uri.parse('http://192.168.248.56/tvsmotors/api2/medical_healthrisk.php'));
    if (response.statusCode == 200) {
      setState(() {
        healthrisk = json.decode(response.body); // Assuming the response body is a JSON array of appointments
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  }
  Future<void> fetchhealtadvices() async {
    final response = await http.get(Uri.parse('http://192.168.248.56/tvsmotors/api2/medical_healthadvices.php'));
    if (response.statusCode == 200) {
      setState(() {
        healthadvices = json.decode(response.body); // Assuming the response body is a JSON array of appointments
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  }
  Future<void> fetchpastiillness() async {
    final response = await http.get(Uri.parse('http://192.168.248.56/tvsmotors/api2/medical_Past_Present_Illness.php'));
    if (response.statusCode == 200) {
      setState(() {
        pastiillness = json.decode(response.body); // Assuming the response body is a JSON array of appointments
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  }
  Future<void> fetchcroniciillness() async {
    final response = await http.get(Uri.parse('http://192.168.248.56/tvsmotors/api2/medical_Chronic_Illnesses.php'));
    if (response.statusCode == 200) {
      setState(() {
        croniciillness = json.decode(response.body); // Assuming the response body is a JSON array of appointments
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  }
  Future<void> fetchhabit() async {
    final response = await http.get(Uri.parse('http://192.168.248.56/tvsmotors/api2/medical_habit.php'));
    if (response.statusCode == 200) {
      setState(() {
        habit = json.decode(response.body); // Assuming the response body is a JSON array of appointments
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  }
  DateTime _date = DateTime.now();
  String approvalStatus = "Select an option";
  var dropfinesssstus;
  void initState() {
    super.initState();
    _loadCompanyCode();
    fetchfitnesstus();
    fetchhealthrisk();
    fetchhealtadvices();
    fetchcroniciillness();
    fetchhabit();
    fetchpastiillness();
    Patient me;
    me = widget.patient;
    print(me);
    patientName.text = me.patient_name??'';
    ticketNo.text = me.ticket_no??'';
    emp_code.text = me.emp_code??'';
    patientid.text = me.id??'';
    dob.text = me.dob??'';
    designation.text=me.designation??'';
    checkupdate.text=me.checkup_date??'';
  }
  Future<dynamic> updateMedical(BuildContext context) async {
    await Future.delayed(Duration(seconds: 0));
    var url = companyurl+'medical_update.php';
    http.Response response = await http.post(Uri.parse(url), body: {

    });
    var map;
    try {
      map = json.decode(response.body);
    } catch (e) {
      print(e);
    }
    if (map == 0) {
      print(map);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Updated Successfully',
        btnOkOnPress: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()))
              .then((_) {
            // This block runs when you have come back to the 1st Page from 2nd.
            setState(() {
              // Call setState to refresh the page.
            });
          });
        },
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Something Went Wrong',
        btnCancelOnPress: () {},
      ).show();
    }
  }

  final _multiSelectKey = GlobalKey<FormFieldState>();

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Update Medical Examination Details",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.lightBlue,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  readOnly: false,
                  controller: ticketNo,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.blue,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                    ),
                    //icon: Icon(Icons.airplane_ticket_rounded),
                    labelText: "Ticket No",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  readOnly: true,
                  controller: patientid,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.blue,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                    ),
                    // icon: Icon(Icons.man),
                    labelText: "Patient ID",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  readOnly: true,
                  controller: emp_code,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.blue,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                    ),
                    //icon: Icon(Icons.man),
                    labelText: "Emp_code",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  readOnly: true,
                  controller: patientName,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.blue,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                    ),
                    // icon: Icon(Icons.man),
                    labelText: "Patient Name",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  readOnly: true,
                  controller: dob,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.blue,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                    ),
                    // icon: Icon(Icons.man),
                    labelText: "Date Of Birth",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  readOnly: true,
                  controller: designation,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.blue,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                    ),
                    // icon: Icon(Icons.man),
                    labelText: "Employee Designation",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  readOnly: true,
                  controller: checkupdate,
                  onTap: () {
                    // Open date picker when TextField is clicked
                    intimedate(context);
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.blue,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        // Open date picker when calendar icon is clicked
                        intimedate(context);
                      },
                      icon: Icon(Icons.calendar_today),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                    ),
                    // icon: Icon(Icons.man),
                    labelText: "Checkup Date",
                  ),

                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  readOnly: true,
                  controller: validUpto,
                  onTap: () {
                    // Open date picker when TextField is clicked
                    clearencedate(context);
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.blue,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        // Open date picker when calendar icon is clicked
                        clearencedate(context);
                      },
                      icon: Icon(Icons.calendar_today),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                    ),
                    // icon: Icon(Icons.man),
                    labelText: "Valid Upto",
                  ),

                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45), // Add border here
                    ),
                    child: DropdownButton(
                      menuMaxHeight: 200,
                      elevation: 8,
                        isExpanded: true,
                        hint:Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Select Discase Type",style: TextStyle(fontWeight:FontWeight.bold ),),
                        ),
                        value: dropfinesssstus,
                        items: fitnestatus.map((e){
                          return DropdownMenuItem(
                              value:e ['velue'].toString(),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(e['Approval_Status'].toString(),style: TextStyle(color: Colors.black),),
                              ));
                        }).toList(),
                        onChanged:(value){
                          setState(() {
                            dropfinesssstus=value;
                          });
                        }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('Health Risk',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45), // Set the border color
                      borderRadius: BorderRadius.circular(0), // Set the border radius
                    ),
                    child: SingleChildScrollView(
                      child: MultiSelectDialogField(
                        items: healthrisk.map((complaint) {
                          return MultiSelectItem<String>(
                            complaint['health_risk_id'],
                            complaint['health_risk_name'],
                          );
                        }).toList(),
                        initialValue: selecthealthrisk,
                        searchable: true,
                        dialogHeight: 250,
                        buttonIcon: Icon(Icons.arrow_drop_down,size: 30,),
                        buttonText: Text('select complaints',),
                        checkColor: null, // Set the checkIcon property to null
                        onConfirm: (values) {
                          setState(() {
                            selecthealthrisk = values;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('Health Advice',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45), // Set the border color
                      borderRadius: BorderRadius.circular(0), // Set the border radius
                    ),
                    child: SingleChildScrollView(
                      child: MultiSelectDialogField(
                        items: healthadvices.map((complaint) {
                          return MultiSelectItem<String>(
                            complaint['health_advice_id'],
                            complaint['health_advice_name'],
                          );
                        }).toList(),
                        initialValue: selecthealthadvices,
                        searchable: true,
                        dialogHeight: 250,
                        buttonIcon: Icon(Icons.arrow_drop_down,size: 30,),
                        buttonText: Text('select complaints'),
                        checkColor: null, // Set the checkIcon property to null
                        onConfirm: (values) {
                          setState(() {
                            selecthealthadvices = values;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('Past Present Illness',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45), // Set the border color
                      borderRadius: BorderRadius.circular(0), // Set the border radius
                    ),
                    child: SingleChildScrollView(
                      child: MultiSelectDialogField(
                        items: pastiillness.map((complaint) {
                          return MultiSelectItem<String>(
                            complaint['param_id'],
                            complaint['param_name'],
                          );
                        }).toList(),
                        initialValue: selectpastiillness,
                        searchable: true,
                        dialogHeight: 250,
                        buttonIcon: Icon(Icons.arrow_drop_down,size: 30,),
                        buttonText: Text('select complaints'),
                        checkColor: null, // Set the checkIcon property to null
                        onConfirm: (values) {
                          setState(() {
                            selectpastiillness = values;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('Chronic Illnesses',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45), // Set the border color
                      borderRadius: BorderRadius.circular(0), // Set the border radius
                    ),
                    child: SingleChildScrollView(
                      child: MultiSelectDialogField(
                        items: croniciillness.map((complaint) {
                          return MultiSelectItem<String>(
                            complaint['abnormality_id'],
                            complaint['abnormality_name'],
                          );
                        }).toList(),
                        initialValue: selectcroniciillness,
                        searchable: true,
                        dialogHeight: 250,
                        buttonIcon: Icon(Icons.arrow_drop_down,size: 30,),
                        buttonText: Text('select complaints'),
                        checkColor: null, // Set the checkIcon property to null
                        onConfirm: (values) {
                          setState(() {
                            selectcroniciillness = values;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('Habits',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45), // Set the border color
                      borderRadius: BorderRadius.circular(0), // Set the border radius
                    ),
                    child: SingleChildScrollView(
                      child: MultiSelectDialogField(
                        items: habit.map((complaint) {
                          return MultiSelectItem<String>(
                            complaint['habit_id'],
                            complaint['habit'],
                          );
                        }).toList(),
                        initialValue: selecthabit,
                        searchable: true,
                        dialogHeight: 250,
                        buttonIcon: Icon(Icons.arrow_drop_down,size: 30,),
                        buttonText: Text('select complaints'),
                        checkColor: null, // Set the checkIcon property to null
                        onConfirm: (values) {
                          setState(() {
                            selecthabit = values;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                onChanged: (text) {
                  setState(() {
                    // Update the UI with the latest text entered
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Type Something',
                ),
              ),
              SizedBox(height: 20),
              Text(
                _controller.text,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 15,
                      offset: Offset(5, 10), // changes position of shadow
                    ),
                  ],
                ),
                height: 50,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ElevatedButton(
                  child: const Text("SAVE"),
                  onPressed: () {
                    updateMedical(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue,

                    // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
