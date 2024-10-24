class Appointment {
  String id;
  String resourceType;
  String status;
  String? cancellationReason;
  String specialty;
  String reason;
  String? description;
  String? previousAppointment;
  String? originatingAppointment;
  DateTime start;
  DateTime end;
  String? account;
  DateTime? cancellationDate;
  String? note;
  String? patientInstruction;
  String subject;

  Appointment({
    required this.id,
    required this.resourceType,
    required this.status,
    this.cancellationReason,
    required this.specialty,
    required this.reason,
    this.description,
    this.previousAppointment,
    this.originatingAppointment,
    required this.start,
    required this.end,
    this.account,
    this.cancellationDate,
    this.note,
    this.patientInstruction,
    required this.subject,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as String,
      resourceType: json['resourceType'] as String,
      status: json['status'] as String,
      cancellationReason: json['cancellationReason'] as String?,
      specialty: json['specialty'] as String,
      reason: json['reason'] as String,
      description: json['description'] as String?,
      previousAppointment: json['previousAppointment'] as String?,
      originatingAppointment: json['originatingAppointment'] as String?,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      account: json['account'] as String?,
      cancellationDate: json['cancellationDate'] != null
          ? DateTime.parse(json['cancellationDate'] as String)
          : null,
      note: json['note'] as String?,
      patientInstruction: json['patientInstruction'] as String?,
      subject: json['subject'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'resourceType': resourceType,
      'status': status,
      'cancellationReason': cancellationReason,
      'specialty': specialty,
      'reason': reason,
      'description': description,
      'previousAppointment': previousAppointment,
      'originatingAppointment': originatingAppointment,
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
      'account': account,
      'cancellationDate': cancellationDate?.toIso8601String(),
      'note': note,
      'patientInstruction': patientInstruction,
      'subject': subject,
    };
  }
}
