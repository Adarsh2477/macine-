
import 'dart:convert';

class ChronicIllness {
  final int? srno;
  final String? diseases;
  final String? medicine_name;

  ChronicIllness({
    required this.diseases,
    required this.medicine_name,
    required this.srno

  });
  factory ChronicIllness.fromRawJson(String str) => ChronicIllness.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChronicIllness.fromJson(Map<String, dynamic> json) => ChronicIllness(
    srno: json["srno"],
    diseases:json["diseases"],
    medicine_name:json['medicine_name'],

  );

  Map<String, dynamic> toJson() => {
    "srno": srno,
    "diseases":diseases,
    "medicine_name":medicine_name,

  };
}
