// // ignore_for_file: use_build_context_synchronously, prefer_const_constructors
//
// import 'package:flutter/material.dart';
// import 'package:multi_select_flutter/multi_select_flutter.dart';
// import 'package:ohctech/models/patient.dart';
// // import 'package:ohctech/models/injury_model.dart';
// import 'package:date_time_picker/date_time_picker.dart';
// import 'package:day_night_time_picker/day_night_time_picker.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';
// import 'dart:convert';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:ohctech/pages/home.dart';
// import 'package:intl/intl.dart';
// import 'package:get/get.dart';
// import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class injuryForm extends StatefulWidget {
//   final Patient patient;
//
//    const injuryForm({Key? key, required this.patient})
//       : super(key: key);
//
//   @override
//   State<injuryForm> createState() => _injuryFormState();
// }
//
// class injury_type {
//   final int id;
//   final String name;
//
//   injury_type({
//     required this.id,
//     required this.name,
//   });
// }
//
// class injury_part {
//   final int id;
//   final String name;
//
//   injury_part({
//     required this.id,
//     required this.name,
//   });
// }
//
// class injury_class {
//   final int id;
//   final String name;
//
//   injury_class({
//     required this.id,
//     required this.name,
//   });
// }
//
// class _injuryFormState extends State<injuryForm> {
//   TextEditingController patientName = TextEditingController();
//   TextEditingController ticket_no = TextEditingController();
//   TextEditingController complaints = TextEditingController();
//   TextEditingController diagnosis = TextEditingController();
//   TextEditingController examination_remarks = TextEditingController();
//   TextEditingController remarks_rece = TextEditingController();
//   TextEditingController appointment_date = TextEditingController();
//   TextEditingController injury_time = TextEditingController();
//   TextEditingController incident_location = TextEditingController();
//   TextEditingController injury_cause = TextEditingController();
//   TextEditingController injury_procedure = TextEditingController();
//   TextEditingController branch_area = TextEditingController();
//   // TextEditingController dept = TextEditingController();
//
//   // final AppDataController controllerPart = Get.put(AppDataController());
//   // final AppDataController controllerType = Get.put(AppDataController());
//   // final AppDataController controllerClass = Get.put(AppDataController());
//
//   String companyCode = "";
//   String companyurl = "";
//
//   Future<void> _loadCompanyCode() async {
//     final prefs = await SharedPreferences.getInstance();
//     companyCode = prefs.getString('companyCode') ?? "";
//     companyurl = prefs.getString('companyurl') ?? "";
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _loadCompanyCode();
//     Patient dm;
//     dm = widget.patient;
//     var visitDate;
//     var injuryTime;
//     ticket_no.text = dm.ticket_no ?? '';
//     patientName.text = dm.patient_name ??'' ;
//     complaints.text = dm.complaints??'';
//     diagnosis.text = dm.diagnosis??'';
//     examination_remarks.text = dm.examination_remarks??'';
//     remarks_rece.text = dm.remarks_rece??'';
//     visitDate = dm.appointment_date??'';
//     appointment_date.text = visitDate??'';
//     injuryTime = dm.injury_time??'';
//     injury_time.text = injuryTime??'';
//     incident_location.text = dm.incident_location??'';
//     injury_cause.text = dm.injury_cause??'';
//     injury_procedure.text = dm.injury_procedure??'';
//     branch_area.text = dm.branch_area??'';
//   }
//
//   List injuryClasslist = [];
//
//   Future getAllFrequency() async {
//     var baseUrl = "http://103.196.222.49:85/jsw/injury_class_api.php";
//
//     http.Response response = await http.get(Uri.parse(baseUrl));
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       setState(() {
//         injuryClasslist = jsonData;
//       });
//     }
//   }
//
//   List injuryPartlist = [];
//
//   Future getAllTimings() async {
//     var baseUrl = "http://103.196.222.49:85/jsw/injury_part_api.php";
//
//     http.Response response = await http.get(Uri.parse(baseUrl));
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       setState(() {
//         injuryPartlist = jsonData;
//       });
//     }
//   }
//
//   List injuryTypelist = [];
//
//   Future getAllAdminroute() async {
//     var baseUrl = "http://103.196.222.49:85/jsw/injury_type_api.php";
//
//     http.Response response = await http.get(Uri.parse(baseUrl));
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       setState(() {
//         injuryTypelist = jsonData;
//       });
//     }
//   }
//
//   var dropdownValueInjuryPart;
//   var dropdownValueInjuryClass;
//   var dropdownValueInjuryType;
//   List injuryPartData = [];
//   List injuryClassData = [];
//   List injuryTypeData = [];
//   late String injury_parts;
//   late String injury_types;
//   late String injury_classes;
//
//   final _multiSelectKey = GlobalKey<FormFieldState>();
//
//   Future<dynamic> updateInjury(BuildContext context) async {
//     await Future.delayed(Duration(seconds: 1));
//     var url = companyurl+'injury_update.php';
//     http.Response response = await http.post(Uri.parse(url), body: {
//       "ticket_no": ticket_no.text,
//       "complaints": complaints.text,
//       "diagnosis": diagnosis.text,
//       "examination_remarks": examination_remarks.text,
//       "injury_type": injury_types,
//       "injury_part": injury_parts,
//       "injury_class": injury_classes,
//       "injury_procedure": injury_procedure.text,
//       "remarks_rece": remarks_rece.text,
//       "appointment_date": appointment_date.text,
//       "injury_time": injury_time.text,
//       "injury_cause": injury_cause.text,
//       "branch_area": branch_area.text,
//       "incident_location": incident_location.text,
//     });
//     var map;
//     try {
//       map = json.decode(response.body);
//     } catch (e) {
//       print(e);
//     }
//     if (map == 0) {
//       print(map);
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.success,
//         animType: AnimType.rightSlide,
//         title: 'Updated Successfully',
//         btnOkOnPress: () {
//           Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()))
//               .then((_) {
//             // This block runs when you have come back to the 1st Page from 2nd.
//             setState(() {
//               // Call setState to refresh the page.
//             });
//           });
//         },
//       ).show();
//     } else {
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.error,
//         animType: AnimType.rightSlide,
//         title: 'Something Went Wrong',
//         btnCancelOnPress: () {},
//       ).show();
//     }
//   }
//
//   Widget build(BuildContext context) {
//     // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//     //   controllerPart.getinjuryPartData();
//     // });
//     // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//     //   controllerClass.getinjuryClassData();
//     // });
//     // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//     //   controllerType.getinjuryTypeData();
//     // });
//     var vdate;
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(Icons.arrow_back_ios),
//           ),
//           centerTitle: true,
//           title: const Text(
//             "Update Injury Details",
//             textAlign: TextAlign.center,
//           ),
//           backgroundColor: Colors.lightBlue,
//         ),
//         body: Padding(
//             padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
//             child: ListView(children: <Widget>[
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 child: TextField(
//                   controller: ticket_no,
//                   decoration: const InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 3,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 3, color: Color.fromARGB(255, 66, 125, 145)),
//                     ),
//                     icon: Icon(Icons.airplane_ticket_rounded),
//                     labelText: "INJURY REGD NO.",
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 child: TextField(
//                   controller: patientName,
//                   decoration: const InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 3,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 3, color: Color.fromARGB(255, 66, 125, 145)),
//                     ),
//                     icon: Icon(Icons.man),
//                     labelText: "PATIENT",
//                   ),
//                 ),
//               ),
//               Text(
//                 "\nAppointment Date\n",
//                 style: Theme.of(context).textTheme.headline6,
//               ),
//               Container(
//                   padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
//                   child: TextField(
//                     controller:
//                         appointment_date, //editing controller of this TextField
//                     decoration: InputDecoration(
//                       icon: Icon(Icons.calendar_today), //icon of text field
//                       // labelText: "Date of Return" //label text of field
//                     ),
//                     // readOnly:
//                     //     true, //set it true, so that user will not able to edit text
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(
//                               2000), //DateTime.now() - not to allow to choose before today.
//                           lastDate: DateTime(2101));
//
//                       if (pickedDate != null) {
//                         print(
//                             pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
//                         String formattedDate =
//                             DateFormat('yyyy-MM-dd').format(pickedDate);
//                         print(
//                             formattedDate); //formatted date output using intl package =>  2021-03-16
//                         //you can implement different kind of Date Format here according to your requirement
//
//                         setState(() {
//                           appointment_date.text =
//                               formattedDate; //set output date to TextField value.
//                         });
//                       } else {
//                         print("Date is not selected");
//                       }
//                     },
//                   )),
//               // Text(
//               //   "\nInjury Time\n",
//               //   style: Theme.of(context).textTheme.headline6,
//               // ),
//               // DateTimePicker(
//               //   enableSuggestions: true, cursorColor: Colors.redAccent,
//               //   controller: injury_time,
//               //   type: DateTimePickerType.dateTimeSeparate,
//               //   dateMask: 'd MMM, yyyy',
//               //   firstDate: DateTime(2000),
//               //   lastDate: DateTime(2500),
//               //   // use24HourFormat: false,
//               //   icon: Icon(Icons.event),
//               //   dateLabelText: 'Date',
//               //   timeLabelText: "Time",
//               //   selectableDayPredicate: (date) {
//               //     // Disable weekend days to select from the calendar
//               //     if (date.weekday == 6 || date.weekday == 7) {
//               //       return false;
//               //     }
//
//               //     return true;
//               //   },
//
//               //   validator: (val) {
//               //     return null;
//               //   },
//               // ),
//               const SizedBox(height: 10),
//               const Divider(),
//               const SizedBox(height: 10),
//               // GetBuilder<AppDataController>(builder: (controller) {
//               //   return Padding(
//               //     padding: const EdgeInsets.all(10.0),
//               //     child: MultiSelectDialogField(
//               //       dialogHeight: 200,
//               //       items: controllerPart.dropDownData,
//               //       title: const Text(
//               //         "Select Injury Part",
//               //         style: TextStyle(color: Colors.black),
//               //       ),
//               //       selectedColor: Colors.black,
//               //       decoration: BoxDecoration(
//               //         color: Colors.white,
//               //         borderRadius: const BorderRadius.all(Radius.circular(30)),
//               //         border: Border.all(
//               //           color: Colors.black,
//               //           width: 2,
//               //         ),
//               //       ),
//               //       buttonIcon: const Icon(
//               //         Icons.arrow_drop_down,
//               //         color: Colors.blue,
//               //       ),
//               //       buttonText: const Text(
//               //         "Select Injury parts",
//               //         style: TextStyle(
//               //           color: Colors.black,
//               //           fontSize: 16,
//               //         ),
//               //       ),
//               //       onConfirm: (results) {
//               //         // injuryPartData = [];
//               //         injuryPartData.clear();
//               //         for (var i = 0; i < results.length; i++) {
//               //           Injury data = results[i] as Injury;
//               //           print(data.injuryPartId);
//               //           print(data.injuryPartName);
//               //
//               //           injuryPartData.add(data.injuryPartId);
//               //           injury_parts = injuryPartData
//               //               .toString()
//               //               .replaceAll('[', '')
//               //               .replaceAll(']', '');
//               //           // injuryPartData.clear();
//               //         }
//               //
//               //         print("data $injury_parts");
//               //
//               //         //_selectedAnimals = results;
//               //       },
//               //     ),
//               //   );
//               // }),
//               // GetBuilder<AppDataController>(builder: (controller) {
//               //   return Padding(
//               //     padding: const EdgeInsets.all(10.0),
//               //     child: MultiSelectDialogField(
//               //       dialogHeight: 200,
//               //       items: controllerType.dropDownDataType,
//               //       title: const Text(
//               //         "Select Injury Type",
//               //         style: TextStyle(color: Colors.black),
//               //       ),
//               //       selectedColor: Colors.black,
//               //       decoration: BoxDecoration(
//               //         color: Colors.white,
//               //         borderRadius: const BorderRadius.all(Radius.circular(30)),
//               //         border: Border.all(
//               //           color: Colors.black,
//               //           width: 2,
//               //         ),
//               //       ),
//               //       buttonIcon: const Icon(
//               //         Icons.arrow_drop_down,
//               //         color: Colors.blue,
//               //       ),
//               //       buttonText: const Text(
//               //         "Select Injury type",
//               //         style: TextStyle(
//               //           color: Colors.black,
//               //           fontSize: 16,
//               //         ),
//               //       ),
//               //       onConfirm: (results) {
//               //         // injuryTypeData = [];
//               //         injuryTypeData.clear();
//               //         for (var i = 0; i < results.length; i++) {
//               //           Injury data = results[i] as Injury;
//               //           print(data.injuryTypeId);
//               //           print(data.injuryTypeName);
//               //
//               //           injuryTypeData.add(data.injuryTypeId);
//               //
//               //           injury_types = injuryTypeData
//               //               .toString()
//               //               .replaceAll('[', '')
//               //               .replaceAll(']', '');
//               //         }
//               //         print("data $injury_types");
//               //
//               //         //_selectedAnimals = results;
//               //       },
//               //     ),
//               //   );
//               // }),
//               // GetBuilder<AppDataController>(builder: (controller) {
//               //   return Padding(
//               //     padding: const EdgeInsets.all(10.0),
//               //     child: MultiSelectDialogField(
//               //       dialogHeight: 200,
//               //       items: controllerClass.dropDownDataClass,
//               //       title: const Text(
//               //         "Select Injury Class",
//               //         style: TextStyle(color: Colors.black),
//               //       ),
//               //       selectedColor: Colors.black,
//               //       decoration: BoxDecoration(
//               //         color: Colors.white,
//               //         borderRadius: const BorderRadius.all(Radius.circular(30)),
//               //         border: Border.all(
//               //           color: Colors.black,
//               //           width: 2,
//               //         ),
//               //       ),
//               //       buttonIcon: const Icon(
//               //         Icons.arrow_drop_down,
//               //         color: Colors.blue,
//               //       ),
//               //       buttonText: const Text(
//               //         "Select Injury class",
//               //         style: TextStyle(
//               //           color: Colors.black,
//               //           fontSize: 16,
//               //         ),
//               //       ),
//               //       onConfirm: (results) {
//               //         // injuryClassData = [];
//               //         injuryClassData.clear();
//               //         for (var i = 0; i < results.length; i++) {
//               //           Injury data = results[i];
//               //           print(data.injuryClassId);
//               //           print(data.injuryClassName);
//               //
//               //           injuryClassData.add(data.injuryClassId);
//               //           injury_classes = injuryClassData
//               //               .toString()
//               //               .replaceAll('[', '')
//               //               .replaceAll(']', '');
//               //         }
//               //         print("data $injury_classes");
//               //
//               //         //_selectedAnimals = results;
//               //       },
//               //     ),
//               //   );
//               // }),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 child: TextField(
//                   controller: incident_location,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 3,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 3, color: Color.fromARGB(255, 66, 125, 145)),
//                     ),
//                     icon: Icon(Icons.location_city),
//                     labelText: 'INCIDENT LOCATION',
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 child: TextField(
//                   controller: injury_procedure,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 3,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 3, color: Color.fromARGB(255, 66, 125, 145)),
//                     ),
//                     icon: Icon(Icons.medical_services),
//                     labelText: 'INJURY PROCEDURE',
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 child: TextField(
//                   controller: complaints,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 3,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 3, color: Color.fromARGB(255, 66, 125, 145)),
//                     ),
//                     icon: Icon(Icons.comment_rounded),
//                     labelText: 'INJURY DESCRIPTION',
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 child: TextField(
//                   controller: branch_area,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 3,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 3, color: Color.fromARGB(255, 66, 125, 145)),
//                     ),
//                     icon: Icon(Icons.location_city_sharp),
//                     labelText: 'BRANCH AREA OF ACCIDENT',
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 child: TextField(
//                   controller: injury_cause,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 3,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 3, color: Color.fromARGB(255, 66, 125, 145)),
//                     ),
//                     icon: Icon(Icons.personal_injury),
//                     labelText: 'CAUSE OF INJURY',
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 child: TextField(
//                   controller: complaints,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 3,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 3, color: Color.fromARGB(255, 66, 125, 145)),
//                     ),
//                     icon: Icon(Icons.medical_information),
//                     labelText: 'INJURY DESCRIPTION',
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 child: TextField(
//                   controller: diagnosis,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 3,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 3, color: Color.fromARGB(255, 66, 125, 145)),
//                     ),
//                     icon: Icon(Icons.medical_information),
//                     labelText: 'DIAGNOSIS',
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 child: TextField(
//                   controller: examination_remarks,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 3,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 3, color: Color.fromARGB(255, 66, 125, 145)),
//                     ),
//                     icon: Icon(Icons.health_and_safety),
//                     labelText: 'EXAMINATION FINDINGS',
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 child: TextField(
//                   controller: remarks_rece,
//                   // ignore: prefer_const_constructors
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 3,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 3, color: Color.fromARGB(255, 66, 125, 145)),
//                     ),
//                     icon: Icon(Icons.read_more),
//                     labelText: 'REMARKS:',
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Divider(),
//               const SizedBox(height: 10),
//               Container(
//                 margin: const EdgeInsets.fromLTRB(10, 0, 10, 25),
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 3,
//                       blurRadius: 15,
//                       offset: Offset(5, 10), // changes position of shadow
//                     ),
//                   ],
//                 ),
//                 height: 50,
//                 padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                 child: ElevatedButton(
//                   child: const Text("SAVE"),
//                   onPressed: () {
//                     updateInjury(context);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.lightBlue,
//
//                     // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(50)),
//                   ),
//                 ),
//               ),
//             ])),
//       ),
//     );
//   }
// }
//
// class MySelectionItem extends StatelessWidget {
//   final String title;
//   final bool isForList;
//
//   const MySelectionItem({Key? key, required this.title, this.isForList = true})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 60.0,
//       child: isForList
//           ? Padding(
//               child: _buildItem(context),
//               padding: const EdgeInsets.all(10.0),
//             )
//           : Card(
//               margin: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: Stack(
//                 children: <Widget>[
//                   _buildItem(context),
//                   const Align(
//                     alignment: Alignment.centerRight,
//                     child: Icon(Icons.arrow_drop_down),
//                   )
//                 ],
//               ),
//             ),
//     );
//   }
//
//   _buildItem(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       alignment: Alignment.center,
//       child: Text(title),
//     );
//   }
// }
// //
// // class AppDataController extends GetxController {
// //   List<Injury> injuryPartData = [];
// //   List<Injury> injuryClassData = [];
// //   List<Injury> injuryTypeData = [];
// //   List<MultiSelectItem> dropDownData = [];
// //   List<MultiSelectItem> dropDownDataClass = [];
// //   List<MultiSelectItem> dropDownDataType = [];
// //
// //   getinjuryPartData() async {
// //     injuryPartData.clear();
// //     dropDownData.clear();
// //
// //     var baseUrl = "http://103.196.222.49:85/jsw/injury_part_api.php";
// //
// //     http.Response response = await http.get(Uri.parse(baseUrl));
// //
// //     // if (response.statusCode == 200) {
// //     var jsonData = json.decode(response.body);
// //     // }
// //
// //     print(jsonData);
// //
// //     Map<String, dynamic> apiResponse = jsonData;
// //
// //     List<Injury> tempinjuryPartData = [];
// //     apiResponse['data'].forEach(
// //       (data) {
// //         tempinjuryPartData.add(
// //           Injury(
// //             injuryPartId: data['part_id'],
// //             injuryPartName: data['part_name'],
// //           ),
// //         );
// //       },
// //     );
// //     print(tempinjuryPartData);
// //     injuryPartData.addAll(tempinjuryPartData);
// //
// //     dropDownData = injuryPartData.map((injuryPartData) {
// //       return MultiSelectItem(injuryPartData, injuryPartData.injuryPartName);
// //     }).toList();
// //
// //     update();
// //   }
// //
// //   getinjuryClassData() async {
// //     injuryClassData.clear();
// //     dropDownDataClass.clear();
// //
// //     var baseUrl = "http://103.196.222.49:85/jsw/injury_class_api.php";
// //
// //     http.Response response = await http.get(Uri.parse(baseUrl));
// //
// //     // if (response.statusCode == 200) {
// //     var jsonData = json.decode(response.body);
// //     // }
// //
// //     print(jsonData);
// //
// //     Map<String, dynamic> apiResponse = jsonData;
// //
// //     List<Injury> tempinjuryClassData = [];
// //     apiResponse['data'].forEach(
// //       (data) {
// //         tempinjuryClassData.add(
// //           Injury(
// //             injuryClassId: data['class_id'],
// //             injuryClassName: data['class_name'],
// //           ),
// //         );
// //       },
// //     );
// //     print(tempinjuryClassData);
// //     injuryClassData.addAll(tempinjuryClassData);
// //
// //     dropDownDataClass = injuryClassData.map((injuryClassData) {
// //       return MultiSelectItem(injuryClassData, injuryClassData.injuryClassName);
// //     }).toList();
// //
// //     update();
// //   }
// //
// //   getinjuryTypeData() async {
// //     injuryTypeData.clear();
// //     dropDownDataType.clear();
// //
// //     var baseUrl = "http://103.196.222.49:85/jsw/injury_type_api.php";
// //
// //     http.Response response = await http.get(Uri.parse(baseUrl));
// //
// //     // if (response.statusCode == 200) {
// //     var jsonData = json.decode(response.body);
// //     // }
// //
// //     print(jsonData);
// //
// //     Map<String, dynamic> apiResponse = jsonData;
// //
// //     List<Injury> tempinjuryTypeData = [];
// //     apiResponse['data'].forEach(
// //       (data) {
// //         tempinjuryTypeData.add(
// //           Injury(
// //             injuryTypeId: data['type_id'],
// //             injuryTypeName: data['type_name'],
// //           ),
// //         );
// //       },
// //     );
// //     print(tempinjuryTypeData);
// //     injuryTypeData.addAll(tempinjuryTypeData);
// //
// //     dropDownDataType = injuryTypeData.map((injuryTypeData) {
// //       return MultiSelectItem(injuryTypeData, injuryTypeData.injuryTypeName);
// //     }).toList();
// //
// //     update();
// //   }
// // }
// ignore_for_file: use_build_context_synchronously, unused_import, non_constant_identifier_names, unused_local_variable, prefer_const_constructors, duplicate_ignore, unnecessary_brace_in_string_interps, sort_child_properties_last, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:ohctech/models/medicine.dart';
import 'package:ohctech/models/patient.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ohctech/pages/home.dart';
// import 'adddynamic.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class injuryForm extends StatefulWidget {
  final Patient patient;
//
  const injuryForm({Key? key, required this.patient})
      : super(key: key);

  @override
  State<injuryForm> createState() => _injuryFormState();
}

class _injuryFormState extends State<injuryForm> {
  final MultiSelectController _controller = MultiSelectController();
  List<String> selectedAppointments = [];
  List<String> selectedcomplaint = [];
  List<String> selectedignosis = [];
  List<String> selecterecomntest = [];
  TextEditingController _textController1 = TextEditingController();
  TextEditingController intime = TextEditingController();
  TextEditingController clearencetime = TextEditingController();
  TextEditingController ticket_no = TextEditingController();
  TextEditingController complaints = TextEditingController();


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
      intime.text = formattedDate;
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
      clearencetime.text = formattedDate;
    }
  }
  List<dynamic> appointments = [];
  List<dynamic> complaint =[];
  List<dynamic> dignosis =[];
  List<dynamic> recomntest =[];
  Future<void> fetchdignosis() async {
    final response = await http.get(Uri.parse('http://192.168.248.56/tvsmotors/api2/opd_edit_dignosis.php'));
    if (response.statusCode == 200) {
      setState(() {
        dignosis = json.decode(response.body); // Assuming the response body is a JSON array of appointments
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  }
  List<dynamic> discasetype =[];
  var selectedicasetype;
  Future<void> fetchdiscasetype() async {
    final response = await http.get(Uri.parse('http://192.168.248.56/tvsmotors/api2/opd_edit_discasetype.php'));
    if (response.statusCode == 200) {
      setState(() {
        discasetype = json.decode(response.body); // Assuming the response body is a JSON array of appointments
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  }
  List<dynamic> healthstatus =[];
  var selecthealthstatus;
  Future<void> fetchhealthstatus() async {
    final response = await http.get(Uri.parse('http://192.168.248.56/tvsmotors/api2/opdedit_Health_Status.php'));
    if (response.statusCode == 200) {
      setState(() {
        healthstatus = json.decode(response.body); // Assuming the response body is a JSON array of appointments
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  }
  List<dynamic> ApprovalStatus =[];
  var selectApprovalStatus;
  Future<void> fetchApprovalStatus() async {
    final response = await http.get(Uri.parse('http://192.168.248.56/tvsmotors/api2/opdeditApproval_Statu.php'));
    if (response.statusCode == 200) {
      setState(() {
        ApprovalStatus = json.decode(response.body); // Assuming the response body is a JSON array of appointments
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  }
  Future<void> fetchrecomntest() async {
    final response = await http.get(Uri.parse('http://192.168.248.56/tvsmotors/api2/opd_edit_recomentest.php'));
    if (response.statusCode == 200) {
      setState(() {
        recomntest = json.decode(response.body); // Assuming the response body is a JSON array of appointments
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  }
  // Function to fetch appointments from the API
  Future<void> fetchAppointments() async {
    final response = await http.get(Uri.parse('http://192.168.248.56/tvsmotors/api2/opd_edit.fallowup.php'));
    if (response.statusCode == 200) {
      setState(() {
        appointments = json.decode(response.body); // Assuming the response body is a JSON array of appointments
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  }
  List<ValueItem> ailments = [];
  List<ValueItem> selectedAilments = [];
  // Future<void> fetchAilments() async {
  //   // Replace 'YOUR_API_ENDPOINT' with your actual API endpoint
  //   final response = await http.get(Uri.parse('http://192.168.248.56/tvsmotors/api2/opd_edit_dignosis.php'));
  //
  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body);
  //     setState(() {
  //       ailments = data.map((item) {
  //         return ValueItem(label: item['ailment_name'], value: item['ailment_id']);
  //       }).toList();
  //     });
  //   } else {
  //     throw Exception('Failed to load ailments');
  //   }
  // }
  Future<void> fetchcomplaints() async {
    final response = await http.get(Uri.parse('http://192.168.248.56/tvsmotors/api2/opd_edit_complaints.php'));
    if (response.statusCode == 200) {
      setState(() {
        complaint = json.decode(response.body); // Assuming the response body is a JSON array of appointments
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  }
  String companyCode = "";
  String companyurl = "";

  Future<void> _loadCompanyCode() async {
    final prefs = await SharedPreferences.getInstance();
    companyCode = prefs.getString('companyCode') ?? "";
    companyurl = prefs.getString('companyurl') ?? "";
  }

  Future<dynamic> updateInjury(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    var url = companyurl+'injury_update.php';
    http.Response response = await http.post(Uri.parse(url), body: {
      "ticket_no": ticket_no.text,
      "complaints": complaints.text,
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
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    DateTime currentDate = DateTime.now();
    intime.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    clearencetime.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    super.initState();
    fetchAppointments();
    fetchdignosis();
    fetchcomplaints();
    fetchdiscasetype();
    _loadCompanyCode();
    fetchrecomntest();
    fetchhealthstatus();
    fetchApprovalStatus();
    // fetchAilments();
    Patient dm;
    dm = widget.patient;
    var visitDate;
    ticket_no.text = dm.ticket_no??'';
    complaints.text=dm.complaints??'';
    // _controller.text = widget.patient.complaints ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Update Opd Details",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.lightBlue,
        ),
        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textController1, // Set text color to black
                            decoration: InputDecoration(
                              labelText: 'Weight', labelStyle: TextStyle(color: Colors.black), // Set label color to black
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black), // Set border color to white
                              ),
                              filled: true, // Set background color to white
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Add spacing between text fields
                        Expanded(
                          child: TextField(
                            controller: _textController1, // Set text color to black
                            decoration: InputDecoration(
                              labelText: 'Height', labelStyle: TextStyle(color: Colors.black), // Set label color to black
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black), // Set border color to white
                              ),
                              filled: true, // Set background color to white
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textController1, // Set text color to black
                            decoration: InputDecoration(
                              labelText: 'BMI',  labelStyle: TextStyle(color: Colors.black),// Set label color to black
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black), // Set border color to white
                              ),
                              filled: true, // Set background color to white
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Add spacing between text fields
                        Expanded(
                          child: TextField(
                            controller: _textController1, // Set text color to black
                            decoration: InputDecoration(
                              labelText: 'SBP', labelStyle: TextStyle(color: Colors.black), // Set label color to black
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black), // Set border color to white
                              ),
                              filled: true, // Set background color to white
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textController1, // Set text color to black
                            decoration: InputDecoration(
                              labelText: 'DBP', labelStyle: TextStyle(color: Colors.black), // Set label color to black
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black), // Set border color to white
                              ),
                              filled: true, // Set background color to white
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Add spacing between text fields
                        Expanded(
                          child: TextField(
                            controller: _textController1, // Set text color to black
                            decoration: InputDecoration(
                              labelText: 'Tempeeature',  labelStyle: TextStyle(color: Colors.black),// Set label color to black
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black), // Set border color to white
                              ),
                              filled: true, // Set background color to white
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textController1, // Set text color to black
                            decoration: InputDecoration(
                              labelText: 'R Rate', labelStyle: TextStyle(color: Colors.black), // Set label color to black
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black), // Set border color to white
                              ),
                              filled: true, // Set background color to white
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Add spacing between text fields
                        Expanded(
                          child: TextField(
                            controller: _textController1, // Set text color to black
                            decoration: InputDecoration(
                              labelText: 'Heart Point', labelStyle: TextStyle(color: Colors.black), // Set label color to black
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black), // Set border color to white
                              ),
                              filled: true, // Set background color to white
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textController1, // Set text color to black
                            decoration: InputDecoration(
                              labelText: 'Heart Rate', labelStyle: TextStyle(color: Colors.black), // Set label color to black
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black), // Set border color to white
                              ),
                              filled: true, // Set background color to white
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Add spacing between text fields
                        Expanded(
                          child: TextField(
                            controller: _textController1, // Set text color to black
                            decoration: InputDecoration(
                              labelText: 'Pulse', labelStyle: TextStyle(color: Colors.black), // Set label color to black
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black), // Set border color to white
                              ),
                              filled: true, // Set background color to white
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textController1, // Set text color to black
                            decoration: InputDecoration(
                              labelText: 'SPO2',  labelStyle: TextStyle(color: Colors.black),// Set label color to black
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black), // Set border color to white
                              ),
                              filled: true, // Set background color to white
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Add spacing between text fields
                        Expanded(
                          child: TextField(
                            controller: _textController1, // Set text color to black
                            decoration: InputDecoration(
                              labelText: 'GC SCALE', labelStyle: TextStyle(color: Colors.black), // Set label color to black
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black), // Set border color to white
                              ),
                              filled: true, // Set background color to white
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: ticket_no, // Set text color to black
                      decoration: InputDecoration(
                        labelText: 'Medical Record No',  labelStyle: TextStyle(color: Colors.black),// Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ), // Set background color to white
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: intime,
                      readOnly: true,
                      onTap: () {
                        // Open date picker when TextField is clicked
                        intimedate(context);
                      },// Set text color to black
                      decoration: InputDecoration(
                        labelText: 'In Time', labelStyle: TextStyle(color: Colors.black), // Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Open date picker when calendar icon is clicked
                            clearencedate(context);
                          },
                          icon: Icon(Icons.calendar_today),
                        ),// Set background color to white
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: clearencetime,
                      readOnly: true,
                      onTap: () {
                        // Open date picker when TextField is clicked
                        clearencedate(context);
                      },// Set text color to black
                      decoration: InputDecoration(
                        labelText: 'Clearance Time',  labelStyle: TextStyle(color: Colors.black),// Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Open date picker when calendar icon is clicked
                            clearencedate(context);
                          },
                          icon: Icon(Icons.calendar_today),
                        ),// Set background color to white
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black), // Set the border color
                        borderRadius: BorderRadius.circular(0), // Set the border radius
                      ),
                      child: SingleChildScrollView(
                        child: MultiSelectDialogField(
                          items: appointments.map((appointment) {
                            return MultiSelectItem<String>(
                              appointment['appointment_id'],
                              appointment['fallowupdetails'],
                            );
                          }).toList(),
                          initialValue: selectedAppointments,
                          searchable: true,
                          dialogHeight: 250,
                          buttonIcon: Icon(Icons.arrow_drop_down,size: 30,),
                          buttonText: Text("Followup to (if Applicable)",),
                          checkColor: null, // Set the checkIcon property to null
                          onConfirm: (values) {
                            setState(() {
                              selectedAppointments = values;
                            });
                          },

                          // validator: (values) {
                          //   if (values == null || values.isEmpty) {
                          //     return 'Please select at least one diagnosis';
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Complaints',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    // TextField(
                    //   controller: complaints, // Set text color to black
                    //   decoration: InputDecoration(
                    //     labelText: 'Complaints', labelStyle: TextStyle(color: Colors.black),// Set label color to black
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.black), // Set border color to white
                    //     ), // Set background color to white
                    //   ),
                    // ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black), // Set the border color
                        borderRadius: BorderRadius.circular(0), // Set the border radius
                      ),
                      child: SingleChildScrollView(
                        child: MultiSelectDialogField(
                          items: complaint.map((complaint) {
                            return MultiSelectItem<String>(
                              complaint['complaint_id'],
                              complaint['complaint'],
                            );
                          }).toList(),
                          initialValue: selectedcomplaint,
                          searchable: true,
                          dialogHeight: 250,
                          buttonIcon: Icon(Icons.arrow_drop_down,size: 30,),
                          buttonText: Text(widget.patient.complaints.toString()??'select complaints'),
                          checkColor: null, // Set the checkIcon property to null
                          onConfirm: (values) {
                            setState(() {
                              selectedcomplaint = values;
                            });
                          },

                          // validator: (values) {
                          //   if (values == null || values.isEmpty) {
                          //     return 'Please select at least one diagnosis';
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    // MultiSelectDropDown(
                    //   controller: _controller,
                    //   onOptionSelected: (List<ValueItem> selectedOptions) {
                    //     setState(() {
                    //       selectedAilments = selectedOptions;
                    //     });
                    //   },
                    //   searchEnabled: true,// Enable search functionality
                    //   options: ailments,
                    //   selectionType: SelectionType.multi,
                    //   chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                    //   dropdownHeight: 300,
                    //   optionTextStyle: const TextStyle(fontSize: 16),
                    //   selectedOptionIcon: const Icon(Icons.check_circle),
                    // ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black), // Set the border color
                        borderRadius: BorderRadius.circular(0), // Set the border radius
                      ),
                      child: SingleChildScrollView(
                        child: MultiSelectDialogField(
                          items: dignosis.map((dignosis) {
                            return MultiSelectItem<String>(
                              dignosis['ailment_id'],
                              dignosis['ailment_name'],
                            );
                          }).toList(),
                          initialValue: selectedignosis,
                          searchable: true,
                          dialogHeight: 250,
                          buttonIcon: Icon(Icons.arrow_drop_down,size: 30,),
                          buttonText: Text("Diagnosis",),
                          checkColor: null, // Set the checkIcon property to null
                          onConfirm: (values) {
                            setState(() {
                              selectedignosis = values;
                            });
                          },

                          // validator: (values) {
                          //   if (values == null || values.isEmpty) {
                          //     return 'Please select at least one diagnosis';
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                    ),
                    // TextField(
                    //   controller: _textController1, // Set text color to black
                    //   decoration: InputDecoration(
                    //     labelText: 'Diagnosis',  labelStyle: TextStyle(color: Colors.black),// Set label color to black
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.black), // Set border color to white
                    //     ), // Set background color to white
                    //   ),
                    // ),
                    SizedBox(height: 10,),
                    Text('Discase Type',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black), // Add border here
                        ),
                        child: DropdownButton(
                            isExpanded: true,
                            hint:Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text("Select Discase Type",style: TextStyle(fontWeight:FontWeight.bold ),),
                            ),
                            value: selectedicasetype,
                            items: discasetype.map((e){
                              return DropdownMenuItem(
                                  value:e ['velue'].toString(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(e['disease_type'].toString()),
                                  ));
                            }).toList(),
                            onChanged:(value){
                              setState(() {
                                selectedicasetype=value;
                              });
                            }),
                      ),
                      //color: Color.fromARGB(255, 148, 204, 242),
                      //elevation: 5,
                    ),
                    // TextFormField(
                    //   controller: _textController1, // Set text color to black
                    //   decoration: InputDecoration(
                    //     labelText: 'Disease Type', // Set label color to black
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.black), // Set border color to white
                    //     ), // Set background color to white
                    //   ),
                    // ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _textController1, // Set text color to black
                      decoration: InputDecoration(
                        labelText: 'Advices', // Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ), // Set background color to white
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _textController1, // Set text color to black
                      decoration: InputDecoration(
                        labelText: 'Follow-up date', // Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Open date picker when calendar icon is clicked
                            clearencedate(context);
                          },
                          icon: Icon(Icons.calendar_today),
                        ),// Set background color to white
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _textController1, // Set text color to black
                      decoration: InputDecoration(
                        labelText: 'History of Drug Allergies', // Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ), // Set background color to white
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Recommended Tests',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black), // Set the border color
                        borderRadius: BorderRadius.circular(0), // Set the border radius
                      ),
                      child: SingleChildScrollView(
                        child: MultiSelectDialogField(
                          items: recomntest.map((complaint) {
                            return MultiSelectItem<String>(
                              complaint['section_id'],
                              complaint['section_name'],
                            );
                          }).toList(),
                          initialValue: selecterecomntest,
                          searchable: true,
                          dialogHeight: 250,
                          buttonIcon: Icon(Icons.arrow_drop_down,size: 30,),
                          buttonText: Text('select cRecommended Tests'),
                          checkColor: null, // Set the checkIcon property to null
                          onConfirm: (values) {
                            setState(() {
                              selectedcomplaint = values;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Recommended Test Parameters',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black), // Set the border color
                        borderRadius: BorderRadius.circular(0), // Set the border radius
                      ),
                      child: SingleChildScrollView(
                        child: MultiSelectDialogField(
                          items: recomntest.map((complaint) {
                            return MultiSelectItem<String>(
                              complaint['section_id'],
                              complaint['section_name'],
                            );
                          }).toList(),
                          initialValue: selecterecomntest,
                          searchable: true,
                          dialogHeight: 250,
                          buttonIcon: Icon(Icons.arrow_drop_down,size: 30,),
                          buttonText: Text('Recommended Test Parameters'),
                          checkColor: null, // Set the checkIcon property to null
                          onConfirm: (values) {
                            setState(() {
                              selectedcomplaint = values;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _textController1, // Set text color to black
                      decoration: InputDecoration(
                        labelText: 'Doctor Comment', // Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ), // Set background color to white
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _textController1, // Set text color to black
                      decoration: InputDecoration(
                        labelText: 'Period Of Rest From', // Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Open date picker when calendar icon is clicked
                            clearencedate(context);
                          },
                          icon: Icon(Icons.calendar_today),
                        ),// Set background color to white
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _textController1, // Set text color to black
                      decoration: InputDecoration(
                        labelText: 'Period Of Rest To', // Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Open date picker when calendar icon is clicked
                            clearencedate(context);
                          },
                          icon: Icon(Icons.calendar_today),
                        ),// Set background color to white
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _textController1, // Set text color to black
                      decoration: InputDecoration(
                        labelText: 'Fitness Date', // Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Open date picker when calendar icon is clicked
                            clearencedate(context);
                          },
                          icon: Icon(Icons.calendar_today),
                        ),// Set background color to white
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Health Status',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black), // Add border here
                        ),
                        child: DropdownButton(
                            isExpanded: true,
                            hint:Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text("Select Health Status",style: TextStyle(fontWeight:FontWeight.bold ),),
                            ),
                            value: selecthealthstatus,
                            items: healthstatus.map((e){
                              return DropdownMenuItem(
                                  value:e ['velue'].toString(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(e['Health_Status'].toString()),
                                  ));
                            }).toList(),
                            onChanged:(value){
                              setState(() {
                                selecthealthstatus=value;
                              });
                            }),
                      ),
                    ),
                    // SizedBox(height: 10,),
                    // TextField(
                    //   controller: _textController1, // Set text color to black
                    //   decoration: InputDecoration(
                    //     labelText: 'Health Status', // Set label color to black
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.black), // Set border color to white
                    //     ), // Set background color to white
                    //   ),
                    // ),
                    // SizedBox(height: 10,),
                    // TextField(
                    //   controller: _textController1, // Set text color to black
                    //   decoration: InputDecoration(
                    //     labelText: 'Approval Status', // Set label color to black
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.black), // Set border color to white
                    //     ), // Set background color to white
                    //   ),
                    // ),
                    SizedBox(height: 10,),
                    Text('Approval Status',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black), // Add border here
                        ),
                        child: DropdownButton(
                            isExpanded: true,
                            hint:Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text("Select Approval Status",style: TextStyle(fontWeight:FontWeight.bold ),),
                            ),
                            value: selectApprovalStatus,
                            items: ApprovalStatus.map((e){
                              return DropdownMenuItem(
                                  value:e ['velue'].toString(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(e['Approval_Status'].toString()),
                                  ));
                            }).toList(),
                            onChanged:(value){
                              setState(() {
                                selectApprovalStatus=value;
                              });
                            }),
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _textController1, // Set text color to black
                      decoration: InputDecoration(
                        labelText: 'Referral', // Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _textController1, // Set text color to black
                      decoration: InputDecoration(
                        labelText: 'Referral Remark', // Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ), // Set background color to white
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _textController1, // Set text color to black
                      decoration: InputDecoration(
                        labelText: 'Time if Patient Admitted in Hospital:', // Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Open date picker when calendar icon is clicked
                            clearencedate(context);
                          },
                          icon: Icon(Icons.calendar_today),
                        ),// Set background color to white
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _textController1, // Set text color to black
                      decoration: InputDecoration(
                        labelText: 'Ambulance Used: Yes/No', // Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ), // Set background color to white
                      ),
                    ),
                    //SizedBox(height: 10),
                    // Center(
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: <Widget>[
                    //       ElevatedButton(
                    //         onPressed: _selectFile,
                    //         child: Text('Select File'),
                    //       ),
                    //       SizedBox(height: 20),
                    //       if (_selectedFile != null)
                    //         Text('Selected File: ${_selectedFile!.name}'),
                    //       SizedBox(height: 20),
                    //       ElevatedButton(
                    //         onPressed: _uploadFile,
                    //         child: Text('Upload File'),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Processing Data')));
                        }
                      },
                      child: Center(child: Text('Save')),
                    ),
                  ],),
              ),
            ),
          ),
        ),
      ),
    );
  }
}