import 'package:proyecto_ortiz_nosiglia_movil/models/allergy.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/person.dart';

final defaultPerson = Person(
  id: '1',
  firstName: 'Jhon',
  secondName: 'Doe',
  familyName: 'Smith',
  gender: 'Masculino',
  birthDate: DateTime(2010, 10, 10), // 14 años desde el 2024
  phone: '73744202',
  mobile: '71234567',
  email: 'jhon.doe@example.com',
  addressLine: '123 Calle Falsa',
  addressCity: 'Ciudad Ejemplo',
  maritalStatus: 'Soltero',
  identification: '12345678',
  photoUrl: 'https://example.com/photo.jpg',
  allergies: [
    Allergy(
      id: '1',
      substance: 'Polen',
      reaction: 'Estornudos',
      severity: 'Leve',
      notes: 'Alergia estacional.',
    ),
    Allergy(
      id: '2',
      substance: 'Nuez',
      reaction: 'Urticaria',
      severity: 'Moderada',
      notes: 'Evitar el consumo.',
    ),
  ],
);
