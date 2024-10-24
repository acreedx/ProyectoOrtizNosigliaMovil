import 'dart:convert';
import 'package:proyecto_ortiz_nosiglia_movil/config/consts.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_ortiz_nosiglia_movil/models/appointment.dart';
import 'package:proyecto_ortiz_nosiglia_movil/utils/JwtTokenHandler.dart';

String MODULE_NAME = '/api/movil/citas';

Future<String> getIdUser() async {
  var decodedToken = await getTokenInfo();
  var practitionerId = decodedToken['access_token']['id'];
  return practitionerId;
}
Future<List<Appointment>> getAppointments() async {
  Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/${await getIdUser()}');

  var response = await http.get(
    uri,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
  );

  var res = jsonDecode(response.body);
  if (response.statusCode == 200) {
    List<Appointment> appointments = (res['citas'] as List)
        .map((appointmentJson) => Appointment.fromJson(appointmentJson))
        .toList();
    return appointments;
  } else {
    var error = res['error'] ?? 'Error desconocido';
    throw Exception(error);
  }
}

Future<List<Appointment>> getPastAppointments() async {
  Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/${await getIdUser()}');

  var response = await http.get(
    uri,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
  );

  var res = jsonDecode(response.body);
  if (response.statusCode == 200) {
    List<Appointment> appointments = (res['citas'] as List)
        .map((appointmentJson) => Appointment.fromJson(appointmentJson))
        .toList();

    List<Appointment> pastAppointments = appointments.where((appointment) {
      return appointment.end.isBefore(DateTime.now());
    }).toList();

    return pastAppointments;
  } else {
    var error = res['error'] ?? 'Error desconocido';
    throw Exception(error);
  }
}
Future<List<Appointment>> getPendingAppointments() async {
  Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/${await getIdUser()}');

  var response = await http.get(
    uri,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
  );

  var res = jsonDecode(response.body);
  if (response.statusCode == 200) {
    List<Appointment> appointments = (res['citas'] as List)
        .map((appointmentJson) => Appointment.fromJson(appointmentJson))
        .toList();

    List<Appointment> pendingAppointments = appointments.where((appointment) {
      return appointment.end.isAfter(DateTime.now()) &&
          (appointment.status == 'creada' || appointment.status == 'confirmed');
    }).toList();

    return pendingAppointments;
  } else {
    var error = res['error'] ?? 'Error desconocido';
    throw Exception(error);
  }
}

Future<List<Appointment>> getCompletedAppointments() async {
  Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/${await getIdUser()}');

  var response = await http.get(
    uri,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
  );

  var res = jsonDecode(response.body);
  if (response.statusCode == 200) {
    List<Appointment> appointments = (res['citas'] as List)
        .map((appointmentJson) => Appointment.fromJson(appointmentJson))
        .toList();

    List<Appointment> pendingAppointments = appointments.where((appointment) {
      return appointment.end.isAfter(DateTime.now()) &&
          (appointment.status == 'completed');
    }).toList();

    return pendingAppointments;
  } else {
    var error = res['error'] ?? 'Error desconocido';
    throw Exception(error);
  }
}


Future<List<Appointment>> getCanceledAppointments() async {
  Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/${await getIdUser()}');

  var response = await http.get(
    uri,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
  );

  var res = jsonDecode(response.body);
  if (response.statusCode == 200) {
    List<Appointment> appointments = (res['citas'] as List)
        .map((appointmentJson) => Appointment.fromJson(appointmentJson))
        .toList();

    List<Appointment> pendingAppointments = appointments.where((appointment) {
      return appointment.end.isAfter(DateTime.now()) &&
          (appointment.status == 'canceled');
    }).toList();

    return pendingAppointments;
  } else {
    var error = res['error'] ?? 'Error desconocido';
    throw Exception(error);
  }
}

Future<Appointment?> getCurrentAppointment() async {
  Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/${await getIdUser()}');
  print(uri.toString());
  var response = await http.get(
    uri,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
  );

  var res = jsonDecode(response.body);
  if (response.statusCode == 200) {
    List<Appointment> appointments = (res['citas'] as List)
        .map((appointmentJson) => Appointment.fromJson(appointmentJson))
        .toList();
    DateTime now = DateTime.now().toUtc();
    List<Appointment> currentAppointments = appointments.where((appointment) {
      return appointment.start.toUtc().isBefore(now) && appointment.end.toUtc().isAfter(now);
    }).toList();

    if (currentAppointments.isNotEmpty) {
      return currentAppointments.first;
    } else {
      return null;
    }
  } else {
    var error = res['error'] ?? 'Error desconocido';
    throw Exception(error);
  }
}


Future<String> cancelAppointment(String idCita) async {
  Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/cancelar/$idCita');
  var response = await http.put(
    uri,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
  );
  var res = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return res['message'];
  } else {
    var error = res['error'] ?? 'Error desconocido';
    throw Exception(error);
  }
}

Future<String> completeAppointment(String idCita) async {
  Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/completar/$idCita');
  var response = await http.put(
    uri,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
  );
  var res = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return res.message.toString();
  } else {
    var error = res['error'] ?? 'Error desconocido';
    throw Exception(error);
  }
}
Future<String> confirmAppointment(String idCita) async {
  Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/confirmar/$idCita');
  var response = await http.put(
    uri,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
  );
  var res = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return res.message.toString();
  } else {
    var error = res['error'] ?? 'Error desconocido';
    throw Exception(error);
  }
}
