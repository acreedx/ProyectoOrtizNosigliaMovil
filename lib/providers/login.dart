import 'dart:convert';
import 'package:proyecto_ortiz_nosiglia_movil/config/consts.dart';
import 'package:http/http.dart' as http;

String MODULE_NAME = '/api/movil/login';

Future<String> login(String username, String password) async {
  Uri uri = Uri.https(BASE_URL, MODULE_NAME);

  var response = await http.post(
    uri,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  print('Respuesta del servidor: ${response.statusCode}');
  var res = jsonDecode(response.body);
  if (response.statusCode == 200) {
    print('Respuesta: ${res}');
    return res['access_token'];
  } else {
    print('Error: ${response.statusCode}');
    var error = res['error'] ?? 'Error desconocido';
    throw Exception(error);
  }
}
