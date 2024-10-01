
import 'dart:convert';

class appointmentview {
  final String? type;
  final int? srno;
  final String? doctor_id;
  final String? date;
  final String? time;
  final String? day;
  final String? id;
  final String? app_type;
  final String? status;

  appointmentview({
    required this.type,
    required this.doctor_id,
    required this.srno,
    required this.date,
    required this.time,
    required this.day,
    required this.id,
    required this.app_type,
    required this.status,
  });
  factory appointmentview.fromRawJson(String str) => appointmentview.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory appointmentview.fromJson(Map<String, dynamic> json) => appointmentview(
    srno: json["srno"],
    doctor_id:json["doctor_id"],
    date:json['date'],
    type:json['type'],
    time:json['time'],
    id: json["id"],
    app_type:json['app_type'],
    status: json["status"],
    day: json["day"],
  );

  Map<String, dynamic> toJson() => {
    "srno": srno,
    "doctor_id":doctor_id,
    "date":date,
    "time":time,
    "day":day,
    "type":type,
    "id": id,
    "status": status,
    "app_type": app_type,
  };
}
