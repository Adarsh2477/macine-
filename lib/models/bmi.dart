
import 'dart:convert';

class Bmi {
  final String? bmi;

  Bmi({
    required this.bmi,
  });
  factory Bmi.fromRawJson(String str) => Bmi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bmi.fromJson(Map<String, dynamic> json) => Bmi(
    bmi:json["bmi"],
  );

  Map<String, dynamic> toJson() => {
    "bmi":bmi,
  };
}

class Treatment_Reco {
  final String? Time;
  final String? external_treatments;

  Treatment_Reco({
    required this.Time,
    required this.external_treatments,
  });
  factory Treatment_Reco.fromRawJson(String str) => Treatment_Reco.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Treatment_Reco.fromJson(Map<String, dynamic> json) => Treatment_Reco(
    Time:json["Time"],
    external_treatments:json["external_treatments"],
  );

  Map<String, dynamic> toJson() => {
    "Time":Time,
    "external_treatments":external_treatments,
  };
}

class healthindex {
  final String? health_index;


  healthindex({
    required this.health_index,

  });
  factory healthindex.fromRawJson(String str) => healthindex.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory healthindex.fromJson(Map<String, dynamic> json) => healthindex(
    health_index:json["health_index"],
  );

  Map<String, dynamic> toJson() => {
    "health_index":health_index,
  };
}
