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
class medicalexmdate extends StatefulWidget {

  // final Doctor doctor;
  final Patient patient;
  final Appintment appintment;
  const medicalexmdate(
      {Key? key, required this.patient, required this.appintment})
  // ignore: unnecessary_null_comparison
      : super(key: key);


  @override
  State<medicalexmdate> createState() => _medicalexmdateState();
}

class _medicalexmdateState extends State<medicalexmdate> {

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
      String date,String day,
      )async{
    await Future.delayed(Duration(seconds: 0));
    String uri=companyurl+'api2/appintment_details.php';
    var res=await http.post(Uri.parse(uri),body: {
      'date':date,
      'time':dropdownValuetimesl.toString(),
      'day':day,
      // 'doctor_id':dropdownValuedoctorl.toString(),
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
  Future<dynamic> bookappintment2(
      String date
      )async{
    await Future.delayed(Duration(seconds: 0));
    String uri=companyurl+'api2/medical_exam_slot.php';
    var res=await http.post(Uri.parse(uri),body: {
      'slot_date':date,
      'emp_id':widget.patient.id,
      'ohc_type_id':widget.patient.ohc_type_id,
      'app_type':widget.appintment.velue,
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
    _currentDay = DateTime.now().add(Duration(days: 2));
    // getAlltime();
    // _firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Date & Time Selected')),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _tableCalendar(),
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
          SliverToBoxAdapter(
            child: _dateSelected ? Padding(
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
            ) : Container(),
          ),
          SliverToBoxAdapter(
            child: _timeSelected? Container(
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
      focusedDay: _focusDay.add(Duration(days: 2)),
      firstDay: DateTime.now().add(Duration(days: 2)),
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
          bookappintment2(getDate);
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
