
import 'dart:convert';

import 'package:ohctech/models/dacu.dart';

// import 'medicine.dart';

class Appointment {
  final String? urine;
  final String? clearance_time;
  final String? IN_TIME;
  final String? Follow_up_date;
  final String? Body_System;
  final String? Diagnosis;
  final String? Ecg_Finding;
  final String? Investigation_Details;
  final String? case_type;
  final String? DIVISION;
  final String? injury_remarks;
  final String? classification;
  final String? parts;
  final String? typeinjury;
  final String? Chronic;
  final String? recommended_tests_new;
  final String? doc_comment;
  final String? heart_rate;
  final String? mobility;
  final String? trama;
  final String? referred_by;
  final int? srno;
  final String? referral;
  final String? type;
  final String? appointment_date;
  final String? doctor_last_attended;
  final String? ohc_type_id;
  final String? age;
  final String? doj;
  final String? health_risks;
  final String? health_advices;
  final String? primary_contact_no;
  final String? status;
  final String? ps;
  final String? aadhar_no;
  final String? patient_cat_id;
  final String? pending_opd_count;
  final String? pending_injury_count;
  final String? pending_medical_count;
  final String? pending_sickness_count;
  final String? approved_opd_count;
  final String? approved_injury_count;
  final String? approved_medical_count;
  final String? approved_sickness_count;
  final String? id;
  final String? item_id;
  final String? frequency_id;
  final String? for_days;
  final String? item_qty;
  final String? issued_qty;
  final String? dosage;
  final String? dosage_category_id;
  final String? timing_id;
  final int? appointment_id;
  final int? medical_exam_id;
  final int? sickness_id;
  final String? patient_name;
  final String? gender;
  final String? emp_code;
  final String? ticket_no;
  final String? body_system;
  final String? complaints;
  final String? diagnosis;
  final String? remarks_rece;
  final String? examination_remarks;
  final String? temperature;
  final String? spo2_percent;
  final String? injury_time;
  final String? injury_cause;
  final String? branch_area;
  final String? incident_location;
  final String? injury_procedure;
  final String? injury_parts_new;
  final String? injury_classes_new;
  final String? injury_types_new;
  final String? sickness_name;
  final String? des;
  final String? sickness_date;
  final String? sickness_time;
  final String? approval_date;
  final String? date_absent;
  final String? date_absent_to;
  final String? date_return;
  final String? date_rejoin;
  final String? fitness_status;
  final String? ailment_system;
  final String? ailment_name;
  final String? agency;
  final String? medical_entry_date;
  final String? peme_no;
  final String? height;
  final String? weight;
  final String? bmi;
  final String? pulse;
  final String? bp;
  final String? bp_sbp;
  final String? bp_dbp;
  final String? s1;
  final String? any_other_sound;
  final String? ecg_findings;
  final String? father_name;
  final String? designation_name;
  final String? primary_phone;
  final String? email_id;
  final String? identi_mark;
  final String? village;
  final String? post;
  final String? tehsil;
  final String? district;
  final String? state;
  final String? pin_code;
  final String? chest;
  final String? chest_in;
  final String? chest_exp;
  final String? skin;
  final String? musculo_skeletal;
  final String? hb;
  final String? tlc;
  final String? dlc_n;
  final String? dlc_l;
  final String? dlc_m;
  final String? dlc_e;
  final String? esr;
  final String? blood_sugar_fbs;
  final String? blood_sugar_rbs;
  final String? uric_acid;
  final String? s_urea;
  final String? s_creatinine;
  final String? total_bilirubin;
  final String? sgop;
  final String? sgpt;
  final String? total_cholestrol;
  final String? ldl;
  final String? triglycerides;
  final String? urine_re_me;
  final String? urine_re_me_comments;
  final String? dis_without_right_eye;
  final String? dis_without_left_eye;
  final String? near_without_right_eye;
  final String? near_without_left_eye;
  final String? deformities;
  final String? cns;
  final String? nose;
  final String? throat;
  final String? ear;
  final String? audio_findings_left;
  final String? blood_sugar_ppbs;
  final String? hiv;
  final String? hcv;
  final String? hbsag;
  final String? sodium;
  final String? potassium;
  final String? phosphate;
  final String? hco3;
  final String? conj;
  final String? uniconj;
  final String? alk_phosphatase;
  final String? total_protein;
  final String? albumin;
  final String? globulin;
  final String? vldl;
  final String? hdl;
  final String? speech;
  final String? higher_function;
  final String? motor_function;
  final String? vertigo;
  final String? reflexes;
  final String? vibration_syndrome;
  final String? conversational_hearing;
  final String? teeth_n_gum;
  final String? spiro_remarks;
  final String? liver;
  final String? speen;
  final String? tenderness;
  final String? any_other_abnormality;
  final String? hernia_details;
  final String? hydrocele_details;
  final String? phimosis;
  final String? piles;
  final String? fistula;
  final String? xray_findings;
  final String? other_relevant_findings;
  final String? remarks;
  final String? comments;
  final String? dlc_b;
  final String? drug_allergy;
  final String? followup_to_opd;
  final String? followup;
  final String? external_treatments;
  final String? dob;
  final String? ans;
  final String? employer_contractor;
  final String? dept;
  final String? designation;
  final String? spo2;
  final String? cold_cough;
  final String? general_weakness;
  final String? smell;
  final String? calcium;
  final String? st_line_walking;
  final String? eac;
  final String? near_with_right_eye;
  final String? dis_with_right_eye;
  final String? dis_with_left_eye;
  final String? near_with_left_eye;
  final String? color_vision;
  final String? ln_v;
  final String? ln_axis;
  final String? ln_dcyl;
  final String? ln_dsph;
  final String? ld_v;
  final String? ld_axis;
  final String? ld_dcyl;
  final String? ld_dsph;
  final String? rn_v;
  final String? rn_axis;
  final String? rn_dcyl;
  final String? rn_dsph;
  final String? rd_v;
  final String? rd_axis;
  final String? rd_dcyl;
  final String? rd_dsph;
  final String? lair_250;
  final String? lair_500;
  final String? lair_1000;
  final String? lair_2000;
  final String? lair_4000;
  final String? lair_8000;
  final String? lbone_250;
  final String? lbone_500;
  final String? lbone_1000;
  final String? lbone_2000;
  final String? lbone_4000;
  final String? lbone_8000;
  final String? rair_250;
  final String? rair_500;
  final String? rair_1000;
  final String? rair_2000;
  final String? rair_4000;
  final String? rair_8000;
  final String? rbone_250;
  final String? rbone_500;
  final String? rbone_1000;
  final String? rbone_2000;
  final String? rbone_4000;
  final String? rbone_8000;
  final String? bn_findings;
  final String? a;
  final String? cy;
  final String? i;
  final String? cl;
  final String? e;
  final List<docuu>? Docuu;
  // final List<Medicine>? medicines;

  Appointment({
    required this.Docuu,
    required this.clearance_time,
    required this.IN_TIME,
    required this.Follow_up_date,
    required this.Diagnosis,
    required this.Investigation_Details,
    required this.case_type,
    required this.DIVISION,
    required this.recommended_tests_new,
    required this.doc_comment,
    required this.heart_rate,
    required this.referred_by,
    required this.Body_System,
    required this.mobility,
    required this.trama,
    required this.srno,
    required this.type,
    required this.appointment_date,
    required this.doctor_last_attended,
    required this.ohc_type_id,
    required this.age,
    required this.parts,
    required this.doj,
    required this.urine,
    required this.health_risks,
    required this.health_advices,
    required this.status,
    required this.primary_contact_no,
    required this.ps,
    required this.aadhar_no,
    required this.patient_cat_id,
    // this.medicines,
    required this.pending_opd_count,
    required this.pending_injury_count,
    required this.pending_medical_count,
    required this.pending_sickness_count,
    required this.approved_opd_count,
    required this.approved_injury_count,
    required this.approved_medical_count,
    required this.approved_sickness_count,
    required this.id,
    required this.typeinjury,
    required this.Chronic,
    required this.item_id,
    required this.frequency_id,
    required this.for_days,
    required this.item_qty,
    required this.issued_qty,
    required this.dosage,
    required this.dosage_category_id,
    required this.timing_id,
    required this.appointment_id,
    required this.medical_exam_id,
    required this.sickness_id,
    required this.gender,
    required this.patient_name,
    required this.emp_code,
    required this.ticket_no,
    required this.body_system,
    required this.complaints,
    required this.spo2_percent,
    required this.temperature,
    required this.diagnosis,
    required this.remarks_rece,
    required this.examination_remarks,
    required this.injury_time,
    required this.injury_cause,
    required this.injury_remarks,
    required this.branch_area,
    required this.incident_location,
    required this.injury_procedure,
    required this.injury_parts_new,
    required this.injury_classes_new,
    required this.classification,
    required this.injury_types_new,
    required this.sickness_name,
    required this.des,
    required this.sickness_date,
    required this.sickness_time,
    required this.approval_date,
    required this.date_absent,
    required this.date_absent_to,
    required this.date_return,
    required this.date_rejoin,
    required this.fitness_status,
    required this.ailment_system,
    required this.ailment_name,
    required this.agency,
    required this.medical_entry_date,
    required this.peme_no,
    required this.height,
    required this.weight,
    required this.bmi,
    required this.pulse,
    required this.bp,
    required this.bp_sbp,
    required this.bp_dbp,
    required this.s1,
    required this.any_other_sound,
    required this.ecg_findings,
    required this.father_name,
    required this.designation_name,
    required this.primary_phone,
    required this.email_id,
    required this.identi_mark,
    required this.village,
    required this.post,
    required this.tehsil,
    required this.district,
    required this.state,
    required this.pin_code,
    required this.chest,
    required this.chest_in,
    required this.chest_exp,
    required this.skin,
    required this.musculo_skeletal,
    required this.hb,
    required this.tlc,
    required this.dlc_n,
    required this.dlc_l,
    required this.dlc_m,
    required this.dlc_e,
    required this.esr,
    required this.blood_sugar_fbs,
    required this.blood_sugar_rbs,
    required this.Ecg_Finding,
    required this.uric_acid,
    required this.s_urea,
    required this.s_creatinine,
    required this.total_bilirubin,
    required this.sgop,
    required this.sgpt,
    required this.total_cholestrol,
    required this.ldl,
    required this.triglycerides,
    required this.urine_re_me,
    required this.urine_re_me_comments,
    required this.dis_without_right_eye,
    required this.dis_without_left_eye,
    required this.near_without_right_eye,
    required this.near_without_left_eye,
    required this.deformities,
    required this.cns,
    required this.nose,
    required this.throat,
    required this.ear,
    required this.audio_findings_left,
    required this.blood_sugar_ppbs,
    required this.hiv,
    required this.hcv,
    required this.hbsag,
    required this.sodium,
    required this.potassium,
    required this.phosphate,
    required this.hco3,
    required this.conj,
    required this.uniconj,
    required this.alk_phosphatase,
    required this.total_protein,
    required this.albumin,
    required this.globulin,
    required this.vldl,
    required this.hdl,
    required this.speech,
    required this.higher_function,
    required this.motor_function,
    required this.vertigo,
    required this.reflexes,
    required this.vibration_syndrome,
    required this.conversational_hearing,
    required this.teeth_n_gum,
    required this.spiro_remarks,
    required this.liver,
    required this.speen,
    required this.tenderness,
    required this.any_other_abnormality,
    required this.hernia_details,
    required this.hydrocele_details,
    required this.phimosis,
    required this.piles,
    required this.fistula,
    required this.xray_findings,
    required this.other_relevant_findings,
    required this.remarks,
    required this.comments,
    required this.dlc_b,
    required this.drug_allergy,
    required this.followup_to_opd,
    required this.followup,
    required this.external_treatments,
    required this.dob,
    required this.ans,
    required this.employer_contractor,
    required this.dept,
    required this.designation,
    required this.spo2,
    required this.cold_cough,
    required this.general_weakness,
    required this.smell,
    required this.calcium,
    required this.st_line_walking,
    required this.eac,
    required this.near_with_right_eye,
    required this.dis_with_right_eye,
    required this.dis_with_left_eye,
    required this.near_with_left_eye,
    required this.color_vision,
    required this.ln_v,
    required this.ln_axis,
    required this.ln_dcyl,
    required this.ln_dsph,
    required this.ld_v,
    required this.ld_axis,
    required this.ld_dcyl,
    required this.ld_dsph,
    required this.rn_v,
    required this.rn_axis,
    required this.rn_dcyl,
    required this.rn_dsph,
    required this.rd_v,
    required this.rd_axis,
    required this.rd_dcyl,
    required this.rd_dsph,
    required this.lair_250,
    required this.lair_500,
    required this.lair_1000,
    required this.lair_2000,
    required this.lair_4000,
    required this.lair_8000,
    required this.lbone_250,
    required this.lbone_500,
    required this.lbone_1000,
    required this.lbone_2000,
    required this.lbone_4000,
    required this.lbone_8000,
    required this.rair_250,
    required this.rair_500,
    required this.rair_1000,
    required this.rair_2000,
    required this.rair_4000,
    required this.rair_8000,
    required this.rbone_250,
    required this.rbone_500,
    required this.rbone_1000,
    required this.rbone_2000,
    required this.rbone_4000,
    required this.rbone_8000,
    required this.bn_findings,
    required this.a,
    required this.cy,
    required this.i,
    required this.cl,
    required this.e,
    required this.referral,
  });
  factory Appointment.fromRawJson(String str) => Appointment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
   // medicines:json['medicines'] == null ? null : (json['medicines'] as List).map<Medicine>((data)=> Medicine.fromJson(data  as Map<String,dynamic>)).toList(),
    Docuu:json['docuu'] == null ? null : (json['docuu'] as List).map<docuu>((data)=> docuu.fromJson(data  as Map<String,dynamic>)).toList(),
    ohc_type_id:json['ohc_type_id'],
    srno:json['srno'],
    Follow_up_date:json['Follow_up_date'],
    heart_rate:json['heart_rate'],
    mobility:json['mobility'],
    referral:json['referral'],
    type:json['type'],
    typeinjury:json['typeinjury'],
    doc_comment:json['doc_comment'],
    trama:json['trama'],
    injury_remarks:json['injury_remarks'],
    doctor_last_attended:json['doctor_last_attended'],
    DIVISION:json['DIVISION'],
    age: json['age'],
    referred_by:json['referred_by'],
    doj: json['doj'],
    appointment_id:json['appointment_id'],
    parts:json['parts'],
    Chronic:json['Chronic'],
    health_risks: json['health_risks'],
    health_advices: json['health_advices'],
    status: json['status'],
    primary_contact_no: json['primary_contact_no'],
    ps: json['ps'],
    Body_System:json['Body_System'],
    aadhar_no: json['aadhar_no'],
    patient_cat_id: json['patient_cat_id'],
    pending_opd_count: json['count_opd'],
    pending_injury_count: json['count_injury'],
    pending_sickness_count: json['count_sickness'],
    pending_medical_count: json['count_medical'],
    approved_opd_count: json['count_opd_approved'],
    approved_injury_count: json['count_injury_approved'],
    approved_sickness_count: json['count_sickness_approved'],
    approved_medical_count: json['count_medical_approved'],
    id: json['id'],
    Diagnosis:json['Diagnosis'],
    recommended_tests_new:json['recommended_tests_new'],
    Investigation_Details:json['Investigation_Details'],
    item_id: json['item_id'],
    case_type:json['case_type'],
    frequency_id: json['frequency_id'],
    for_days: json['for_days'],
    item_qty: json['item_qty'],
    issued_qty: json['issued_qty'],
    dosage: json['dosage'],
    date_rejoin:json['date_rejoin'],
    classification:json['classification'],
    dosage_category_id: json['dosage_category_id'],
    timing_id: json['timing_id'],
    medical_exam_id: json['medical_exam_id'],
    sickness_id: json['sickness_id'],
    patient_name: json['patient_name'],
    gender: json['gender'],
    emp_code: json['emp_code'],
    ticket_no: json['ticket_no'],
    appointment_date: json['appointment_date'],
    body_system: json['ailment_system'],
    diagnosis: json['diagnosis'],
    complaints: json['complaints'],
    temperature: json['temperature'],
    spo2_percent: json['spo2_percent'],
    remarks_rece: json['remarks_rece'],
    examination_remarks: json['examination_remarks'],
    injury_time: json['injury_time'],
    injury_cause: json['injury_cause'],
    branch_area: json['branch_area'],
    incident_location: json['incident_location'],
    injury_procedure: json['injury_procedure'],
    injury_parts_new: json['injury_parts_new'],
    injury_classes_new: json['injury_classes_new'],
    injury_types_new: json['injury_types_new'],
    sickness_name: json['sickness_name'],
    des: json['des'],
    clearance_time:json['clearance_time'],
    Ecg_Finding:json['Ecg_Finding'],
    sickness_date: json['sickness_date'],
    sickness_time: json['sickness_time'],
    approval_date: json['approval_date'],
    date_absent: json['date_absent'],
    date_absent_to: json['date_absent_to'],
    date_return: json['date_return'],
    fitness_status: json['fitness_status'],
    ailment_system: json['ailment_system'],
    ailment_name: json['ailment_name'],
    agency: json['agency'],
    medical_entry_date: json['medical_entry_date'],
    peme_no: json['peme_no'],
    height: json['height'],
    weight: json['weight'],
    bmi: json['bmi'],
    pulse: json['pulse'],
    IN_TIME:json['IN_TIME'],
    bp: json['bp'],
    bp_sbp: json['bp_sbp'],
    bp_dbp: json['bp_dbp'],
    s1: json['s1'],
    any_other_sound: json['any_other_sound'],
    ecg_findings: json['ecg_findings'],
    father_name: json['father_name'],
    designation_name: json['designation_name'],
    primary_phone: json['primary_phone'],
    email_id: json['email_id'],
    identi_mark: json['identi_mark'],
    village: json['village'],
    post: json['post'],
    tehsil:  json['tehsil'],
    district: json['district'],
    state: json['state'],
    pin_code: json['pin_code'],
    chest: json['chest'],
    chest_in: json['chest_in'],
    chest_exp: json['chest_exp'],
    skin: json['skin'],
    musculo_skeletal: json['musculo_skeletal'],
    hb: json['hb'],
    tlc: json['tlc'],
    dlc_n: json['dlc_n'],
    dlc_l: json['dlc_l'],
    dlc_m: json['dlc_m'],
    dlc_e: json['dlc_e'],
    esr: json['esr'],
    blood_sugar_fbs: json['blood_sugar_fbs'],
    blood_sugar_rbs: json['blood_sugar_rbs'],
    uric_acid: json['uric_acid'],
    s_urea: json['s_urea'],
    s_creatinine: json['s_creatinine'],
    total_bilirubin: json['total_bilirubin'],
    sgop: json['sgop'],
    sgpt: json['sgpt'],
    total_cholestrol: json['total_cholestrol'],
    ldl: json['ldl'],
    triglycerides: json['triglycerides'],
    urine_re_me: json['urine_re_me'],
    urine_re_me_comments: json['urine_re_me_comments'],
    dis_without_right_eye: json['dis_without_right_eye'],
    dis_without_left_eye: json['dis_without_left_eye'],
    near_without_right_eye: json['near_without_right_eye'],
    near_without_left_eye: json['near_without_left_eye'],
    deformities: json['deformities'],
    cns:json['cns'],
    nose: json['nose'],
    throat: json['throat'],
    ear: json['ear'],
    audio_findings_left: json['audio_findings_left'],
    blood_sugar_ppbs: json['blood_sugar_ppbs'],
    hiv: json['hiv'],
    hcv: json['hcv'],
    hbsag: json['hbsag'],
    sodium: json['sodium'],
    potassium: json['potassium'],
    phosphate: json['phosphate'],
    hco3: json['hco3'],
    conj: json['conj'],
    uniconj: json['uniconj'],
    alk_phosphatase: json['alk_phosphatase'],
    total_protein: json['total_protein'],
    albumin: json['albumin'],
    globulin: json['globulin'],
    vldl: json['vldl'],
    hdl: json['hdl'],
    urine:json['urine'],
    speech: json['speech'],
    higher_function: json['higher_function'],
    motor_function: json['motor_function'],
    vertigo: json['vertigo'],
    reflexes: json['reflexes'],
    vibration_syndrome: json['vibration_syndrome'],
    conversational_hearing: json['conversational_hearing'],
    teeth_n_gum: json['teeth_n_gum'],
    spiro_remarks: json['spiro_remarks'],
    liver: json['liver'],
    speen: json['speen'],
    tenderness: json['tenderness'],
    any_other_abnormality: json['any_other_abnormality'],
    hernia_details: json['hernia_details'],
    hydrocele_details: json['hydrocele_details'],
    phimosis: json['phimosis'],
    piles: json['piles'],
    fistula: json['fistula'],
    xray_findings: json['xray_findings'],
    other_relevant_findings: json['other_relevant_findings'],
    remarks: json['remarks'],
    comments: json['comments'],
    dlc_b: json['dlc_b'],
    drug_allergy: json['drug_allergy'],
    followup_to_opd: json['followup_to_opd'],
    followup: json['followup'],
    external_treatments: json['external_treatments'],
    dob: json['dob'],
    ans: json['ans'],
    employer_contractor: json['employer_contractor'],
    dept: json['dept'],
    designation: json['designation'],
    spo2: json['SpO2'],
    cold_cough: json['cold_cough'],
    general_weakness: json['general_weakness'],
    smell: json['smell'],
    calcium: json['calcium'],
    st_line_walking: json['st_line_walking'],
    eac: json['eac'],
    near_with_right_eye: json['near_with_right_eye'],
    dis_with_right_eye: json['dis_with_right_eye'],
    dis_with_left_eye: json['dis_with_left_eye'],
    near_with_left_eye: json['near_with_left_eye'],
    color_vision: json['color_vision'],
    ln_v: json['ln_v'],
    ln_axis: json['ln_axis'],
    ln_dcyl: json['ln_dcyl'],
    ln_dsph: json['ln_dsph'],
    ld_v: json['ld_v'],
    ld_axis: json['ld_axis'],
    ld_dcyl: json['ld_dcyl'],
    ld_dsph: json['ld_dsph'],
    rn_v: json['rn_v'],
    rn_axis: json['rn_axis'],
    rn_dcyl: json['rn_dcyl'],
    rn_dsph: json['rn_dsph'],
    rd_v: json['rd_v'],
    rd_axis: json['rd_axis'],
    rd_dcyl: json['rd_dcyl'],
    rd_dsph: json['rd_dsph'],
    lair_250: json['lair_250'],
    lair_500: json['lair_500'],
    lair_1000: json['lair_1000'],
    lair_2000: json['lair_2000'],
    lair_4000: json['lair_4000'],
    lair_8000: json['lair_8000'],
    lbone_250: json['lbone_250'],
    lbone_500: json['lbone_500'],
    lbone_1000: json['lbone_1000'],
    lbone_2000: json['lbone_2000'],
    lbone_4000: json['lbone_4000'],
    lbone_8000: json['lbone_8000'],
    rair_250: json['rair_250'],
    rair_500: json['rair_500'],
    rair_1000: json['rair_1000'],
    rair_2000: json['rair_2000'],
    rair_4000: json['rair_4000'],
    rair_8000: json['rair_8000'],
    rbone_250: json['rbone_250'],
    rbone_500: json['rbone_500'],
    rbone_1000: json['rbone_1000'],
    rbone_2000: json['rbone_2000'],
    rbone_4000: json['rbone_4000'],
    rbone_8000: json['rbone_8000'],
    bn_findings: json['bn_findings'],
    a: json['a'],
    cy: json['cy'],
    i: json['i'],
    cl: json['cl'],
    e: json['e'],
  );

  Map<String, dynamic> toJson() => {
    //'medicines': medicines?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
    'Docuu': Docuu?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
    'ohctypeid':ohc_type_id,
    'srno':srno,
    'heart_rate':heart_rate,
    'mobility':mobility,
    'referral':referral,
    'Ecg_Finding':Ecg_Finding,
    'type':type,
    'trama':trama,
    'doctor_last_attended':doctor_last_attended,
    'age':age,
    'doj': doj,
    'appointment_id':appointment_id,
    'referred_by':referred_by,
    'health_risks': health_risks,
    'health_advices': health_advices,
    'status': status,
    'DIVISION':DIVISION,
    'primary_contact_no': primary_contact_no,
    'ps': ps,
    'date_rejoin':date_rejoin,
    'aadhar_no': aadhar_no,
    'patient_cat_id': patient_cat_id,
    'count_opd': pending_opd_count,
    'count_injury': pending_injury_count,
    'count_sickness': pending_sickness_count,
    'count_medical': pending_medical_count,
    'count_opd_approved': approved_opd_count,
    'count_injury_approved': approved_injury_count,
    'count_sickness_approved': approved_sickness_count,
    'count_medical_approved': approved_medical_count,
    'id': id,
    'parts':parts,
    'Investigation_Details':Investigation_Details,
    'recommended_tests_new':recommended_tests_new,
    'item_id': item_id,
    'frequency_id': frequency_id,
    'for_days': for_days,
    'issued_qty': issued_qty,
    'item_qty': item_qty,
    'dosage': dosage,
    'dosage_category_id': dosage_category_id,
    'timing_id': timing_id,
    'medical_exam_id': medical_exam_id,
    'sickness_id': sickness_id,
    'patient_name': patient_name,
    'gender': gender,
    'Follow_up_date':Follow_up_date,
    'emp_code': emp_code,
    'ticket_no': ticket_no,
    'appointment_date': appointment_date,
    'ailment_system': body_system,
    'diagnosis': diagnosis,
    'complaints': complaints,
    'temperature': temperature,
    'remarks_rece': remarks_rece,
    'examination_remarks': examination_remarks,
    'injury_time': injury_time,
    'injury_cause': injury_cause,
    'branch_area': branch_area,
    'incident_location': incident_location,
    'injury_procedure': injury_procedure,
    'injury_parts_new': injury_parts_new,
    'injury_classes_new': injury_classes_new,
    'injury_types_new': injury_types_new,
    'sickness_name': sickness_name,
    'des': des,
    'typeinjury':typeinjury,
    'Diagnosis':Diagnosis,
    'Chronic':Chronic,
    'doc_comment':doc_comment,
    'sickness_date': sickness_date,
    'sickness_time': sickness_time,
    'approval_date': approval_date,
    'date_absent': date_absent,
    'date_absent_to': date_absent_to,
    'date_return': date_return,
    'fitness_status': fitness_status,
    'ailment_system': ailment_system,
    'ailment_name': ailment_name,
    'agency': agency,
    'medical_entry_date': medical_entry_date,
    'peme_no': peme_no,
    'height': height,
    'weight': weight,
    'bmi': bmi,
    'pulse': pulse,
    'urine':urine,
    'bp': bp,
    'bp_sbp': bp_sbp,
    'bp_dbp': bp_dbp,
    's1': s1,
    'spo2_percent': spo2_percent,
    'any_other_sound': any_other_sound,
    'ecg_findings': ecg_findings,
    'father_name': father_name,
    'designation_name': designation_name,
    'primary_phone': primary_phone,
    'email_id': email_id,
    'identi_mark': identi_mark,
    'village': village,
    'post': post,
    'tehsil': tehsil,
    'district': district,
    'state': state,
    'pin_code': pin_code,
    'classification':classification,
    'chest': chest,
    'chest_in': chest_in,
    'chest_exp': chest_exp,
    'skin': skin,
    'musculo_skeletal': musculo_skeletal,
    'hb': hb,
    'tlc': tlc,
    'IN_TIME':IN_TIME,
    'dlc_n': dlc_n,
    'case_type':case_type,
    'dlc_l': dlc_l,
    'dlc_m': dlc_m,
    'dlc_e': dlc_e,
    'Body_System':Body_System,
    'esr': esr,
    'blood_sugar_fbs': blood_sugar_fbs,
    'blood_sugar_rbs': blood_sugar_rbs,
    'uric_acid': uric_acid,
    's_urea': s_urea,
    's_creatinine': s_creatinine,
    'total_bilirubin': total_bilirubin,
    'sgop': sgop,
    'sgpt': sgpt,
    'total_cholestrol': total_cholestrol,
    'ldl': ldl,
    'triglycerides': triglycerides,
    'urine_re_me': urine_re_me,
    'urine_re_me_comments': urine_re_me_comments,
    'dis_without_right_eye': dis_without_right_eye,
    'dis_without_left_eye': dis_without_left_eye,
    'near_without_right_eye': near_without_right_eye,
    'near_without_left_eye': near_without_left_eye,
    'deformities': deformities,
    'cns': cns,
    'nose': nose,
    'throat': throat,
    'ear': ear,
    'audio_findings_left': audio_findings_left,
    'blood_sugar_ppbs': blood_sugar_ppbs,
    'hiv': hiv,
    'hcv': hcv,
    'hbsag': hbsag,
    'sodium': sodium,
    'potassium': potassium,
    'phosphate': phosphate,
    'hco3': hco3,
    'conj': conj,
    'uniconj': uniconj,
    'alk_phosphatase': alk_phosphatase,
    'total_protein': total_protein,
    'albumin': albumin,
    'globulin': globulin,
    'vldl': vldl,
    'hdl': hdl,
    'speech': speech,
    'higher_function': higher_function,
    'motor_function': motor_function,
    'vertigo': vertigo,
    'reflexes': reflexes,
    'vibration_syndrome': vibration_syndrome,
    'conversational_hearing': conversational_hearing,
    'teeth_n_gum': teeth_n_gum,
    'spiro_remarks': spiro_remarks,
    'liver': liver,
    'speen': speen,
    'tenderness': tenderness,
    'any_other_abnormality': any_other_abnormality,
    'hernia_details': hernia_details,
    'hydrocele_details': hydrocele_details,
    'phimosis': phimosis,
    'piles': piles,
    'fistula': fistula,
    'xray_findings': xray_findings,
    'other_relevant_findings': other_relevant_findings,
    'remarks': remarks,
    'injury_remarks':injury_remarks,
    'comments': comments,
    'dlc_b': dlc_b,
    'drug_allergy': drug_allergy,
    'followup_to_opd': followup_to_opd,
    'followup': followup,
    'external_treatments': external_treatments,
    'dob': dob,
    'ans': ans,
    'employer_contractor': employer_contractor,
    'dept': dept,
    'designation': designation,
    'spo2': spo2,
    'cold_cough': cold_cough,
    'general_weakness': general_weakness,
    'smell': smell,
    'calcium': calcium,
    'st_line_walking': st_line_walking,
    'eac': eac,
    'near_with_right_eye': near_with_right_eye,
    'dis_with_right_eye': dis_with_right_eye,
    'dis_with_left_eye': dis_with_left_eye,
    'near_with_left_eye': near_with_left_eye,
    'color_vision': color_vision,
    'ln_v': ln_v,
    'ln_axis': ln_axis,
    'ln_dcyl': ln_dcyl,
    'ln_dsph': ln_dsph,
    'ld_v': ld_v,
    'ld_axis': ld_axis,
    'ld_dcyl': ld_dcyl,
    'ld_dsph': ld_dsph,
    'rn_v': rn_v,
    'rn_axis': rn_axis,
    'rn_dcyl': rn_dcyl,
    'rn_dsph': rn_dsph,
    'rd_v': rd_v,
    'rd_axis': rd_axis,
    'rd_dcyl': rd_dcyl,
    'rd_dsph': rd_dsph,
    'lair_250': lair_250,
    'lair_500': lair_500,
    'lair_1000': lair_1000,
    'lair_2000': lair_2000,
    'lair_4000': lair_4000,
    'lair_8000': lair_8000,
    'lbone_250': lbone_250,
    'lbone_500': lbone_500,
    'lbone_1000': lbone_1000,
    'lbone_2000': lbone_2000,
    'lbone_4000': lbone_4000,
    'lbone_8000': lbone_8000,
    'rair_250': rair_250,
    'rair_500': rair_500,
    'rair_1000': rair_1000,
    'rair_2000': rair_2000,
    'rair_4000': rair_4000,
    'rair_8000': rair_8000,
    'rbone_250': rbone_250,
    'rbone_500': rbone_500,
    'rbone_1000': rbone_1000,
    'rbone_2000': rbone_2000,
    'rbone_4000': rbone_4000,
    'rbone_8000': rbone_8000,
    'bn_findings': bn_findings,
    'a': a,
    'cy': cy,
    'i': i,
    'cl': cl,
    'e': e,
  };
}
