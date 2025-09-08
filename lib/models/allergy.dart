class Allergy {
  String id;
  String resourceType;
  String substance;
  String reaction;
  String severity;
  String? notes;
  bool active;
  String patientId;
  DateTime createdAt;
  DateTime updatedAt;

  Allergy({
    required this.id,
    required this.resourceType,
    required this.substance,
    required this.reaction,
    required this.severity,
    this.notes,
    required this.active,
    required this.patientId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Allergy.fromJson(Map<String, dynamic> json) {
    return Allergy(
      id: json['id'] as String,
      resourceType: json['resourceType'] as String,
      substance: json['substance'] as String,
      reaction: json['reaction'] as String,
      severity: json['severity'] as String,
      notes: json['notes'] as String?,
      active: json['active'] as bool,
      patientId: json['patientId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'resourceType': resourceType,
      'substance': substance,
      'reaction': reaction,
      'severity': severity,
      'notes': notes,
      'active': active,
      'patientId': patientId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}