import 'dart:convert';
import 'package:proyecto_ortiz_nosiglia_movil/config/consts.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_ortiz_nosiglia_movil/models/dentist.dart';
String MODULE_NAME = '/api/movil/dentistas';

Future<List<Dentist>> getDentists() async {
  Uri uri = Uri.https(BASE_URL, MODULE_NAME);

  var response = await http.get(
    uri,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
  );

  var res = jsonDecode(utf8.decode(response.bodyBytes));
  if (response.statusCode == 200) {
    List<Dentist> dentists = (res['dentistas'] as List)
        .map((dentistJson) => Dentist.fromJson(dentistJson))
        .toList();
    print(res['dentistas']);
    return dentists;
  } else {
    var error = res['error'] ?? 'Error desconocido';
    throw Exception(error);
  }
}