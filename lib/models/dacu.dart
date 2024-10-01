
import 'dart:convert';

class docuu {
  final int? appointment_id;

  docuu({
    required this.appointment_id,

  });
  factory docuu.fromRawJson(String str) => docuu.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory docuu.fromJson(Map<String, dynamic> json) => docuu(
    appointment_id: json["appointment_id"],

  );

  Map<String, dynamic> toJson() => {
    "appointment_id": appointment_id,
  };
}
