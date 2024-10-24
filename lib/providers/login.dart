import 'dart:convert';
import 'package:proyecto_ortiz_nosiglia_movil/config/consts.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_ortiz_nosiglia_movil/utils/JwtTokenHandler.dart';

String MODULE_NAME = '/api/movil/login';

Future<String> login(String username, String password) async {
  Uri uri = Uri.https(BASE_URL, MODULE_NAME);

  var response = await http.post(
    uri,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  var res = jsonDecode(response.body);
  if (response.statusCode == 200) {
    var token = res['access_token'];
    await storeToken(token);
    return res['access_token'];
  } else {
    var error = res['error'] ?? 'Error desconocido';
    throw Exception(error);
  }
}

//var tokenInfo = await getTokenInfo(token);
//var username = tokenInfo['access_token']['username'];

//Navigator.pushReplacement(
//  context,
//  PageTransition(
//      type: PageTransitionType.fade,
//      child: const MenuScreen()));
