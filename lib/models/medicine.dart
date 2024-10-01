
import 'dart:convert';

class Medicine {
  final int? dose;
  final int? itemId;
  final String? itemName;
  final String? frequencyId;
  final String? forDays;
  final String? itemQty;
  final String? issuedQty;
  final String? dosage;
  final String? dosageCategoryId;
  final String? timingId;

  Medicine({
    required this.dose,
    required this.itemId,
    required this.itemName,
    required this.frequencyId,
    required this.forDays,
    required this.itemQty,
    required this.issuedQty,
    required this.dosage,
    required this.dosageCategoryId,
    required this.timingId,
  });
  factory Medicine.fromRawJson(String str) => Medicine.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
    dose: json["dose"],
    itemId: json["item_id"],
    itemName: json["item_name"],
    frequencyId: json["frequency_id"],
    forDays: json["for_days"],
    itemQty: json["item_qty"],
    issuedQty: json["issued_qty"],
    dosage: json["dosage"],
    dosageCategoryId: json["dosage_category_id"],
    timingId: json["timing_id"],
  );

  Map<String, dynamic> toJson() => {
    "dose": dose,
    "item_id": itemId,
    "item_name": itemName,
    "frequency_id": frequencyId,
    "for_days": forDays,
    "item_qty": itemQty,
    "issued_qty": issuedQty,
    "dosage": dosage,
    "dosage_category_id": dosageCategoryId,
    "timing_id": timingId,
  };
}
