import 'package:flutter/material.dart';
import 'page2.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Occupational Health \n Software & Services',
                    style: TextStyle(fontSize: 25, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'An Occupational Health Centre is the hub for all '
                      'the occupational health services offered in the  '
                      'protect and promote the health of all employees. Curative, '
                      'Preventive, Promotive, and Rehabilitative health care programs '
                      'and activities are planned and executed from here. It is mandatory '
                      'to set up an Occupational Health Centre in all the factories under '
                      'the Indian Factories Act.',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  'STATEMENT',
                  style: TextStyle(fontSize: 25,color: Colors.black45),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  'Vision/Mission of the occupational health services should be derived from the EOHS policy of the '
                      'organization and in line with the intent of the Factories Rules/Act. Such derived OHC mission can '
                      'be as follows: When employees join the organization, they come in with a certain baseline level of physical '
                      '& mental fitness. Any depreciation in this can affect their quality of life and productivity. The mission of the '
                      'occupational health services is to protect the employee against deterioration in health while trying to further '
                      'improve their health and fitness.',
                  style: TextStyle(fontSize: 15,color: Colors.cyan),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  'Why did we start this',
                  style: TextStyle(fontSize: 20,color: Colors.black),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  'We ensure that all activities we conduct would either directly contribute to improve employee health or go and '
                      'try to ease the process of practical application of the findings as well as also offer practical solutions to reduce the '
                      'effects of abnormal findings. We are also capable of offering practical on-site solutions. For this to happen, we adopt the '
                      'following strategies: Giving exceptional services: We believe our responsibility is more than merely conducting an activity '
                      'and giving generic reports. We seek to assist you to take action based on those reports. We would do this by providing analysis, '
                      'suggesting practical solutions, or even offering our own solution. Providing all occupational health services under one roof: '
                      'Integrating the various activities brings a very clear picture on what the situation is and what actions need to be taken. It is '
                      'very crucial to connect all the points and arrive at a conclusion. It will allow you to make decisions much easier.',
                  style: TextStyle(fontSize: 15,color: Colors.grey),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  'More content goes here...',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Page2()),
                    );
                  },
                  child: Text('More',textAlign: TextAlign.right),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
