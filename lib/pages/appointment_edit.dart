
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
import '../models/appointmentview.dart';
import '../models/patient.dart';
import 'button.dart';
import 'date_time_converted.dart';
class appointmentedit extends StatefulWidget {

  // final Doctor doctor;
  final Patient patient;
  final appointmentview appintment;
  const appointmentedit(
      {Key? key, required this.patient, required this.appintment})
  // ignore: unnecessary_null_comparison
      : super(key: key);


  @override
  State<appointmentedit> createState() => _appointmenteditState();
}

class _appointmenteditState extends State<appointmentedit> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController checkupname=TextEditingController();
  TextEditingController date =TextEditingController();
  TextEditingController time=TextEditingController();

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
  Future<dynamic> bookappintment(
      String date,
      )async{
    await Future.delayed(Duration(seconds: 0));
    String uri=companyurl+'api2/appintment_details.php';
    var res=await http.post(Uri.parse(uri),body: {
      'date':date,
      'time':dropdownValuetimesl.toString(),
      'id':widget.appintment.id,
      'doctor_id':widget.appintment.doctor_id,
      'emp_id':widget.patient.id,
      'ohc_type_id':widget.patient.ohc_type_id,
    });
    var response=jsonDecode(res.body);
    print(response);
    if(response == "true"){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Successful'),
          content: Text("Appointment Update Successfully"),
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
  Future<dynamic> bookappintment2(
      String date
      )async{
    await Future.delayed(Duration(seconds: 0));
    String uri=companyurl+'api2/medical_exam_slot.php';
    var res=await http.post(Uri.parse(uri),body: {
      'slot_date':date,
      'emp_id':widget.patient.id,
      'ohc_type_id':widget.patient.ohc_type_id,
    });
    var jsonData = json.decode(res.body);
    print(jsonData);
    setState(() {
      timelist = jsonData;
    });
  }
  //get token for insert booking date and time into database

  var dropdownValuedoctorl;
  var dropdownValuetimesl;
  @override
  void initState() {
    super.initState();
    _loadCompanyCode();
    _format = CalendarFormat.month;
    _focusDay = DateTime.now();
    _currentDay = DateTime.now();
    // getAlltime();
    // _firstLoad();
    appointmentview dm;
    dm = widget.appintment;
    checkupname.text = dm.app_type!;
    date.text = dm.date!;
    time.text = dm.time!;
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Appointment Edit')),
      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 50,
                margin: EdgeInsets.all(0),
                child: TextFormField(
                  controller: checkupname,
                  decoration: const InputDecoration(
                    label: Text('Checkup',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),),
                  onSaved: (value) {
                    checkupname = checkupname;
                  },
                ),
              ),
              SizedBox(height: 20,),
              TableCalendar(
                focusedDay: _focusDay,
                firstDay: DateTime.now(),
                // focusedDay: _focusDay.add(Duration(days: 2)),
                // firstDay: DateTime.now().add(Duration(days: 2)),
                lastDay: DateTime(2050),
                calendarFormat:_format,
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
                onDaySelected: ( selectedDate,  focusedDay) {
                  // Update the selected date when a day is selected in the calendar
                  setState(() {
                    _focusDay = focusedDay;
                    _currentDay = selectedDate;
                    date.text = _formatDate(selectedDate);
                    _dateSelected = true;
                    final getDate=DateConverted.getDate(_currentDay);
                    bookappintment2(getDate);
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: date,
                decoration: InputDecoration(
                  labelText: 'Select Date',
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: _dateSelected? DropdownButton(
                  isExpanded: true,
                  hint: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(widget.appintment.time.toString(),style: TextStyle(fontWeight:FontWeight.bold ))),
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
                ): Container(),
                color: Color.fromARGB(255, 232, 245, 235),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child:_timeSelected? Button(
                  width: double.infinity,
                  title: 'Make Appointment',
                  onPressed: () async {
                    final getDate=DateConverted.getDate(_currentDay);
                    bookappintment(getDate);
                  },
                  disable: _timeSelected && _dateSelected ? false : true,
                  // _timeSelected &&
                ): Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
 //  Future<void> _showDropdown(BuildContext context) async {
 // showDialog(
 //      context: context,
 //      builder: (BuildContext context) {
 //        return AlertDialog(
 //          title: Text('Select an option'),
 //          content: DropdownButton<String>(
 //            value:dropdownValuetimesl,
 //            items: timelist.map((value) {
 //              return DropdownMenuItem<String>(
 //                  value:value ['slot_id']?? ''.toString(),
 //                  child: Center(child: Text(value['slot']?? ''.toString())));
 //            }).toList(),
 //            onChanged: (value) {
 //              setState(() {
 //                dropdownValuetimesl = value;
 //                _timeSelected = true;
 //              });
 //              Navigator.of(context).pop(value);
 //            },
 //          ),
 //        );
 //      },
 //    );
 //    // Update the selected value in the TextField);
 //    }
  String _formatDate(DateTime date) {
    return '${date.day}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}';
  }
}
