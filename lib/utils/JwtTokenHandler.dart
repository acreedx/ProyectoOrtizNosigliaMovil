
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
final storage = FlutterSecureStorage();

Future<void> storeToken(String token) async {
  await storage.write(key: 'access_token', value: token);
}

Future<String?> getToken() async {
  return await storage.read(key: 'access_token');
}

bool isTokenExpired(String token) {
  return JwtDecoder.isExpired(token);
}
Future<bool> isUserLogged() async {
  try {
    var token = await getToken();
    if(token == null) {
      return false;
    }
    if(isTokenExpired(token)) {
      return false;
    }
    return true;
  } catch (e) {
    print('Error al verificar el estado del usuario: $e');
    return false;
  }
}

Future<Map<String, dynamic>> getTokenInfo() async {
  var token = await getToken();
  if(token == null) {
    return {};
  }
  var decodedToken = JwtDecoder.decode(token);
  return decodedToken;
}

Future<bool> signOut() async {
  try {
    await storage.delete(key: 'access_token');
    return true;
  }catch(e) {
    print(e);
    return false;
  }
}