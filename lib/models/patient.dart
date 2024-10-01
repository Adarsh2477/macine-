
import 'dart:convert';

import 'package:flutter/src/material/data_table.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ohctech/models/sickness.dart';
import 'package:ohctech/models/weight.dart';

import 'Appointment.dart';
import 'ChronicIllness.dart';
import 'bmi.dart';
import 'document.dart';
import 'fbs.dart';
import 'hartrate.dart';
import 'appointmentview.dart';
import 'checkupform.dart';
import 'medicine.dart';
// import 'package:ohctech/models/Appointment.dart';
// import 'package:ohctech/models/sickness.dart';
//
// import 'checkupform.dart';
// import 'medicine.dart';
class PatientModel {
  static List<Patient> patients = [];

  PatientModel(List<Patient> doctors) {
    PatientModel.patients = patients;
  }
}

class Patient {
  final String? division;
  final String? checkup_date;
  final String? emp_id;
  final String? primary_contact_person;
  final String? secondary_contact_person;
  final String? ohc_type_id;
  final String? secondary_contact_no;
  final String? age;
  final String? doj;
  final String? health_risks;
  final String? health_advices;
  final String? primary_contact_no;
  final String? status;
  final String? referral;
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
  final String? appointment_id;
  final int? medical_exam_id;
  final int? sickness_id;
  final String? patient_name;
  final String? gender;
  final String? emp_code;
  final String? ticket_no;
  final String? appointment_date;
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
  final dynamic? height;
  final dynamic? weight;
  final dynamic? bmi;
  final String? pulse;
  final dynamic? bp;
  final dynamic? bp_sbp;
  final dynamic? bp_dbp;
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
  final List<healthindex>? Healt_hindex;
  final List<Medicine>? medicines;
  final List<Appointment>? appointment;
  final List<Checkupform>? checkupform;
  final List<Sickness>? sickness;
  final List<Weight>? weight1;
  final List<Heart_rate>? pulse1;
  final List<Bmi>? bmi1;
  final List<Rbs>? rbs;
  final List<Fbs>? fbs;
  final List<Ppbs>? ppbs;
  final List<Previous_OPD>? PreviousOPD;
  final List<Previous_Injury>? Previousinj;
  final List<Previous_Sickness>? Previousic;
  final List<Previous_Medical>? Previousmed;
  final List<Illness>? illnes;
  final List<Hight>? hight;
  final List<document>? Document;
  final List<ChronicIllness>? chronicIllness;
  final List<appointmentview>? Appointmentview;
  final List<Previous_Emergency>? PreviousEmergency;
  final List<Training>? training;
  final List<BMIGRAFH>? bmigrafh;
  final List<Treatment_Reco>? TreatmentReco;
  final List<Health_Advices>? HealthAdvices;
  Patient({
    required this.Document,
    required this.checkup_date,
    required this.bmigrafh,
    required this.primary_contact_person,
    required this.secondary_contact_person,
    required this.Healt_hindex,
    required this.PreviousEmergency,
    required this.training,
    required this.TreatmentReco,
    required this.HealthAdvices,
    required this.PreviousOPD,
    required this.Previousinj,
    required this.Previousmed,
    required this.illnes,
    required this.Previousic,
    required this.hight,
    required this.ppbs,
    required this.rbs,
    required this.fbs,
    required this.bmi1,
    required this.emp_id,
    required this.secondary_contact_no,
    required this.pulse1,
    required this.weight1,
    required this.Appointmentview,
    required this.chronicIllness,
    required this.sickness,
    required this.referral,
    required this.checkupform,
    required this.appointment,
    required this.ohc_type_id,
    required this.age,
    required this.doj,
    required this.health_risks,
    required this.health_advices,
    required this.status,
    required this.primary_contact_no,
    required this.ps,
    required this.aadhar_no,
    required this.patient_cat_id,
    required this.medicines,
    required this.pending_opd_count,
    required this.pending_injury_count,
    required this.pending_medical_count,
    required this.pending_sickness_count,
    required this.approved_opd_count,
    required this.approved_injury_count,
    required this.approved_medical_count,
    required this.approved_sickness_count,
    required this.id,
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
    required this.appointment_date,
    required this.body_system,
    required this.complaints,
    required this.spo2_percent,
    required this.temperature,
    required this.diagnosis,
    required this.remarks_rece,
    required this.division,
    required this.examination_remarks,
    required this.injury_time,
    required this.injury_cause,
    required this.branch_area,
    required this.incident_location,
    required this.injury_procedure,
    required this.injury_parts_new,
    required this.injury_classes_new,
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
    this.bmi,
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
  });
  Map<String, dynamic> toMap() {
    return {
      'Document': Document?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'bmigrafh': bmigrafh?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'Healt_hindex': Healt_hindex?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'PreviousEmergency': PreviousEmergency?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'training': training?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'TreatmentReco': TreatmentReco?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'HealthAdvices': HealthAdvices?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'PreviousOPD': PreviousOPD?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'Previousinj': Previousinj?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'Previousic': Previousic?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'Previousmed': Previousmed?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'illnes': illnes?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'hight': hight?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'ppbs': ppbs?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'rbs': rbs?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'fbs': fbs?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'bmi1': bmi1?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'Appointmentview': Appointmentview?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'pulse1': pulse1?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'weight1': weight1?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'chronicIllness': chronicIllness?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'sickness': sickness?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'checkupform': checkupform?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'appointment': appointment?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'medicines': medicines?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
      'ohctypeid':ohc_type_id,
      'referral':referral,
      'age':age,
      'appointment_id':appointment_id,
      'doj': doj,
      'health_risks': health_risks,
      'health_advices': health_advices,
      'status': status,
      'primary_contact_no': primary_contact_no,
      'primary_contact_person': primary_contact_person,
      'secondary_contact_person': secondary_contact_person,
      'ps': ps,
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
      'item_id': item_id,
      'frequency_id': frequency_id,
      'for_days': for_days,
      'issued_qty': issued_qty,
      'item_qty': item_qty,
      'dosage': dosage,
      'division':division,
      'dosage_category_id': dosage_category_id,
      'timing_id': timing_id,
      'medical_exam_id': medical_exam_id,
      'sickness_id': sickness_id,
      'checkup_date':checkup_date,
      'patient_name': patient_name,
      'gender': gender,
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
      'secondary_contact_no':'secondary_contact_no',
      'date_rejoin':date_rejoin,
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
      'chest': chest,
      'emp_id':emp_id,
      'chest_in': chest_in,
      'chest_exp': chest_exp,
      'skin': skin,
      'musculo_skeletal': musculo_skeletal,
      'hb': hb,
      'tlc': tlc,
      'dlc_n': dlc_n,
      'dlc_l': dlc_l,
      'dlc_m': dlc_m,
      'dlc_e': dlc_e,
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
  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
        Document:map['document'] == null ? null : (map['document'] as List).map<document>((data)=> document.fromJson(data  as Map<String,dynamic>)).toList(),
        bmigrafh:map['BMIGRAFH'] == null ? null : (map['BMIGRAFH'] as List).map<BMIGRAFH>((data)=> BMIGRAFH.fromJson(data  as Map<String,dynamic>)).toList(),
        Healt_hindex:map['healthindex'] == null ? null : (map['healthindex'] as List).map<healthindex>((data)=> healthindex.fromJson(data  as Map<String,dynamic>)).toList(),
        PreviousEmergency:map['Previous_Emergency'] == null ? null : (map['Previous_Emergency'] as List).map<Previous_Emergency>((data)=> Previous_Emergency.fromJson(data  as Map<String,dynamic>)).toList(),
        training:map['Training'] == null ? null : (map['Training'] as List).map<Training>((data)=> Training.fromJson(data  as Map<String,dynamic>)).toList(),
        TreatmentReco:map['Treatment_Reco'] == null ? null : (map['Treatment_Reco'] as List).map<Treatment_Reco>((data)=> Treatment_Reco.fromJson(data  as Map<String,dynamic>)).toList(),
        HealthAdvices:map['Health_Advices'] == null ? null : (map['Health_Advices'] as List).map<Health_Advices>((data)=> Health_Advices.fromJson(data  as Map<String,dynamic>)).toList(),
        PreviousOPD:map['Previous_OPD'] == null ? null : (map['Previous_OPD'] as List).map<Previous_OPD>((data)=> Previous_OPD.fromJson(data  as Map<String,dynamic>)).toList(),
        Previousinj:map['Previous_Injury'] == null ? null : (map['Previous_Injury'] as List).map<Previous_Injury>((data)=> Previous_Injury.fromJson(data  as Map<String,dynamic>)).toList(),
        Previousic:map['Previous_Sickness'] == null ? null : (map['Previous_Sickness'] as List).map<Previous_Sickness>((data)=> Previous_Sickness.fromJson(data  as Map<String,dynamic>)).toList(),
        Previousmed:map['Previous_Medical'] == null ? null : (map['Previous_Medical'] as List).map<Previous_Medical>((data)=> Previous_Medical.fromJson(data  as Map<String,dynamic>)).toList(),
        illnes:map['Illness'] == null ? null : (map['Illness'] as List).map<Illness>((data)=> Illness.fromJson(data  as Map<String,dynamic>)).toList(),
        hight:map['Hight'] == null ? null : (map['Hight'] as List).map<Hight>((data)=> Hight.fromJson(data  as Map<String,dynamic>)).toList(),
        ppbs:map['Ppbs'] == null ? null : (map['Ppbs'] as List).map<Ppbs>((data)=> Ppbs.fromJson(data  as Map<String,dynamic>)).toList(),
        rbs:map['Rbs'] == null ? null : (map['Rbs'] as List).map<Rbs>((data)=> Rbs.fromJson(data  as Map<String,dynamic>)).toList(),
        fbs:map['Fbs'] == null ? null : (map['Fbs'] as List).map<Fbs>((data)=> Fbs.fromJson(data  as Map<String,dynamic>)).toList(),
        bmi1:map['Bmi'] == null ? null : (map['Bmi'] as List).map<Bmi>((data)=> Bmi.fromJson(data  as Map<String,dynamic>)).toList(),
        pulse1:map['Heart_rate'] == null ? null : (map['Heart_rate'] as List).map<Heart_rate>((data)=> Heart_rate.fromJson(data  as Map<String,dynamic>)).toList(),
        weight1:map['Weight'] == null ? null : (map['Weight'] as List).map<Weight>((data)=> Weight.fromJson(data  as Map<String,dynamic>)).toList(),
        Appointmentview:map['appointmentview'] == null ? null : (map['appointmentview'] as List).map<appointmentview>((data)=> appointmentview.fromJson(data  as Map<String,dynamic>)).toList(),
        chronicIllness:map['ChronicIllness'] == null ? null : (map['ChronicIllness'] as List).map<ChronicIllness>((data)=> ChronicIllness.fromJson(data  as Map<String,dynamic>)).toList(),
        sickness:map['Sickness'] == null ? null : (map['Sickness'] as List).map<Sickness>((data)=> Sickness.fromJson(data  as Map<String,dynamic>)).toList(),
        checkupform:map['checkups'] == null ? null : (map['checkups'] as List).map<Checkupform>((data)=> Checkupform.fromJson(data  as Map<String,dynamic>)).toList(),
        appointment:map['appointment'] == null ? null : (map['appointment'] as List).map<Appointment>((data)=> Appointment.fromJson(data  as Map<String,dynamic>)).toList(),
        medicines:map['medicines'] == null ? null : (map['medicines'] as List).map<Medicine>((data)=> Medicine.fromJson(data  as Map<String,dynamic>)).toList(),
        ohc_type_id:map['ohc_type_id'],
        age: map['age'],
        referral:map['referral'],
        doj: map['doj'],
        emp_id:map['emp_id'],
        appointment_id:map['appointment_id'],
        health_risks: map['health_risks'],
        health_advices: map['health_advices'],
        status: map['status'],
        primary_contact_no: map['primary_contact_no'],
        ps: map['ps'],
        aadhar_no: map['aadhar_no'],
        patient_cat_id: map['patient_cat_id'],
        pending_opd_count: map['count_opd'],
        pending_injury_count: map['count_injury'],
        pending_sickness_count: map['count_sickness'],
        pending_medical_count: map['count_medical'],
        approved_opd_count: map['count_opd_approved'],
        approved_injury_count: map['count_injury_approved'],
        approved_sickness_count: map['count_sickness_approved'],
        approved_medical_count: map['count_medical_approved'],
        id: map['id'],
        item_id: map['item_id'],
        primary_contact_person: map['primary_contact_person'],
        secondary_contact_person: map['secondary_contact_person'],
        frequency_id: map['frequency_id'],
        for_days: map['for_days'],
        item_qty: map['item_qty'],
        issued_qty: map['issued_qty'],
        dosage: map['dosage'],
        dosage_category_id: map['dosage_category_id'],
        timing_id: map['timing_id'],
        medical_exam_id: map['medical_exam_id'],
        sickness_id: map['sickness_id'],
        patient_name: map['patient_name'],
        gender: map['gender'],
        emp_code: map['emp_code'],
        ticket_no: map['ticket_no'],
        appointment_date: map['appointment_date'],
        body_system: map['ailment_system'],
        diagnosis: map['diagnosis'],
        complaints: map['complaints'],
        division:map['division'],
        temperature: map['temperature'],
        spo2_percent: map['spo2_percent'],
        remarks_rece: map['remarks_rece'],
        examination_remarks: map['examination_remarks'],
        injury_time: map['injury_time'],
        injury_cause: map['injury_cause'],
        branch_area: map['branch_area'],
        incident_location: map['incident_location'],
        injury_procedure: map['injury_procedure'],
        injury_parts_new: map['injury_parts_new'],
        injury_classes_new: map['injury_classes_new'],
        injury_types_new: map['injury_types_new'],
        sickness_name: map['sickness_name'],
        des: map['des'],
        sickness_date: map['sickness_date'],
        sickness_time: map['sickness_time'],
        approval_date: map['approval_date'],
        date_absent: map['date_absent'],
        date_absent_to: map['date_absent_to'],
        date_return: map['date_return'],
        fitness_status: map['fitness_status'],
        ailment_system: map['ailment_system'],
        ailment_name: map['ailment_name'],
        agency: map['agency'],
        medical_entry_date: map['medical_entry_date'],
        peme_no: map['peme_no'],
        height: map['height'],
        weight: map['weight'],
        date_rejoin:map['date_rejoin'],
        bmi: map['bmi'],
        pulse: map['pulse'],
        checkup_date:map['checkup_date'],
        bp: map['bp'],
        secondary_contact_no:map['secondary_contact_no'],
        bp_sbp: map['bp_sbp'],
        bp_dbp: map['bp_dbp'],
        s1: map['s1'],
        any_other_sound: map['any_other_sound'],
        ecg_findings: map['ecg_findings'],
        father_name: map['father_name'],
        designation_name: map['designation_name'],
        primary_phone: map['primary_phone'],
        email_id: map['email_id'],
        identi_mark: map['identi_mark'],
        village: map['village'],
        post: map['post'],
        tehsil: map['tehsil'],
        district: map['district'],
        state: map['state'],
        pin_code: map['pin_code'],
        chest: map['chest'],
        chest_in: map['chest_in'],
        chest_exp: map['chest_exp'],
        skin: map['skin'],
        musculo_skeletal: map['musculo_skeletal'],
        hb: map['hb'],
        tlc: map['tlc'],
        dlc_n: map['dlc_n'],
        dlc_l: map['dlc_l'],
        dlc_m: map['dlc_m'],
        dlc_e: map['dlc_e'],
        esr: map['esr'],
        blood_sugar_fbs: map['blood_sugar_fbs'],
        blood_sugar_rbs: map['blood_sugar_rbs'],
        uric_acid: map['uric_acid'],
        s_urea: map['s_urea'],
        s_creatinine: map['s_creatinine'],
        total_bilirubin: map['total_bilirubin'],
        sgop: map['sgop'],
        sgpt: map['sgpt'],
        total_cholestrol: map['total_cholestrol'],
        ldl: map['ldl'],
        triglycerides: map['triglycerides'],
        urine_re_me: map['urine_re_me'],
        urine_re_me_comments: map['urine_re_me_comments'],
        dis_without_right_eye: map['dis_without_right_eye'],
        dis_without_left_eye: map['dis_without_left_eye'],
        near_without_right_eye: map['near_without_right_eye'],
        near_without_left_eye: map['near_without_left_eye'],
        deformities: map['deformities'],
        cns: map['cns'],
        nose: map['nose'],
        throat: map['throat'],
        ear: map['ear'],
        audio_findings_left: map['audio_findings_left'],
        blood_sugar_ppbs: map['blood_sugar_ppbs'],
        hiv: map['hiv'],
        hcv: map['hcv'],
        hbsag: map['hbsag'],
        sodium: map['sodium'],
        potassium: map['potassium'],
        phosphate: map['phosphate'],
        hco3: map['hco3'],
        conj: map['conj'],
        uniconj: map['uniconj'],
        alk_phosphatase: map['alk_phosphatase'],
        total_protein: map['total_protein'],
        albumin: map['albumin'],
        globulin: map['globulin'],
        vldl: map['vldl'],
        hdl: map['hdl'],
        speech: map['speech'],
        higher_function: map['higher_function'],
        motor_function: map['motor_function'],
        vertigo: map['vertigo'],
        reflexes: map['reflexes'],
        vibration_syndrome: map['vibration_syndrome'],
        conversational_hearing: map['conversational_hearing'],
        teeth_n_gum: map['teeth_n_gum'],
        spiro_remarks: map['spiro_remarks'],
        liver: map['liver'],
        speen: map['speen'],
        tenderness: map['tenderness'],
        any_other_abnormality: map['any_other_abnormality'],
        hernia_details: map['hernia_details'],
        hydrocele_details: map['hydrocele_details'],
        phimosis: map['phimosis'],
        piles: map['piles'],
        fistula: map['fistula'],
        xray_findings: map['xray_findings'],
        other_relevant_findings: map['other_relevant_findings'],
        remarks: map['remarks'],
        comments: map['comments'],
        dlc_b: map['dlc_b'],
        drug_allergy: map['drug_allergy'],
        followup_to_opd: map['followup_to_opd'],
        followup: map['followup'],
        external_treatments: map['external_treatments'],
        dob: map['dob'],
        ans: map['ans'],
        employer_contractor: map['employer_contractor'],
        dept: map['dept'],
        designation: map['designation'],
        spo2: map['SpO2'],
        cold_cough: map['cold_cough'],
        general_weakness: map['general_weakness'],
        smell: map['smell'],
        calcium: map['calcium'],
        st_line_walking: map['st_line_walking'],
        eac: map['eac'],
        near_with_right_eye: map['near_with_right_eye'],
        dis_with_right_eye: map['dis_with_right_eye'],
        dis_with_left_eye: map['dis_with_left_eye'],
        near_with_left_eye: map['near_with_left_eye'],
        color_vision: map['color_vision'],
        ln_v: map['ln_v'],
        ln_axis: map['ln_axis'],
        ln_dcyl: map['ln_dcyl'],
        ln_dsph: map['ln_dsph'],
        ld_v: map['ld_v'],
        ld_axis: map['ld_axis'],
        ld_dcyl: map['ld_dcyl'],
        ld_dsph: map['ld_dsph'],
        rn_v: map['rn_v'],
        rn_axis: map['rn_axis'],
        rn_dcyl: map['rn_dcyl'],
        rn_dsph: map['rn_dsph'],
        rd_v: map['rd_v'],
        rd_axis: map['rd_axis'],
        rd_dcyl: map['rd_dcyl'],
        rd_dsph: map['rd_dsph'],
        lair_250: map['lair_250'],
        lair_500: map['lair_500'],
        lair_1000: map['lair_1000'],
        lair_2000: map['lair_2000'],
        lair_4000: map['lair_4000'],
        lair_8000: map['lair_8000'],
        lbone_250: map['lbone_250'],
        lbone_500: map['lbone_500'],
        lbone_1000: map['lbone_1000'],
        lbone_2000: map['lbone_2000'],
        lbone_4000: map['lbone_4000'],
        lbone_8000: map['lbone_8000'],
        rair_250: map['rair_250'],
        rair_500: map['rair_500'],
        rair_1000: map['rair_1000'],
        rair_2000: map['rair_2000'],
        rair_4000: map['rair_4000'],
        rair_8000: map['rair_8000'],
        rbone_250: map['rbone_250'],
        rbone_500: map['rbone_500'],
        rbone_1000: map['rbone_1000'],
        rbone_2000: map['rbone_2000'],
        rbone_4000: map['rbone_4000'],
        rbone_8000: map['rbone_8000'],
        bn_findings: map['bn_findings'],
        a: map['a'],
        cy: map['cy'],
        i: map['i'],
        cl: map['cl'],
        e: map['e']);
  }

  String toJson() => json.encode(toMap());

  factory Patient.fromJson(String source) =>
      Patient.fromMap(json.decode(source));
}
