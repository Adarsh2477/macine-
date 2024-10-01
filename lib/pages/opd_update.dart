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
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ohctech/pages/home.dart';
// import 'adddynamic.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
//
// // void main() {
// //   runApp(opdForm(
// //     patient: null,
// //   ));
// // }
//
// class opdForm extends StatefulWidget {
//
//   final Patient patient;
//
//   const opdForm({Key? key, required this.patient})
//       : super(key: key);
//
//   @override
//   State<opdForm> createState() => _opdFormState();
// }
//
// class _GroupControllers {
//   TextEditingController duration = TextEditingController();
//   TextEditingController frequency = TextEditingController();
//   TextEditingController doseqty = TextEditingController();
//   void dispose() {
//     duration.dispose();
//     frequency.dispose();
//     doseqty.dispose();
//   }
// }
//
// class _opdFormState extends State<opdForm> {
//   TextEditingController patientName = TextEditingController();
//   TextEditingController ticket_no = TextEditingController();
//   TextEditingController complaints = TextEditingController();
//   TextEditingController diagnosis = TextEditingController();
//   TextEditingController examination_remarks = TextEditingController();
//   TextEditingController remarks_rece = TextEditingController();
//   TextEditingController appointment_date = TextEditingController();
//   TextEditingController duration = TextEditingController();
//   TextEditingController dose_qty = TextEditingController();
//   List<_GroupControllers> _groupControllers = [];
//   // List<TextField> _medicineFields = [];
//   List<TextField> _DurationFields = [];
//   List<TextField> _DoseQTYFields = [];
//   List<dynamic> _TimingFieldsDrop = [];
//   List<dynamic> _MedicineFieldsDrop = [];
//   List<dynamic> _FrequencyFieldsDrop = [];
//   List<dynamic> _AdminRouteFieldsDrop = [];
//   bool error = false, dataloaded = false;
//   var data;
//
//   String companyCode = "";
//   String companyurl = "";
//
//   void _loadCompanyCode() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     setState(() {
//       companyCode = prefs.getString('companyCode') ?? "";
//       companyurl = prefs.getString('companyurl') ?? "";
//     });
//   }
//   @override
//   void dispose() {
//     for (final controller in _groupControllers) {
//       controller.dispose();
//     }
//     _okController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     _loadCompanyCode();
//     // loaddata();
//     getAllCategory();
//     getAllMedicines();
//     getAllFrequency();
//     getAllTimings();
//     getAllAdminroute();
//     super.initState();
//     Patient dm;
//     dm = widget.patient;
//     var visitDate;
//     ticket_no.text = dm.ticket_no??'';
//     patientName.text = dm.patient_name??'';
//     complaints.text = dm.complaints??'';
//     diagnosis.text = dm.diagnosis??'';
//     examination_remarks.text = dm.examination_remarks??'';
//     remarks_rece.text = dm.remarks_rece??'';
//     visitDate = dm.appointment_date??'';
//     appointment_date.text = visitDate;
//   }
//
//   // void loaddata() {
//   //   Future.delayed(Duration.zero, () async {
//   //     var res;
//   //     try {
//   //       String dataurl = companyurl+'api2/pending_opd_list.php';
//   //       res = await http.post(Uri.parse(dataurl));
//   //       if (res.statusCode == 200) {
//   //         setState(() {
//   //           data = json.decode(res.body);
//   //           dataloaded = true;
//   //         });
//   //       } else {
//   //         //there is error
//   //         setState(() {
//   //           error = true;
//   //         });
//   //       }
//   //     } catch (e) {
//   //       print(e);
//   //     }
//   //   });
//   //   // we use Future.delayed becuase there is
//   //   // async function inside it.
//   // }
//
//   late String gender;
//   var iteams = [
//     "Select Disease Type",
//     "COMMUNICABLE",
//     "NON-COUMMINCABLE",
//   ];
//   List<Widget> _buildItems1() {
//     return iteams
//         .map((val) => MySelectionItem(
//               title: val,
//             ))
//         .toList();
//   }
//
//   var caseType = [
//     "Select Case Type",
//     "New Case",
//     "Repeat",
//     "Follow Up",
//     "Medication",
//   ];
//
//   List<Widget> _buildItems2() {
//     return caseType
//         .map((val) => MySelectionItem(
//               title: val,
//             ))
//         .toList();
//   }
//
//   var bodySystem = [
//     "Select Body System",
//     "New Case",
//     "Dushant",
//     "Follow Up",
//     "Medication",
//   ];
//   List<Widget> _buildItems3() {
//     return bodySystem
//         .map((val) => MySelectionItem(
//               title: val,
//             ))
//         .toList();
//   }
//
//   List categoryItemlist = [];
//
//   Future getAllCategory() async {
//     await Future.delayed(Duration(seconds: 0));
//     var baseUrl = companyurl+'api2/bodysystemapi.php';
//
//     http.Response response = await http.get(Uri.parse(baseUrl));
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       setState(() {
//         categoryItemlist = jsonData;
//       });
//     }
//   }
//
//   List medicinelist = [];
//
//   Future getAllMedicines() async {
//     await Future.delayed(Duration(seconds: 0));
//     var baseUrl =  companyurl+'api2/medicines_api.php';
//
//     http.Response response = await http.get(Uri.parse(baseUrl));
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       setState(() {
//         medicinelist = jsonData;
//       });
//     }
//   }
//
//   List frequencylist = [];
//
//   Future getAllFrequency() async {
//     await Future.delayed(Duration(seconds: 0));
//     var baseUrl = companyurl+'api2/frequency_api.php';
//
//     http.Response response = await http.get(Uri.parse(baseUrl));
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       setState(() {
//         frequencylist = jsonData;
//       });
//     }
//   }
//
//   List timingslist = [];
//
//   Future getAllTimings() async {
//     await Future.delayed(Duration(seconds: 0));
//     var baseUrl = companyurl+'api2/timings_api.php';
//
//     http.Response response = await http.get(Uri.parse(baseUrl));
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       setState(() {
//         timingslist = jsonData;
//       });
//     }
//   }
//
//   List adminRoutelist = [];
//
//   Future getAllAdminroute() async {
//     await Future.delayed(Duration(seconds: 0));
//     var baseUrl = companyurl+'api2/adminroute_api.php';
//
//     http.Response response = await http.get(Uri.parse(baseUrl));
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       setState(() {
//         adminRoutelist = jsonData;
//       });
//     }
//   }
//
//   var dropdownvalue;
//   var dropdownValueMedicine;
//   var dropdownValueFrequency;
//   var dropdownValue;
//   Map<String, int> dropdownVal = <String, int>{};
//   var dropdownValueAdminroute;
//   var len;
//
//   Future<dynamic> updateOPD(BuildContext context) async {
//     await Future.delayed(Duration(seconds: 0));
//     var url = companyurl+'api2/opd_update.php';
//     http.Response response = await http.post(Uri.parse(url), body: {
//       "ticket_no": ticket_no.text,
//       "ailments_new": dropdownvalue,
//       "complaints": complaints.text,
//       "diagnosis": diagnosis.text,
//       "examination_remarks": examination_remarks.text,
//       "remarks_rece": remarks_rece.text,
//       "appointment_date": appointment_date.text,
//       "lenght": len,
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
//     var vdate;
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text(
//             "Update Opd Details",
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
//                     labelText: "TICKET NO",
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
//                 "\nVisit Date\n",
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
//               const Padding(
//                 padding: EdgeInsets.only(left: 10.0),
//                 child: Text(
//                   "\n\n AILMENT SYSTEM",
//                   style: TextStyle(
//                       color: Colors.grey, fontWeight: FontWeight.w500),
//                 ),
//               ),
//               // DropdownButtonHideUnderline(
//               //   child: DropdownButton2(
//               //     isExpanded: true,
//               //     hint: Row(
//               //       children: const [
//               //         Icon(
//               //           Icons.list,
//               //           size: 16,
//               //           color: Colors.white,
//               //         ),
//               //         SizedBox(
//               //           width: 4,
//               //         ),
//               //         Expanded(
//               //           child: Text(
//               //             'Select Item',
//               //             style: TextStyle(
//               //               fontSize: 14,
//               //               fontWeight: FontWeight.bold,
//               //               color: Colors.white,
//               //             ),
//               //             overflow: TextOverflow.ellipsis,
//               //           ),
//               //         ),
//               //       ],
//               //     ),
//               //     items: categoryItemlist.map((item) {
//               //       return DropdownMenuItem(
//               //         value: item['ailment_sys_name'].toString(),
//               //         child: Text(item['ailment_sys_name'].toString()),
//               //       );
//               //     }).toList(),
//               //     value: dropdownvalue,
//               //     onChanged: (newVal) {
//               //       setState(() {
//               //         dropdownvalue = newVal;
//               //       });
//               //     },
//               //     icon: const Icon(
//               //       Icons.arrow_circle_down_outlined,
//               //     ),
//               //     iconSize: 14,
//               //     iconEnabledColor: Colors.black,
//               //     iconDisabledColor: Colors.grey,
//               //     buttonHeight: 50,
//               //     buttonWidth: 160,
//               //     buttonPadding: const EdgeInsets.only(left: 14, right: 14),
//               //     buttonDecoration: BoxDecoration(
//               //       borderRadius: BorderRadius.circular(14),
//               //       border: Border.all(
//               //         color: Colors.black26,
//               //       ),
//               //       color: Colors.lightBlue,
//               //     ),
//               //     buttonElevation: 2,
//               //     itemHeight: 40,
//               //     itemPadding: const EdgeInsets.only(left: 30, right: 14),
//               //     dropdownMaxHeight: 200,
//               //     dropdownWidth: 300,
//               //     dropdownPadding: null,
//               //     dropdownDecoration: BoxDecoration(
//               //       borderRadius: BorderRadius.circular(14),
//               //       color: Colors.lightBlueAccent,
//               //     ),
//               //     dropdownElevation: 8,
//               //     scrollbarRadius: const Radius.circular(40),
//               //     scrollbarThickness: 6,
//               //     scrollbarAlwaysShow: true,
//               //     offset: const Offset(20, 0),
//               //   ),
//               // ),
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
//                     labelText: 'COMPLAINTS',
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
//                     icon: Icon(Icons.numbers),
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
//                     icon: Icon(Icons.history),
//                     labelText: 'REMARKS:',
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               _addTile(),
//               Expanded(child: _listView()),
//               _okButton(context),
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
//                     updateOPD(context);
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
//
//       ),
//     );
//   }
//
//   Widget _addTile() {
//     return ListTile(
//       leading: Icon(
//         Icons.add,
//         size: 40,
//         color: Colors.lightBlue,
//       ),
//       title: Text(
//         "Medicine Disbursement",
//         style: TextStyle(
//           fontSize: 25,
//         ),
//       ),
//       onTap: () {
//         final group = _GroupControllers();
//
//         final DurationField = _generateTextField(group.duration, "Duration");
//         final frequencyField = _generateTextField(group.frequency, "Frequency");
//         final DoseQTYField = _generateTextField(group.doseqty, "Dose QTY");
//         final TimingDrop =
//             _generateDropdownField('Timing', timingslist, 'medicine_timing');
//         final MedicineDrop =
//             _generateDropdownField('Medicine', medicinelist, 'item_name');
//         final FrequencyDrop = _generateDropdownField(
//             'Frequency', frequencylist, 'medicine_frequency');
//         final AdminRouteDrop = _generateDropdownField(
//             'Admin Route', adminRoutelist, 'dosage_category');
//
//         setState(() {
//           _groupControllers.add(group);
//           // _medicineFields.add(medicineField);
//           _DurationFields.add(DurationField);
//           _DoseQTYFields.add(DoseQTYField);
//           _TimingFieldsDrop.add(TimingDrop);
//           _MedicineFieldsDrop.add(MedicineDrop);
//           _FrequencyFieldsDrop.add(FrequencyDrop);
//           _AdminRouteFieldsDrop.add(AdminRouteDrop);
//         });
//       },
//     );
//   }
//
//   TextField _generateTextField(TextEditingController controller, String hint) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: hint,
//       ),
//     );
//   }
//
//   DropdownButton2 _generateDropdownField(
//       String titleDrop, List itemData, String itemValue) {
//     return DropdownButton2(
//       isExpanded: true,
//       hint: Row(
//         children: [
//           // ignore: prefer_const_constructors
//           Icon(
//             Icons.list,
//             size: 16,
//             color: Color.fromARGB(255, 249, 248, 244),
//           ),
//           SizedBox(
//             width: 4,
//           ),
//           Expanded(
//             child: Text(
//               "Select  ${titleDrop}",
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromARGB(255, 240, 240, 238),
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ), items: [],
//     //   items: itemData.map((item) {
//     //     return DropdownMenuItem(
//     //       value: item[itemValue],
//     //       child: Text(
//     //         item[itemValue],
//     //         style: TextStyle(color: Color.fromARGB(255, 240, 240, 238)),
//     //       ),
//     //     );
//     //   }).toList(),
//     //   value: dropdownVal[titleDrop],
//     //   onChanged: (newVal) {
//     //     setState(() {
//     //       dropdownVal[titleDrop] = newVal;
//     //     });
//     //   },
//     //   icon: const Icon(
//     //     Icons.arrow_circle_down_outlined,
//     //   ),
//     //   iconSize: 14,
//     //   iconEnabledColor: Colors.black,
//     //   iconDisabledColor: Colors.grey,
//     //   buttonHeight: 50,
//     //   // buttonWidth: 160,
//     //   buttonPadding: const EdgeInsets.only(left: 14, right: 14),
//     //   buttonDecoration: BoxDecoration(
//     //     borderRadius: BorderRadius.circular(14),
//     //     border: Border.all(
//     //       color: Colors.black26,
//     //     ),
//     //     color: Colors.lightBlue,
//     //   ),
//     //   buttonElevation: 2,
//     //   itemHeight: 40,
//     //   itemPadding: const EdgeInsets.only(left: 30, right: 14),
//     //   dropdownMaxHeight: 200,
//     //   dropdownWidth: 300,
//     //   dropdownPadding: null,
//     //   dropdownDecoration: BoxDecoration(
//     //     borderRadius: BorderRadius.circular(14),
//     //     color: Colors.lightBlueAccent,
//     //   ),
//     //   dropdownElevation: 8,
//     //   scrollbarRadius: const Radius.circular(40),
//     //   scrollbarThickness: 6,
//     //   scrollbarAlwaysShow: true,
//     //   offset: const Offset(20, 0),
//      );
//   }
//
//   Widget _listView() {
//     len = _groupControllers.length;
//     final children = [
//       for (var i = 0; i < _groupControllers.length; i++)
//         Container(
//           margin: EdgeInsets.all(5),
//           child: InputDecorator(
//             child: Column(
//               children: [
//                 // _TimingFields[i],
//                 _TimingFieldsDrop[i],
//                 SizedBox(
//                   height: 10,
//                 ),
//                 _MedicineFieldsDrop[i],
//                 SizedBox(
//                   height: 10,
//                 ),
//                 _FrequencyFieldsDrop[i],
//                 SizedBox(
//                   height: 10,
//                 ),
//                 _AdminRouteFieldsDrop[i],
//                 SizedBox(
//                   height: 10,
//                 ),
//                 _DoseQTYFields[i],
//                 SizedBox(
//                   height: 10,
//                 ),
//                 _DurationFields[i],
//                 SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//             decoration: InputDecoration(
//               labelText: i.toString(),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//             ),
//           ),
//         )
//     ];
//     return SingleChildScrollView(
//       child: Column(
//         children: children,
//       ),
//     );
//   }
//
//   final _okController = TextEditingController();
//   Widget _okButton(BuildContext context) {
//     final textField = TextField(
//       controller: _okController,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//       ),
//     );
//
//     final button = ElevatedButton(
//       onPressed: () async {
//         final index = int.parse(_okController.text);
//         String text = "Duration: ${_groupControllers[index].duration.text}\n" +
//             "Frequency: ${_groupControllers[index].frequency.text}\n" +
//             "Dose: ${_groupControllers[index].doseqty.text}\n";
//         // await print(text);
//       },
//       child: Text("OK"),
//     );
//
//     return Row(
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         button,
//       ],
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
class opdForm extends StatefulWidget {
  final Patient patient;
//
  const opdForm({Key? key, required this.patient})
      : super(key: key);

  @override
  State<opdForm> createState() => _opdFormState();
}

class _opdFormState extends State<opdForm> {
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
  Future<void> fetchAilments() async {
    // Replace 'YOUR_API_ENDPOINT' with your actual API endpoint
    final response = await http.get(Uri.parse('http://192.168.248.56/tvsmotors/api2/opd_edit_dignosis.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        ailments = data.map((item) {
          return ValueItem(label: item['ailment_name'], value: item['ailment_id']);
        }).toList();
      });
    } else {
      throw Exception('Failed to load ailments');
    }
  }
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
  Future<dynamic> updateOPD(BuildContext context) async {
    await Future.delayed(Duration(seconds: 0));
    var url = companyurl+'api2/opd_update.php';
    List selectedOptions = selectedAilments.map((item) => item.label).toList();
    http.Response response = await http.post(Uri.parse(url), body: {
      "ticket_no": ticket_no.text,
      // "ailments_new": dropdownvalue,
      "complaints":  jsonEncode(selectedOptions),
      // "diagnosis": diagnosis.text,
      // "examination_remarks": examination_remarks.text,
      // "remarks_rece": remarks_rece.text,
      // "appointment_date": appointment_date.text,
      // "lenght": len,
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
    _loadCompanyCode();
    fetchdiscasetype();
    fetchrecomntest();
    fetchhealthstatus();
    fetchApprovalStatus();
    fetchAilments();
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
                    SizedBox(height: 20,),
                    TextField(
                      style: TextStyle(fontWeight: FontWeight.bold),
                        controller: ticket_no, // Set text color to black
                        decoration: InputDecoration(
                         // labelText: 'Medical Record No',  labelStyle: TextStyle(color: Colors.black),// Set label color to black
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black), // Set border color to white
                          ), // Set background color to white
                        ),
                      ),
                    SizedBox(height: 20,),
                    TextFormField(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      controller: intime,
                      readOnly: true,
                      onTap: () {
                        // Open date picker when TextField is clicked
                        intimedate(context);
                      },// Set text color to black
                      decoration: InputDecoration(
                        //labelText: 'In Time', labelStyle: TextStyle(color: Colors.black), // Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Open date picker when calendar icon is clicked
                            intimedate(context);
                          },
                          icon: Icon(Icons.calendar_today),
                        ),// Set background color to white
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      controller: clearencetime,
                      readOnly: true,
                      onTap: () {
                        // Open date picker when TextField is clicked
                        clearencedate(context);
                      },// Set text color to black
                      decoration: InputDecoration(
                        //labelText: 'Clearance Time',  labelStyle: TextStyle(color: Colors.black),// Set label color to black
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
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black), // Set the border color
                        borderRadius: BorderRadius.circular(0), // Set the border radius
                      ),
                      child: SingleChildScrollView(
                        child: MultiSelectDialogField(
                          items: appointments.map((appointment) {
                            return MultiSelectItem<String>(
                              appointment['appointment_id']??'',
                              appointment['fallowupdetails']??'',
                            );
                          }).toList(),
                          initialValue: selectedAppointments,
                          searchable: true,
                          dialogHeight: 250,
                          buttonIcon: Icon(Icons.arrow_drop_down,size: 30,),
                          buttonText: Text("Followup to (if Applicable)",style: TextStyle(fontWeight: FontWeight.bold)),
                          checkColor: null, // Set the checkIcon property to null
                          onConfirm: (values) {
                            setState(() {
                              selectedAppointments = values;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text('Complaints',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black), // Set the border color
                        borderRadius: BorderRadius.circular(0), // Set the border radius
                      ),
                      child: SingleChildScrollView(
                        child: MultiSelectDialogField(
                          items: complaint.map((complaint) {
                            return MultiSelectItem<String>(
                              complaint['complaint'],
                              complaint['complaint'],
                            );
                          }).toList(),
                          initialValue: selectedcomplaint,
                          searchable: true,
                          dialogHeight: 250,
                          buttonIcon: Icon(Icons.arrow_drop_down,size: 30,),
                          buttonText: Text(selectedcomplaint.isEmpty ? 'Select complaints' : selectedcomplaint.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                          checkColor: null, // Set the checkIcon property to null
                          onConfirm: (values) {
                            setState(() {
                              selectedcomplaint = values; // Update selected complaints
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    MultiSelectDropDown(
                      controller: _controller,
                      onOptionSelected: (List<ValueItem> selectedOptions) {
                        setState(() {
                          selectedAilments = selectedOptions;
                        });
                      },
                      searchEnabled: true,// Enable search functionality
                      options: ailments,
                      selectionType: SelectionType.multi,
                      chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                      dropdownHeight: 300,
                      optionTextStyle: const TextStyle(fontSize: 16),
                      selectedOptionIcon: const Icon(Icons.check_circle),
                    ),
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
                          buttonText: Text("Diagnosis",style: TextStyle(fontWeight: FontWeight.bold),),
                          checkColor: null, // Set the checkIcon property to null
                          onConfirm: (values) {
                            setState(() {
                              selectedignosis = values;
                            });
                          },

                          validator: (values) {
                            if (values == null || values.isEmpty) {
                              return 'Please select at least one diagnosis';
                            }
                            return null;
                          },
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
                    SizedBox(height: 20,),
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
                    SizedBox(height: 20,),
                    TextField(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      controller: _textController1, // Set text color to black
                      decoration: InputDecoration(
                        labelText: 'Advices', // Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ), // Set background color to white
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                    SizedBox(height: 20,),
                    TextField(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      controller: _textController1, // Set text color to black
                      decoration: InputDecoration(
                        labelText: 'History of Drug Allergies', // Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ), // Set background color to white
                      ),
                    ),
                    SizedBox(height: 20,),
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
                          buttonText: Text('Select Some Option',style: TextStyle(fontWeight: FontWeight.bold),),
                          checkColor: null, // Set the checkIcon property to null
                          onConfirm: (values) {
                            setState(() {
                              selectedcomplaint = values;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
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
                          buttonText: Text('Select Some Option',style: TextStyle(fontWeight: FontWeight.bold),),
                          checkColor: null, // Set the checkIcon property to null
                          onConfirm: (values) {
                            setState(() {
                              selectedcomplaint = values;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      controller: _textController1, // Set text color to black
                      decoration: InputDecoration(
                        labelText: 'Doctor Comment', // Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ), // Set background color to white
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                    SizedBox(height: 20,),
                    TextField(
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                    SizedBox(height: 20,),
                    TextField(
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                SizedBox(height: 20,),
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
                    SizedBox(height: 20,),
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
                    SizedBox(height: 20,),
                    TextField(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      controller: _textController1, // Set text color to black
                      decoration: InputDecoration(
                        labelText: 'Referral', // Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      controller: _textController1, // Set text color to black
                      decoration: InputDecoration(
                        labelText: 'Referral Remark', // Set label color to black
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black), // Set border color to white
                        ), // Set background color to white
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                    SizedBox(height: 20,),
                    TextField(
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                    SizedBox(height: 20),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     if (_formKey.currentState!.validate()) {
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //           SnackBar(content: Text('Processing Data')));
                    //     }
                    //   },
                    //   child: Center(child: Text('Save')),
                    // ),
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
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
                          }
                          updateOPD(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlue,

                          // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
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