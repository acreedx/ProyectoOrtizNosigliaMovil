import 'dart:convert';
import 'package:proyecto_ortiz_nosiglia_movil/config/consts.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_ortiz_nosiglia_movil/models/dentist.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/person.dart';

String MODULE_NAME = '/api/movil/pacientes';

Future<List<Person>> getPersons() async {
  Uri uri = Uri.https(BASE_URL, MODULE_NAME);

  var response = await http.get(
    uri,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
  );

  var res = jsonDecode(response.body);
  if (response.statusCode == 200) {
    List<Person> persons = (res['pacientes'] as List)
        .map((personJson) => Person.fromJson(personJson))
        .toList();
    print(persons);
    return persons;
  } else {
    var error = res['error'] ?? 'Error desconocido';
    throw Exception(error);
  }
}