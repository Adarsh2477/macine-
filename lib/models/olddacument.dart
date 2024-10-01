
import 'dart:convert';

class docufile {
  final String? file_name;

  docufile({
    required this.file_name,

  });
  factory docufile.fromRawJson(String str) => docufile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory docufile.fromJson(Map<String, dynamic> json) => docufile(
    file_name: json["file_name"],

  );

  Map<String, dynamic> toJson() => {
    "file_name": file_name,
  };
}
