import 'package:proyecto_ortiz_nosiglia_movil/models/patient.dart';

class Person {
  String id;
  String firstName;
  String? secondName;
  String familyName;
  String gender;
  DateTime birthDate;
  String? phone;
  String? mobile;
  String email;
  String addressLine;
  String addressCity;
  String maritalStatus;
  String identification;
  String photoUrl;
  List<Allergy> allergies;

  Person({
    required this.id,
    required this.firstName,
    this.secondName,
    required this.familyName,
    required this.gender,
    required this.birthDate,
    this.phone,
    this.mobile,
    required this.email,
    required this.addressLine,
    required this.addressCity,
    required this.maritalStatus,
    required this.identification,
    required this.photoUrl,
    required this.allergies,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['_id'] as String,
      firstName: json['firstName'] as String,
      secondName: json['secondName'] as String?,
      familyName: json['familyName'] as String,
      gender: json['gender'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      phone: json['phone'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String,
      addressLine: json['addressLine'] as String,
      addressCity: json['addressCity'] as String,
      maritalStatus: json['maritalStatus'] as String,
      identification: json['identification'] as String,
      photoUrl: json['photoUrl'] as String,
      allergies: (json['allergies'] as List)
          .map((allergy) => Allergy.fromJson(allergy))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'secondName': secondName,
      'familyName': familyName,
      'gender': gender,
      'birthDate': birthDate.toIso8601String(),
      'phone': phone,
      'mobile': mobile,
      'email': email,
      'addressLine': addressLine,
      'addressCity': addressCity,
      'maritalStatus': maritalStatus,
      'identification': identification,
      'photoUrl': photoUrl,
      'allergies': allergies.map((allergy) => allergy.toJson()).toList(),
    };
  }
}