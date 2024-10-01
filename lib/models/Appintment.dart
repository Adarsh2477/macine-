import 'dart:convert';

class AppintmentModel {
  static List<Appintment> appintment=[];

  AppintmentModel(List<Appintment> doctors) {
    AppintmentModel.appintment = appintment;
  }
}

class Appintment {
  String? opd;
  String? velue;

  Appintment({
    required this.opd,
    required this.velue,

  });
  factory Appintment.fromRawJson(String str) => Appintment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Appintment.fromJson(Map<String, dynamic> json) => Appintment(
    opd:json['OPD'],
      velue:json['velue'],
  );
      Map<String, dynamic> toJson() => {
         "opd": opd,
        "velue":velue,
  };
}