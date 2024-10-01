
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';

import '../models/patient.dart';
import 'Tracking.dart';
import 'addfoodconsumed.dart';
import 'exercisescreen.dart';
import 'exersize.dart';

class homepage1 extends StatefulWidget {
  const homepage1({Key? key}) : super(key: key);

  @override
  State<homepage1> createState() => _homepage1State();
}

class _homepage1State extends State<homepage1> {
  DateTime selectedDate = DateTime.now();

  // Function to format the date
  String getFormattedDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  // Function to handle date change
  void _changeDate(int days) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: days));
    });
  }

  // Function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OHCTECH INDIA'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.track_changes),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TrackingPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade100, Colors.teal.shade400],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: PatientModel.patients?.length ?? 0,
                  itemBuilder: (context, index) {
                    var data = PatientModel.patients[index];
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.teal.shade100, Colors.teal.shade400],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [Colors.teal.shade100, Colors.teal.shade400],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.transparent,
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: AssetImage(
                                          'assets/images/user.png', // Replace with your image path
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                data.patient_name ?? 'NA',
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: Text(
                                              data.emp_code ?? 'NA',
                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: List.generate(8, (gridIndex) {
                                  List<String> metrics = [
                                    'Height',
                                    'Weight',
                                    'Waist',
                                    'Heart Rate',
                                    'BMI',
                                    'FBS',
                                    'RBS',
                                    'PPBS'
                                  ];
                                  List<String> values = [
                                    '170',
                                    '70',
                                    '80',
                                    '72',
                                    '24',
                                    '90',
                                    '110',
                                    '140'
                                  ];
                                  List<IconData> icons = [
                                    Icons.height,
                                    Icons.monitor_weight,
                                    Icons.horizontal_split,
                                    Icons.favorite,
                                    Icons.calculate,
                                    Icons.bloodtype,
                                    Icons.bloodtype,
                                    Icons.bloodtype,
                                  ];

                                  return Chip(
                                    avatar: Icon(icons[gridIndex], color: Colors.white),
                                    backgroundColor: Colors.teal,
                                    label: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          metrics[gridIndex],
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                        Text(
                                          values[gridIndex],
                                          style: TextStyle(color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios, color: Colors.red, size: 30),
                                    onPressed: () => _changeDate(-1),
                                  ),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () => _selectDate(context),
                                        child: Text(
                                          getFormattedDate(selectedDate),
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.calendar_today, color: Colors.white),
                                        onPressed: () => _selectDate(context),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios, color: Colors.red, size: 30),
                                    onPressed: () => _changeDate(1),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: List.generate(4, (indicatorIndex) {
                                  List<String> titles = ['Indicator', 'Actual', 'Target', 'Percent'];
                                  List<String> values = ['weight', '80', '100', '80%'];
                                  List<String> values1 = ['protien', '80', '100', '80%'];
                                  List<String> values4 = ['calories', '80', '100', '80%'];
                                  List<String> values2 = ['bp', '80', '100', '80%'];
                                  List<String> values3 = ['sugar', '80', '100', '80%'];
                                  return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 5,
                                          color: Colors.blue,
                                          margin: const EdgeInsets.only(bottom: 5.0),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                                          child: Text(
                                            titles[indicatorIndex % 4],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                                          child: Text(
                                            values[indicatorIndex % 4],
                                            style: TextStyle(color: Colors.white70),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                                          child: Text(
                                            values2[indicatorIndex % 4],
                                            style: TextStyle(color: Colors.white70),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                                          child: Text(
                                            values4[indicatorIndex % 4],
                                            style: TextStyle(color: Colors.white70),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                                          child: Text(
                                            values3[indicatorIndex % 4],
                                            style: TextStyle(color: Colors.white70),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                                          child: Text(
                                            values1[indicatorIndex % 4],
                                            style: TextStyle(color: Colors.white70),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.teal,
        children: [
          SpeedDialChild(
            child: Icon(Icons.fastfood),
            label: 'Add Food Consumption',
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Addfood(),
                ),
              );
              // Handle Add Food Consumption action
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.fitness_center),
            label: 'Add Exercise Done',
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddExercise(),
                ),
              );
              // Handle Add Food Consumption action
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.monitor_weight),
            label: 'Add/Weight Measurement',
            onTap: () {
              // Handle Add/Weight Measurement action
            },
          ),
        ],
      ),
    );
  }
}


