import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/patient.dart';

class AddMadicine extends StatefulWidget {
   final Patient patient;

  const AddMadicine({Key? key, required this.patient})
      : super(key: key);

  @override
  State<AddMadicine> createState() => _AddMadicineState();
}
class _AddMadicineState extends State<AddMadicine> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController patientname=TextEditingController();
  TextEditingController ticketno=TextEditingController();
  TextEditingController Dosage = TextEditingController();
  TextEditingController dose_qty = TextEditingController();
  TextEditingController issuedqty = TextEditingController();
  TextEditingController fordays = TextEditingController();


  String companyCode = "";
  String companyurl = "";

  void _loadCompanyCode() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      companyCode = prefs.getString('companyCode') ?? "";
      companyurl = prefs.getString('companyurl') ?? "";
    });
  }

  var dropdownvaluebodysyptam;
  var dropdownValueMedicine;
  var dropdownValueFrequency;
  var dropdownValuetiming;
  var dropdownValueAdminroute;

 @override
  void initState() {
    super.initState();
    _loadCompanyCode();
    getAllCategory();
    getAllMedicines();
    getAllFrequency();
    getAllTimings();
    getAllAdminroute();
    Patient dm;
    dm = widget.patient;
    var visitDate;
    var injuryTime;
    patientname.text = dm.patient_name!;
    ticketno.text = dm.ticket_no!;

  }
  List categoryItemlist = [];

  Future getAllCategory() async {
    await Future.delayed(Duration(seconds: 1));
    var baseUrl = companyurl+'api2/bodysystemapi.php';

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemlist = jsonData;
      });
    }
  }

  List medicinelist = [];

  Future getAllMedicines() async {
    await Future.delayed(Duration(seconds: 1));
    var baseUrl =  companyurl+'api2/medicines_api.php';

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        medicinelist = jsonData;
      });
    }
  }

  List frequencylist = [];

  Future getAllFrequency() async {
    await Future.delayed(Duration(seconds: 1));
    var baseUrl = companyurl+'api2/frequency_api.php';

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        frequencylist = jsonData;
      });
    }
  }

  List timingslist = [];

  Future getAllTimings() async {
    await Future.delayed(Duration(seconds: 1));
    var baseUrl =  companyurl+'api2/timings_api.php';

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        timingslist = jsonData;
      });
    }
  }

  List adminRoutelist = [];

  Future getAllAdminroute() async {
    await Future.delayed(Duration(seconds: 1));
    var baseUrl = companyurl+'api2/adminroute_api.php';

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        adminRoutelist = jsonData;
      });
    }
  }


Future<void> insertrecord() async{
      if(patientname.text !="" && ticketno.text!="" && dose_qty.text!="" && Dosage.text!=""){
          String uri=companyurl+'api2/save_treackmentmedi.php';
          var res=await http.post(Uri.parse(uri),body: {
             "appointment_id":ticketno.text,
             "item_id":dropdownValueMedicine.toString(),
             "item_qty":dose_qty.text,
             "dosage":Dosage.text,
             "issued_qty":issuedqty.text,
             "for_days":fordays.text,
             "frequency_id":dropdownValueFrequency.toString(),
             "timing_id":dropdownValuetiming.toString(),
             "dosage_category_id":dropdownValueAdminroute.toString(),
          });
          var response=jsonDecode(res.body);
          print(response);
          if(response["sucess"]=="true"){
            print("record insert");
          }else{
            print('some issue');
          }
      }else{
        print('please file all field');
      }
      }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text('ADD MEDICINE')),
    body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          child: Column(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:<Widget> [
                    SizedBox(height: 10,),
                    Container(
                      height:50,
                      margin: EdgeInsets.all(10),
                      child:
                      TextFormField(
                        controller: patientname,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            label: Text('PATIENT NAME',style: TextStyle(fontWeight:FontWeight.bold ),),),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          patientname = patientname;
                        },
                      ),
                    ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: ticketno,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                        label: Text('Appintment Id',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          ),),),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Ticket no';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        ticketno = ticketno;
                      },
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: DropdownButton(
                            isExpanded: true,
                            hint: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("Select Medicine",style: TextStyle(fontWeight:FontWeight.bold ),),
                            ),
                            value: dropdownValueMedicine,
                            items: medicinelist.map((e){
                              return DropdownMenuItem(
                                  value:e ['item_name'].toString(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(e['item_name'].toString()),
                                  ));
                            }).toList(),
                            onChanged:(value){
                              setState(() {
                                dropdownValueMedicine=value;
                              });
                            }),
                        color: Color.fromARGB(255, 148, 204, 242),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: DropdownButton(
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text("Select Frequency",style: TextStyle(fontWeight:FontWeight.bold )),
                              ),
                              value: dropdownValueFrequency,
                              items: frequencylist.map((e){
                                return DropdownMenuItem(
                                    value:e ['medicine_frequency'].toString(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(e['medicine_frequency'].toString()),
                                    ));
                              }).toList(),
                              onChanged:(value){
                                setState(() {
                                  dropdownValueFrequency=value;
                                });
                              },
                          ),
                          color: Color.fromARGB(255, 148, 204, 242),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: DropdownButton(
                            isExpanded: true,
                            hint: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("Select timing",style: TextStyle(fontWeight:FontWeight.bold )),
                            ),
                            value: dropdownValuetiming,
                            items: timingslist.map((e){
                              return DropdownMenuItem(
                                  value:e ['medicine_timing'].toString(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(e['medicine_timing'].toString()),
                                  ));
                            }).toList(),
                            onChanged:(value){
                              setState(() {
                                dropdownValuetiming=value;
                              });
                            }),
                        color: Color.fromARGB(255, 148, 204, 242),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: DropdownButton(
                            isExpanded: true,
                            hint: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("Select Adminrout",style: TextStyle(fontWeight:FontWeight.bold )),
                            ),
                            value: dropdownValueAdminroute,
                            items: adminRoutelist.map((e){
                              return DropdownMenuItem(
                                  value:e ['dosage_category'].toString(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(e['dosage_category'].toString()),
                                  ));
                            }).toList(),
                            onChanged:(value){
                              setState(() {
                                dropdownValueAdminroute=value;
                              });
                            }),
                        color: Color.fromARGB(255, 148, 204, 242),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: dose_qty,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          label: Text('Doseqty',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),),
                        onSaved: (value) {
                          dose_qty = dose_qty;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your DoseQty';
                          }
                          return null;
                        },
                      ),

                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: Dosage,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          label: Text('Dosage',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Dosage';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          Dosage = Dosage;
                        },
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: issuedqty,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          label: Text('Issuedqty',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your IssueQty';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          issuedqty = issuedqty;
                        },
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: fordays,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          label: Text('ForDays',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Fordays';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          fordays = fordays;
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(onPressed: () {
                        {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, save the form and perform desired action
                            _formKey.currentState?.save();
                            insertrecord();
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('successful'),
                                content: Text('Medicine Add Successfully'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                        content: const Text('MEDICINE ADD SUCESSFULLY'),
                        duration: Duration(seconds: 6), // Optional: Duration for how long the Snackbar should be displayed
                        action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {
                        // Perform an action when the Snackbar's action button is pressed
                        print('Snackbar action button clicked');
                        },
                        ),
                        ),);
                            setState(() {
                              dose_qty.clear();
                              issuedqty.clear();
                              fordays.clear();
                              Dosage.clear();
                              dropdownValueMedicine = null;
                              dropdownValueAdminroute=null;
                              dropdownValueFrequency=null;
                              dropdownValuetiming=null;
                            });
                          };
                      };
                      },child: Text('ADD MEDICINE'),),
                    ),
            ],
          ),
    ),
          ]
    ),
        ),
      )
    ),
    );
  }
}
