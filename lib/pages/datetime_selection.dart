// // ignore_for_file: unused_label
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:ohctech/models/Doctor.dart';
// import 'package:ohctech/pages/appintmenr_sucess.dart';
// import 'package:ohctech/pages/patient_profile.dart';
// import 'package:ohctech/utils/config.dart';
// import 'package:http/http.dart'as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// import '../models/patient.dart';
// import 'button.dart';
// import 'date_time_converted.dart';
// import 'doctor_selection.dart';
// class BookingPage extends StatefulWidget {
//
//   final Doctor doctor;
//   final Patient patient;
//   const BookingPage(
//       {Key key, @required this.doctor, @required this.patient})
//   // ignore: unnecessary_null_comparison
//       : super(key: key);
//
//
//   @override
//   State<BookingPage> createState() => _BookingPageState();
// }
//
// class _BookingPageState extends State<BookingPage> {
//
//   String companyCode = "";
//   String companyurl = "";
//
//   Future<void> _loadCompanyCode() async {
//     final prefs = await SharedPreferences.getInstance();
//     companyCode = prefs.getString('companyCode') ?? "";
//     companyurl = prefs.getString('companyurl') ?? "";
//   }
//   TextEditingController doctorid=TextEditingController();
//   String availabilityMessage = '';
//   TextEditingController userid=TextEditingController();
//
//   Doctor doctor;
//   List _posts = [];
//   void _firstLoad() async {
//     await Future.delayed(Duration(seconds: 1));
//     try {
//       final res =
//       await http.get(Uri.parse(companyurl+'appointment_dr_api.php'));
//       setState(() {
//         _posts = json.decode(res.body);
//         print(_posts);
//       });
//     } catch (err) {
//     }
//     DoctorModel.Doctors = List.from(_posts)
//         .map<Doctor>((doctor) => Doctor.fromJson(doctor))
//         .toList();
//   }
//
//   Future<dynamic> bookappintment(
//       String date,String day,String time
//       )async{
//     await Future.delayed(Duration(seconds: 1));
//     String uri=companyurl+'appintment_details.php';
//     var res=await http.post(Uri.parse(uri),body: {
//       'date':date,
//       'time':time,
//       'day':day,
//       'doctor_id':widget.doctor.id,
//       'emp_id':widget.patient.id,
//     });
//     var response=jsonDecode(res.body);
//     print(response);
//     if(response["available"]== "true"){
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('successful'),
//           content: Text("appointment booked successfully"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => patientProfile(),
//                   ),
//                 );
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }else{
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Fail'),
//           content: Text("The selected date and time already exist in the database."),
//           actions: [
//             TextButton(
//               onPressed: ()=>Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   CalendarFormat _format = CalendarFormat.month;
//   DateTime _focusDay = DateTime.now();
//   DateTime _currentDay = DateTime.now();
//   int _currentIndex;
//   bool _isWeekend = false;
//   bool _dateSelected = false;
//   bool _timeSelected = false;
//   String token; //get token for insert booking date and time into database
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     _loadCompanyCode();
//     _firstLoad();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Config().init(context);
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text('Date & time selected')),
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverToBoxAdapter(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 _tableCalendar(),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
//                   child: Center(
//                     child: Text(
//                       'Select Consultation Time',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           _isWeekend
//               ? SliverToBoxAdapter(
//             child: Container(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 10, vertical: 30),
//               alignment: Alignment.center,
//               child: const Text(
//                 'Weekend is not available, please select another date',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//           )
//               : SliverGrid(
//             delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                 return InkWell(
//                   splashColor: Colors.transparent,
//                   onTap: () {
//                     setState(() {
//                       _currentIndex = index;
//                       _timeSelected = true;
//                     });
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: _currentIndex == index
//                             ? Colors.white
//                             : Colors.black,
//                       ),
//                       borderRadius: BorderRadius.circular(15),
//                       color: _currentIndex == index
//                           ? Config.primaryColor
//                           : null,
//                     ),
//                     alignment: Alignment.center,
//                     child:
//                     Text(
//                       '12',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color:
//                         _currentIndex == index ? Colors.white : null,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               childCount: 8,
//             ),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4, childAspectRatio: 1.5),
//           ),
//           SliverToBoxAdapter(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               child: Button(
//                 width: double.infinity,
//                 title: 'Make Appointment',
//                 onPressed: () async {
//                   final getDate=DateConverted.getDate(_currentDay);
//                   final geDay=DateConverted.getDay(_currentDay.weekday);
//                   final getTime=DateConverted.getTime(_currentIndex);
//                   bookappintment(getDate, geDay, getTime);
//                 },
//                 disable: _timeSelected && _dateSelected ? false : true,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   //table calendar
//   Widget _tableCalendar() {
//     return TableCalendar(
//       focusedDay: _focusDay,
//       firstDay: DateTime.now(),
//       lastDay: DateTime(2026, 12, 31),
//       calendarFormat: _format,
//       currentDay: _currentDay,
//       rowHeight: 48,
//       calendarStyle: const CalendarStyle(
//         todayDecoration:
//         BoxDecoration(color: Config.primaryColor, shape: BoxShape.circle),
//       ),
//       availableCalendarFormats: const {
//         CalendarFormat.month: 'Month',
//       },
//       onFormatChanged: (format) {
//         setState(() {
//           _format = format;
//         });
//       },
//       onDaySelected: ((selectedDay, focusedDay) {
//         setState(() {
//           _currentDay = selectedDay;
//           _focusDay = focusedDay;
//           _dateSelected = true;
//
//           //check if weekend is selected
//           if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
//             _isWeekend = true;
//             _timeSelected = false;
//             _currentIndex = null;
//           } else {
//             _isWeekend = false;
//           }
//         });
//       }),
//     );
//   }
// }


// ignore_for_file: unused_label
import 'package:flutter/material.dart';
import 'dart:convert';
// import 'package:ohctech/models/Doctor.dart';
import 'package:ohctech/pages/appintmenr_sucess.dart';
import 'package:ohctech/pages/patient_profile.dart';
import 'package:ohctech/utils/config.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/Appintment.dart';
import '../models/patient.dart';
import 'button.dart';
import 'date_time_converted.dart';
class BookingPage extends StatefulWidget {

  // final Doctor doctor;
  final Patient patient;
  final Appintment appintment;
  const BookingPage(
      {Key? key, required this.patient, required this.appintment})
  // ignore: unnecessary_null_comparison
      : super(key: key);


  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {

  String companyCode = "";
  String companyurl = "";
  List timeList = [];
  late CalendarFormat _format;
  late DateTime _focusDay;
  late DateTime _currentDay;
  late String dropdownValueTimeslot;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;

  Future<void> _loadCompanyCode() async {
    final prefs = await SharedPreferences.getInstance();
    companyCode = prefs.getString('companyCode') ?? "";
    companyurl = prefs.getString('companyurl') ?? "";
  }
  TextEditingController doctorid=TextEditingController();
  String availabilityMessage = '';
  TextEditingController userid=TextEditingController();


  List timelist = [];

  //
  // Future getAlltime() async {
  //   await Future.delayed(Duration(seconds: 1));
  //   var baseUrl =  companyurl+'slots_api.php';
  //
  //   http.Response response = await http.get(Uri.parse(baseUrl));
  //
  //   if (response.statusCode == 200) {
  //     var jsonData = json.decode(response.body);
  //     setState(() {
  //       timelist = jsonData;
  //     });
  //   }
  // }

  Future<dynamic> bookappintment(
      String date,String day,
      )async{
    await Future.delayed(Duration(seconds: 0));
    String uri=companyurl+'api2/appintment_details.php';
    var res=await http.post(Uri.parse(uri),body: {
      'date':date,
      'time':dropdownValuetimesl.toString(),
      'day':day,
      'doctor_id':dropdownValuedoctorl.toString(),
      'emp_id':widget.patient.id,
      'ohc_type_id':widget.patient.ohc_type_id,
      'type':widget.appintment.velue,
    });
    var response=jsonDecode(res.body);
    print(response);
    if(response == "true"){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Successful'),
          content: Text("Appointment Booked Successfully"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => patientProfile(),
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }else{
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(" Please Select Another Time ."),
          actions: [
            TextButton(
              onPressed: ()=>Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  List doctorlist = [];
  Future<dynamic> bookappintment1(
      String date
      )async{
    await Future.delayed(Duration(seconds: 0));
    String uri=companyurl+'api2/select_appointment_do.php';
    var res=await http.post(Uri.parse(uri),body: {
      'slot_date':date,
      // 'emp_id':widget.doctor.id,
      'ohc_type_id':widget.patient.ohc_type_id,
      'app_type':widget.appintment.velue,
    });
        var jsonData = json.decode(res.body);
        print(jsonData);
        setState(() {
          doctorlist = jsonData;
        });
  }
  Future<dynamic> bookappintment2(
      String date
      )async{
    await Future.delayed(Duration(seconds: 0));
    String uri=companyurl+'api2/select_appointment_sl.php';
    var res=await http.post(Uri.parse(uri),body: {
      'slot_date':date,
      'emp_id':dropdownValuedoctorl.toString(),
      'ohc_type_id':widget.patient.ohc_type_id,
      'app_type':widget.appintment.velue,
    });
    var jsonData = json.decode(res.body);
    setState(() {
      timelist = jsonData;
    });
  }
  bool _doctorSelected = false;
  late String token; //get token for insert booking date and time into database

  var dropdownValuedoctorl;
  var dropdownValuetimesl;
  @override
  void initState() {
    super.initState();
    _loadCompanyCode();
    _format = CalendarFormat.month;
    _focusDay = DateTime.now();
    _currentDay = DateTime.now();
    //_currentDay = DateTime.now().add(Duration(days: 2));
    // getAlltime();
    // _firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Date & time selected')),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _tableCalendar(),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                //   child: Button(
                //     width: double.infinity,
                //     title: 'GET SLOT',
                //     onPressed: () async {
                //       final getDate=DateConverted.getDate(_currentDay);
                //       bookappintment1(getDate);
                //     },
                //     disable: _dateSelected ? false : true,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     width: double.infinity,
                //     child: ElevatedButton(
                //       child: Text('GET SLOT'),
                //       style: ElevatedButton.styleFrom(
                //         primary: Colors.grey,
                //         textStyle: const TextStyle(
                //             color: Colors.white,
                //             fontSize: 10,
                //             fontStyle: FontStyle.normal),
                //       ),
                //       onPressed: () async {
                //         final getDate=DateConverted.getDate(_currentDay);
                //         bookappintment1(getDate);
                //       },
                //     ),
                //   ),
                // ),
                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                //   child: Center(
                //     child: Text(
                //       'Select Consultation Time',
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 20,
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          _isWeekend
              ? SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 30),
              alignment: Alignment.center,
              child: const Text(
                'Weekend is not available, please select another date',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ):
          // SliverGrid(
          //   delegate: SliverChildBuilderDelegate(
          //         (context, index) {
          //       return InkWell(
          //         splashColor: Colors.transparent,
          //         onTap: () {
          //           setState(() {
          //             _currentIndex = index;
          //           });
          //         },
          //         child: Container(
          //           margin: const EdgeInsets.all(5),
          //           decoration: BoxDecoration(
          //             border: Border.all(
          //               color: _currentIndex == index
          //                   ? Colors.white
          //                   : Colors.black,
          //             ),
          //             borderRadius: BorderRadius.circular(15),
          //             color: _currentIndex == index
          //                 ? Config.primaryColor
          //                 : null,
          //           ),
          //           alignment: Alignment.center,
          //           child: Text(
          //             timelist[index]['slot'].toString(),
          //             style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               color: _currentIndex == index
          //                   ? Colors.white
          //                   : null,
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //     childCount: timelist.length,
          //   ),
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 4,
          //     childAspectRatio: 1.5,
          //   ),
          // ),
          SliverToBoxAdapter(
            child: _dateSelected? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: DropdownButton(
                  isExpanded: true,
                  hint: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text("Select Doctor",style: TextStyle(fontWeight:FontWeight.bold ))),
                  ),
                  value: dropdownValuedoctorl,
                  items: doctorlist.map((e){
                    return DropdownMenuItem(
                        value:e ['emp_id']?? ''.toString(),
                        child: Center(child: Text(e['patient_name'] ?? ''.toString())));
                  }).toList(),
                  onChanged:(value){
                    setState(() {
                      dropdownValuedoctorl=value;
                      _doctorSelected = true;
                      final getDate=DateConverted.getDate(_currentDay);
                      bookappintment2(getDate);
                    });
                  },
                ),
                color: Color.fromARGB(255, 232, 245, 235),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ): Container(),
          ),
          SliverToBoxAdapter(
            child:_doctorSelected? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: DropdownButton(
                  isExpanded: true,
                  hint: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text("Select Timeslot",style: TextStyle(fontWeight:FontWeight.bold ))),
                  ),
                  value: dropdownValuetimesl,
                  items: timelist.map((e){
                    return DropdownMenuItem(
                        value:e ['slot_id']?? ''.toString(),
                        child: Center(child: Text(e['slot']?? ''.toString())));
                  }).toList(),
                  onChanged:(value){
                    setState(() {
                      dropdownValuetimesl=value;
                      _timeSelected = true;
                    });
                  },
                ),
                color: Color.fromARGB(255, 232, 245, 235),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ): Container(),
          ),
          SliverToBoxAdapter(
            child:_timeSelected? Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Button(
                width: double.infinity,
                title: 'Make Appointment',
                onPressed: () async {
                  final getDate=DateConverted.getDate(_currentDay);
                  final geDay=DateConverted.getDay(_currentDay.weekday);
                  // final getTime=DateConverted.getTime(_currentIndex);
                  bookappintment(getDate, geDay);
                },
                disable: _timeSelected && _dateSelected ? false : true,
                  // _timeSelected &&
              ),
            ): Container(),
          ),
        ],
      ),
    );
  }

  //table calendar
  Widget _tableCalendar() {
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      // focusedDay: _focusDay.add(Duration(days: 2)),
      // firstDay: DateTime.now().add(Duration(days: 2)),
      lastDay: DateTime(2026, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration:
        BoxDecoration(color: Config.primaryColor, shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: ((selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;
          final getDate=DateConverted.getDate(_currentDay);
          bookappintment1(getDate);
          //check if weekend is selected
          // if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
          //   _isWeekend = true;
          //   _timeSelected = false;
          //   // _currentIndex = null as int;
          // } else {
          //   _isWeekend = false;
          // }
        });
      }),
    );
  }
}
