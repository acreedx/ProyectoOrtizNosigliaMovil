import 'package:proyecto_ortiz_nosiglia_movil/models/patient.dart';

class AppointmentDetail {
  int id;
  DateTime programed_date_time;
  DateTime programed_end_date_time;
  String specialty;
  String reason;
  String? note;
  String? patient_instruction;
  String? cancellation_reason;
  DateTime? cancellation_date;
  String status;
  int patient_id;
  int doctor_id;
  Patient patient;

  AppointmentDetail({
    required this.id,
    required this.programed_date_time,
    required this.programed_end_date_time,
    required this.specialty,
    required this.reason,
    this.note,
    this.patient_instruction,
    this.cancellation_reason,
    this.cancellation_date,
    required this.status,
    required this.patient_id,
    required this.doctor_id,
    required this.patient,
  });

  factory AppointmentDetail.fromJson(Map<String, dynamic> json) {
    Patient patientData = Patient.fromJson(json['patient']);
    return AppointmentDetail(
      id: int.parse(json['id'].toString())  ,
      programed_date_time: DateTime.parse(json['programed_date_time'] as String),
      programed_end_date_time: DateTime.parse(json['programed_end_date_time'] as String),
      specialty: json['specialty'] as String,
      reason: json['reason'] as String,
      note: json['note'] as String?,
      patient_instruction: json['patient_instruction'] as String?,
      cancellation_reason: json['cancellation_reason'] as String?,
      cancellation_date: json['cancellation_date'] != null
          ? DateTime.parse(json['cancellation_date'] as String)
          : null,
      status: json['status'] as String ,
      patient_id: int.parse(json['patient_id'].toString()),
      doctor_id: int.parse(json['doctor_id'].toString()),
      patient: patientData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'programed_date_time': programed_date_time.toIso8601String(),
      'programed_end_date_time': programed_end_date_time.toIso8601String(),
      'specialty': specialty,
      'reason': reason,
      'note': note,
      'patient_instruction': patient_instruction,
      'cancellation_reason': cancellation_reason,
      'cancellation_date': cancellation_date?.toIso8601String(),
      'status': status,
      'patient_id': patient_id,
      'doctor_id': doctor_id,
    };
  }
}