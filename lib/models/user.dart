import 'package:proyecto_ortiz_nosiglia_movil/models/patient.dart';

class User {
  String id;
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
  Patient? patient;
  User({
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
    this.patient,
  });
}