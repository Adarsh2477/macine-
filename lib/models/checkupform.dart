
import 'dart:convert';

import 'Appointment.dart';
import 'dacuu.dart';

class Checkupform {
  final int? srno;
  final String? checkup_id;
  final String? checkup_type_id;
  final String? checkup_date;
  final String? appointment_id;
  final String? doctor_last_attended;
  final List<docu>? Docu;

  Checkupform({
    required this.checkup_id,
    required this.srno,
    required this.checkup_type_id,
    required this.checkup_date,
    required this.appointment_id,
    required this.doctor_last_attended,
    required this.Docu,
  });

  factory Checkupform.fromRawJson(String str) => Checkupform.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Checkupform.fromJson(Map<String, dynamic> json) => Checkupform(
    Docu:json['docu'] == null ? null : (json['docu'] as List).map<docu>((data)=> docu.fromJson(data  as Map<String,dynamic>)).toList(),
    srno: json["srno"],
    checkup_id:json['checkup_id'],
    checkup_type_id: json["checkup_type_id"],
    checkup_date: json["checkup_date"],
    appointment_id: json["appointment_id"],
    doctor_last_attended: json["doctor_last_attended"],
  );

  Map<String, dynamic> toJson() => {
    'Docu': Docu?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
    "srno": srno,
    "checkup_type_id": checkup_type_id,
    "checkup_id":checkup_id,
    "checkup_date": checkup_date,
    "appointment_id": appointment_id,
    "doctor_last_attended": doctor_last_attended,
  };
}
