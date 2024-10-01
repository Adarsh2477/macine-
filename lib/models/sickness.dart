
import 'dart:convert';

class Sickness {
  final int? srno;
  final String? sickness_id;
  final String? approval_date;
  final String? fitness_status;
  final String? date_absent;
  final String? sickness_date;
  final String? ailment_name;
  final String? doctor_last_attended;

  Sickness({
    required this.sickness_id,
    required this.srno,
    required this.fitness_status,
    required this.approval_date,
    required this.date_absent,
    required this.sickness_date,
    required this.ailment_name,
    required this.doctor_last_attended,
  });
  factory Sickness.fromRawJson(String str) => Sickness.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sickness.fromJson(Map<String, dynamic> json) => Sickness(
    srno: json["srno"],
    sickness_id:json["sickness_id"],
    approval_date:json['approval_date'],
    date_absent:json['date_absent'],
    sickness_date: json["sickness_date"],
    fitness_status:json['fitness_status'],
    ailment_name: json["ailment_name"],
    doctor_last_attended: json["doctor_last_attended"],
  );

  Map<String, dynamic> toJson() => {
    "srno": srno,
    "approval_date":approval_date,
    "sickness_id":sickness_id,
    "fitness_status":fitness_status,
    "date_absent":date_absent,
    "sickness_date": sickness_date,
    "ailment_name": ailment_name,
    "doctor_last_attended": doctor_last_attended,
  };
}
