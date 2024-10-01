
import 'dart:convert';

class Weight {
  final String? weight;

  Weight({
    required this.weight,
  });
  factory Weight.fromRawJson(String str) => Weight.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Weight.fromJson(Map<String, dynamic> json) => Weight(
    weight:json["weight"],
  );

  Map<String, dynamic> toJson() => {
    "weight":weight,
  };
}
