class PatientHistoryDetail {
  int id;
  String identification;
  String first_name;
  String last_name;
  DateTime birth_date;
  String? phone;
  String? mobile;
  String email;
  String address_line;
  String address_city;
  String photo_url;
  String? allergies;
  String? preconditions;
  String? organization;
  EmergencyContact? emergencyContact;
  List<Encounter> encounters;

  PatientHistoryDetail({
    required this.id,
    required this.identification,
    required this.first_name,
    required this.last_name,
    required this.birth_date,
    required this.phone,
    required this.mobile,
    required this.email,
    required this.address_line,
    required this.address_city,
    required this.photo_url,
    required this.encounters,
    this.allergies,
    this.preconditions,
    this.organization,
    this.emergencyContact
  });

  factory PatientHistoryDetail.fromJson(Map<String, dynamic> json) {
    final emergencyContactJson = json['patient']['emergency_contact'];
    EmergencyContact? emergencyContactData = emergencyContactJson != null
        ? EmergencyContact.fromJson(emergencyContactJson)
        : null;
    return PatientHistoryDetail(
      id: int.parse(json['id'].toString()),
      identification: json['identification'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      birth_date: DateTime.parse(json['birth_date'] as String),
      phone: json['phone'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String,
      address_line: json['address_line'] as String,
      address_city: json['address_city'] as String,
      photo_url: json['photo_url'] as String,
      allergies: json['patient']['allergies'] as String?,
      preconditions: json['patient']['preconditions'] as String?,
      organization: json['patient']['organization']?['name'] as String?,
      encounters: (json['patient']['encounter'] as List)
        .map((encounter) => Encounter.fromJson(encounter))
        .toList(),
      emergencyContact: emergencyContactData
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'identification': identification,
      'first_name': first_name,
      'last_name': last_name,
      'birth_date': birth_date.toIso8601String(),
      'phone': phone,
      'mobile': mobile,
      'email': email,
      'address_line': address_line,
      'address_city': address_city,
      'photo_url': photo_url,
      'encounters': encounters.map((encounter) => encounter.toJson()).toList(),
    };
  }
}
class EmergencyContact {
  int id;
  String name;
  String relation;
  String phone;
  String mobile;
  String address_line;
  String address_city;

  EmergencyContact({
    required this.id,
    required this.relation,
    required this.name,
    required this.phone,
    required this.mobile,
    required this.address_line,
    required this.address_city,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      id: int.parse(json['id'].toString()),
      relation: json['relation'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      mobile: json['mobile'] as String,
      address_line: json['address_line'] as String,
      address_city: json['address_city'] as String,
    );
  }
}

class Encounter {
  int id;
  String type;
  DateTime performed_on;
  String specialty;
  String reason;
  String diagnosis;

  Encounter({
    required this.id,
    required this.type,
    required this.performed_on,
    required this.specialty,
    required this.reason,
    required this.diagnosis,
  });

  factory Encounter.fromJson(Map<String, dynamic> json) {
    return Encounter(
      id: int.parse(json['id'].toString()),
      type: json['type'] as String,
      performed_on: DateTime.parse(json['performed_on'] as String),
      specialty: json['specialty'] as String,
      reason: json['reason'] as String,
      diagnosis: json['diagnosis'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'performed_on': performed_on.toIso8601String(),
      'specialty': specialty,
      'reason': reason,
      'diagnosis': diagnosis,
    };
  }
}
