class Allergy {
  final String id;
  final String substance;
  final String reaction;
  final String severity;
  final String? notes;
  Allergy({
    required this.id,
    required this.substance,
    required this.reaction,
    required this.severity,
    this.notes,
  });
  factory Allergy.fromJson(Map<String, dynamic> json) {
    return Allergy(
      id: json['_id'] as String,
      substance: json['substance'] as String,
      reaction: json['reaction'] as String,
      severity: json['severity'] as String,
      notes: json['notes'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'substance': substance,
      'reaction': reaction,
      'severity': severity,
      'notes': notes,
    };
  }
}


