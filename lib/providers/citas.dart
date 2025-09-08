import 'dart:convert';
import 'package:proyecto_ortiz_nosiglia_movil/config/consts.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_ortiz_nosiglia_movil/models/appointment.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointmentDetail.dart';
import 'package:proyecto_ortiz_nosiglia_movil/utils/DateTimeFormater.dart';
import 'package:proyecto_ortiz_nosiglia_movil/utils/JwtTokenHandler.dart';

String MODULE_NAME = '/api/movil/citas';

Future<int> getIdUser() async {
  var decodedToken = await getTokenInfo();
  var practitionerId = int.parse(decodedToken['access_token']['id'].toString());
  return practitionerId;
}
Future<List<Appointment>> getAppointments() async {
  int id = await getIdUser();
  Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/$id');

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

Future<List<AppointmentDetail>> getPastAppointments() async {
  Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/historial/${await getIdUser()}');
  var response = await http.get(
    uri,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
  );
  var res = jsonDecode(response.body);
  if (response.statusCode == 200) {
    List<AppointmentDetail> appointments = (res['citas'] as List)
        .map((appointmentJson) => AppointmentDetail.fromJson(appointmentJson))
        .toList();
    return appointments;
  } else {
    var error = res['error'] ?? 'Error desconocido';
    throw Exception(error);
  }
}

Future<List<AppointmentDetail>> getPendingAppointments() async {
  Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/pendientes/${await getIdUser()}');
  var response = await http.get(
    uri,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
  );
  var res = jsonDecode(response.body);
  if (response.statusCode == 200) {
    List<AppointmentDetail> appointments = (res['citas'] as List)
        .map((appointmentJson) => AppointmentDetail.fromJson(appointmentJson))
        .toList();
    return appointments;
  } else {
    var error = res['error'] ?? 'Error desconocido';
    throw Exception(error);
  }
}

Future<List<AppointmentDetail>> getCompletedAppointments() async {
  Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/confirmadas/${await getIdUser()}');
  var response = await http.get(
    uri,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
  );
  var res = jsonDecode(response.body);
  if (response.statusCode == 200) {
    List<AppointmentDetail> appointments = (res['citas'] as List)
        .map((appointmentJson) => AppointmentDetail.fromJson(appointmentJson))
        .toList();
    return appointments;
  } else {
    var error = res['error'] ?? 'Error desconocido';
    throw Exception(error);
  }
}

Future<List<AppointmentDetail>> getCanceledAppointments() async {
  Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/canceladas/${await getIdUser()}');
  var response = await http.get(
    uri,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
  );
  var res = jsonDecode(response.body);
  print(res);
  if (response.statusCode == 200) {
    List<AppointmentDetail> appointments = (res['citas'] as List)
        .map((appointmentJson) => AppointmentDetail.fromJson(appointmentJson))
        .toList();
    return appointments;
  } else {
    var error = res['error'] ?? 'Error desconocido';
    throw Exception(error);
  }
}

Future<AppointmentDetail?> getCurrentAppointment() async {
  Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/actual/${await getIdUser()}');
  var response = await http.get(
    uri,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
  );
  var res = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (res['cita'] != null) {
      return AppointmentDetail.fromJson(res['cita']);
    } else {
      return null;
    }
  } else {
    var error = res['message'] ?? 'Error desconocido';
    throw Exception(error);
  }
}

Future<AppointmentDetail?> getAppointmentInfo(String id_cita) async {
  print(id_cita);
  Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/buscar/$id_cita');
  var response = await http.get(
    uri,
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
    },
  );
  var res = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (res['cita'] != null) {
      return AppointmentDetail.fromJson(res['cita']);
    } else {
      return null;
    }
  } else {
    var error = res['message'] ?? 'Error desconocido';
    throw Exception(error);
  }
}

Future<String> cancelAppointment(String idCita, String motivo) async {
  final body = json.encode({
    'cancellation_reason': motivo,
  });
  print(idCita);
  print(body);
  Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/cancelar/$idCita');
  var response = await http.post(
    uri,
    headers: {
      'Content-Type': 'application/json',
    },
    body: body,
  );
  var res = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return res['message'];
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
    return res['message'];
  } else {
    var error = res['error'] ?? 'Error desconocido';
    throw Exception(error);
  }
}

Future<String> markAppointmentAsMissed(String idCita) async {
  Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/marcarnoasistida/$idCita');
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

Future<String> completeAppointment(String idCita, String diagnostico) async {
  print("Numero de cita");
  print(idCita);
  print("Diagnostico");
  print(diagnostico);
  if (idCita.isEmpty || diagnostico.isEmpty) {
    throw Exception('El ID de la cita y el diagnóstico no pueden estar vacíos.');
  }

  try {
    Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/completar/$idCita/$diagnostico');
    var response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      return res['message'].toString();
    } else {
      var res = jsonDecode(response.body);
      var error = res['error'] ?? 'Error desconocido';
      throw Exception(error);
    }
  } catch (error) {
    throw Exception(error);
  }
}

Future<String> crearCita(DateTime programed_date_time, String hora_cita, String specialty,  String reason, String? note, String? patient_instruction, int patient_id) async {
  try {
    final doctor_id = await getIdUser();
    final body = json.encode({
      'programed_date_time': formatDateISO(programed_date_time),
      'hora_cita': hora_cita,
      'specialty': specialty,
      'reason': reason,
      'note': note,
      'patient_instruction': patient_instruction,
      'patient_id': patient_id,
      'doctor_id': doctor_id,
    });
    print(body);
    Uri uri = Uri.https(BASE_URL, '$MODULE_NAME/crear');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['message'];
    } else {
      final errorData = json.decode(response.body);
      throw Exception(errorData['error']);
    }
  } catch (error) {
    throw Exception(error);
  }
}