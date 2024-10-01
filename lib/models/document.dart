
import 'dart:convert';

import 'olddacument.dart';

class document {
  final int? srno;
  final String? docname;
  final String? UploadedDate;
  final String? empid;
  final List<docufile>? Docufile;

  document({
    required this.docname,
    required this.Docufile,
    required this.UploadedDate,
    required this.srno,
    required this.empid,
  });
  factory document.fromRawJson(String str) => document.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory document.fromJson(Map<String, dynamic> json) => document(
    Docufile:json['docufile'] == null ? null : (json['docufile'] as List).map<docufile>((data)=> docufile.fromJson(data  as Map<String,dynamic>)).toList(),
    srno: json["srno"],
    docname:json["docname"],
    UploadedDate:json["UploadedDate"],
    empid:json["empid"],
  );

  Map<String, dynamic> toJson() => {
    'Docufile': Docufile?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
    "srno": srno,
    "docname":docname,
    "UploadedDate":UploadedDate,
    "empid":empid,
  };
}
