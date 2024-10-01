import 'package:flutter/material.dart';
import 'demologin.dart';
import 'page3.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                'Patient→ OHC',style: TextStyle(fontSize: 20,color: Colors.black),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'OHC should have an exclusive, easily remembered phone number as an emergency contact number. '
                    'The emergency contact number should be prominently displayed in all sections of the factory including '
                    'shop floors. '
                    '• An emergency contact number card should be given to all the visitors and new employees. '
                    '• OHC staff should attend the call from the emergency phone within three rings. '
                    '• The emergency phone should not be used for regular OHC activities, and communication regarding '
                    'this should be done periodically to everyone in the plant.',style: TextStyle(fontSize: 15,color: Colors.grey),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'OHC Staff',style: TextStyle(fontSize: 20,color: Colors.blue),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'All OHC staff should be available during mass emergencies. The OHC staff on duty should immediately '
                    'call on-call OHC staff during such emergencies and he/she, in turn, should also inform off-duty staff '
                    'to be available at OHC. So, all the OHC staff should be provided with a mobile phone with a working '
                    'SIM, and OHC staff should always keep their mobile with them always switched-on and battery '
                    'charged to more than 75%.',style: TextStyle(fontSize: 15,color: Colors.cyan),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'In case the patient has to be transferred to a referral hospital, the OHC should consult the referral '
                    'hospital to know the availability of the specialist services, availability of emergency beds. The OHC '
                    'should also ask the hospital about patient conditions and request them to be ready and provide '
                    'treatment on a high priority basis. In case any major procedures are required, the necessary approvals '
                    'to the hospital should be given after consulting the personnel administration department head. Overall, '
                    'the OHC should ensure the quality treatment of the employees without any hiccups.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'More content goes here...',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              // Add more content here to make the page scrollable
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => demoligin()),
                  );
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
