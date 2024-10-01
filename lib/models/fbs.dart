
import 'dart:convert';

class Fbs {
  final String? fbs;

  Fbs({
    required this.fbs,
  });
  factory Fbs.fromRawJson(String str) => Fbs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Fbs.fromJson(Map<String, dynamic> json) => Fbs(
    fbs:json["fbs"],
  );

  Map<String, dynamic> toJson() => {
    "fbs":fbs,
  };
}


class Rbs {
  final String? rbs;

  Rbs({
    required this.rbs,
  });
  factory Rbs.fromRawJson(String str) => Rbs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rbs.fromJson(Map<String, dynamic> json) => Rbs(
    rbs:json["rbs"],
  );

  Map<String, dynamic> toJson() => {
    "rbs":rbs,
  };
}

class Ppbs {
  final String? ppbs;

  Ppbs({
    required this.ppbs,
  });
  factory Ppbs.fromRawJson(String str) => Ppbs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ppbs.fromJson(Map<String, dynamic> json) => Ppbs(
    ppbs:json["ppbs"],
  );

  Map<String, dynamic> toJson() => {
    "ppbs":ppbs,
  };
}
class Hight {
  final String? height;

  Hight({
    required this.height,
  });
  factory Hight.fromRawJson(String str) => Hight.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hight.fromJson(Map<String, dynamic> json) => Hight(
    height:json["height"],
  );

  Map<String, dynamic> toJson() => {
    "height":height,
  };
}

class Previous_OPD {
  final String? appointment_date;
  final String? Diagnosis;
  final String? Treatment;
  final String? complaints;

  Previous_OPD({
    required this.appointment_date,
    required this.Diagnosis,
    required this.Treatment,
    required this.complaints,
  });
  factory Previous_OPD.fromRawJson(String str) => Previous_OPD.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Previous_OPD.fromJson(Map<String, dynamic> json) => Previous_OPD(
    appointment_date:json["appointment_date"],
    Diagnosis:json["Diagnosis"],
    Treatment:json["Treatment"],
    complaints:json["complaints"],
  );

  Map<String, dynamic> toJson() => {
    "appointment_date":appointment_date,
    "Diagnosis":Diagnosis,
    "Treatment":Treatment,
    "Diagnosis":Diagnosis,
  };
}
class Previous_Injury {
  final String? appointment_date;
  final String? Diagnosis;
  final String? Treatment;
  final String? complaints;

  Previous_Injury({
    required this.appointment_date,
    required this.Diagnosis,
    required this.Treatment,
    required this.complaints,
  });
  factory Previous_Injury.fromRawJson(String str) => Previous_Injury.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Previous_Injury.fromJson(Map<String, dynamic> json) => Previous_Injury(
    appointment_date:json["appointment_date"],
    Diagnosis:json["Diagnosis"],
    Treatment:json["Treatment"],
    complaints:json["complaints"],
  );

  Map<String, dynamic> toJson() => {
    "appointment_date":appointment_date,
    "Diagnosis":Diagnosis,
    "Treatment":Treatment,
    "Diagnosis":Diagnosis,
  };
}

class Previous_Sickness {
  final String? appointment_date;
  final String? Diagnosis;
  // final String? Treatment;
  // final String? complaints;

  Previous_Sickness({
    required this.appointment_date,
    required this.Diagnosis,
    // required this.Treatment,
    // required this.complaints,
  });
  factory Previous_Sickness.fromRawJson(String str) => Previous_Sickness.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Previous_Sickness.fromJson(Map<String, dynamic> json) => Previous_Sickness(
    appointment_date:json["appointment_date"],
    Diagnosis:json["Diagnosis"],
    // Treatment:json["Treatment"],
    // complaints:json["complaints"],
  );

  Map<String, dynamic> toJson() => {
    "appointment_date":appointment_date,
    "Diagnosis":Diagnosis,
    // "Treatment":Treatment,
    // "Diagnosis":Diagnosis,
  };
}

class Previous_Medical {
  final String? checkup_date;
  final String? Medications;
  // final String? Treatment;
  // final String? complaints;

  Previous_Medical({
    required this.checkup_date,
    required this.Medications,
    // required this.Treatment,
    // required this.complaints,
  });
  factory Previous_Medical.fromRawJson(String str) => Previous_Medical.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Previous_Medical.fromJson(Map<String, dynamic> json) => Previous_Medical(
    checkup_date:json["checkup_date"],
    Medications:json["Medications"],
    // Treatment:json["Treatment"],
    // complaints:json["complaints"],
  );

  Map<String, dynamic> toJson() => {
    "checkup_date":checkup_date,
    "Medications":Medications,
    // "Treatment":Treatment,
    // "Diagnosis":Diagnosis,
  };
}


class Illness {
  final String? diagnosis_date;
  final String? diseases;
  final String? medicine_name;
  final String? medicine_frequency;

  Illness({
    required this.diagnosis_date,
    required this.diseases,
    required this.medicine_name,
    required this.medicine_frequency,
  });
  factory Illness.fromRawJson(String str) => Illness.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Illness.fromJson(Map<String, dynamic> json) => Illness(
    diagnosis_date:json["diagnosis_date"],
    diseases:json["diseases"],
    medicine_name:json["medicine_name"],
    medicine_frequency:json["medicine_frequency"],
  );

  Map<String, dynamic> toJson() => {
    "diagnosis_date":diagnosis_date,
    "diseases":diseases,
    "medicine_name":medicine_name,
    "medicine_frequency":medicine_frequency,
  };
}


class Previous_Emergency {
  final String? appointment_date;
  final String? complaints;
  final String? Treatment;
  //final String? medicine_frequency;

  Previous_Emergency({
    required this.appointment_date,
    required this.complaints,
    required this.Treatment,
    //required this.medicine_frequency,
  });
  factory Previous_Emergency.fromRawJson(String str) => Previous_Emergency.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Previous_Emergency.fromJson(Map<String, dynamic> json) => Previous_Emergency(
    appointment_date:json["appointment_date"],
    complaints:json["complaints"],
    Treatment:json["Treatment"],
    //medicine_frequency:json["medicine_frequency"],
  );

  Map<String, dynamic> toJson() => {
    "appointment_date":appointment_date,
    "complaints":complaints,
    "Treatment":Treatment,
    // "medicine_frequency":medicine_frequency,
  };
}


class Training {
  final String? training_name;
  final String? from_date;
  final String? to_date;
  final String? trainer_name;
  final String? completion_date;
  final String? training_location;

  Training({
    required this.training_name,
    required this.from_date,
    required this.to_date,
    required this.trainer_name,
    required this.completion_date,
    required this.training_location,
  });
  factory Training.fromRawJson(String str) => Training.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Training.fromJson(Map<String, dynamic> json) => Training(
    training_name:json["training_name"],
    from_date:json["from_date"],
    to_date:json["to_date"],
    trainer_name:json["trainer_name"],
    completion_date:json["completion_date"],
    training_location:json["training_location"],
  );

  Map<String, dynamic> toJson() => {
    "training_name":training_name,
    "from_date":from_date,
    "to_date":to_date,
    "trainer_name":trainer_name,
    "completion_date":completion_date,
    "training_location":training_location,
  };
}
class Health_Advices {
  final String? appointment_date;
  final String? Advices;

  Health_Advices({
    required this.appointment_date,
    required this.Advices,
    //required this.medicine_frequency,
  });
  factory Health_Advices.fromRawJson(String str) => Health_Advices.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Health_Advices.fromJson(Map<String, dynamic> json) => Health_Advices(
    appointment_date:json["appointment_date"],
    Advices:json["Advices"],
    //medicine_frequency:json["medicine_frequency"],
  );

  Map<String, dynamic> toJson() => {
    "appointment_date":appointment_date,
    "Advices":Advices,
    // "medicine_frequency":medicine_frequency,
  };
}

class BMIGRAFH {
  final String? dat;
  final dynamic? height;
  final dynamic? weight;
  final dynamic? bmi;

  BMIGRAFH({
    required this.dat,
    required this.height,
    required this.weight,
    required this.bmi,
    //required this.medicine_frequency,
  });
  factory BMIGRAFH.fromRawJson(String str) => BMIGRAFH.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BMIGRAFH.fromJson(Map<String, dynamic> json) => BMIGRAFH(
    dat:json["dat"],
    height:json["height"],
    weight:json["weight"],
    bmi:json["bmi"],
    //medicine_frequency:json["medicine_frequency"],
  );

  Map<String, dynamic> toJson() => {
    "dat":dat,
    "height":height,
    "weight":weight,
    "bmi":bmi,
  };
}
