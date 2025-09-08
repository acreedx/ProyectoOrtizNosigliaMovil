class Patient {
  int id;
  String identification;
  String first_name;
  String last_name;
  DateTime birth_date;
  String phone;
  String mobile;
  String email;
  String address_line;
  String address_city;
  String photo_url;
  String? allergies;
  String? preconditions;

  Patient({
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
    this.allergies,
    this.preconditions
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: int.parse(json['user']['id'].toString()),
      identification: json['user']['identification'] as String,
      first_name: json['user']['first_name'] as String,
      last_name: json['user']['last_name'] as String,
      birth_date: DateTime.parse(json['user']['birth_date'] as String),
      phone: json['user']['phone'] as String,
      mobile: json['user']['mobile'] as String,
      email: json['user']['email'] as String,
      address_line: json['user']['address_line'] as String,
      address_city: json['user']['address_city'] as String,
      photo_url: json['user']['photo_url'] as String,
      allergies: json['allergies'] as String?,
      preconditions: json['preconditions'] as String?,
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
      'allergies': allergies,
      'preconditions': preconditions,
    };
  }
}
