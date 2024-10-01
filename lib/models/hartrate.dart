
import 'dart:convert';

class Heart_rate {
  final String? pulse;

  Heart_rate({
    required this.pulse,
  });
  factory Heart_rate.fromRawJson(String str) => Heart_rate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Heart_rate.fromJson(Map<String, dynamic> json) => Heart_rate(
    pulse:json["pulse"],
  );

  Map<String, dynamic> toJson() => {
    "pulse":pulse,
  };
}
