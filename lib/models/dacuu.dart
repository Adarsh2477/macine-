
import 'dart:convert';

class docu {
  final String? checkup_id;

  docu({
    required this.checkup_id,

  });
  factory docu.fromRawJson(String str) => docu.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory docu.fromJson(Map<String, dynamic> json) => docu(
    checkup_id: json["checkup_id"],

  );

  Map<String, dynamic> toJson() => {
    "checkup_id": checkup_id,
  };
}
