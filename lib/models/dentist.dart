class Dentist {
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

  Dentist({
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
  });

  factory Dentist.fromJson(Map<String, dynamic> json) {
    return Dentist(
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
    };
  }
}
