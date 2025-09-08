import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/enums/appointmentStatus.dart';

String appointmentStatusFormatter(String appointmentStatus) {
  String estado;
  switch(appointmentStatus) {
    case AppointmentStatus.STATUS_PENDIENTE:
      estado = "Pendiente";
      break;
    case AppointmentStatus.STATUS_CONFIRMADA:
      estado = "Confirmada";
      break;
    case AppointmentStatus.STATUS_CANCELADA:
      estado = "Cancelada";
      break;
    case AppointmentStatus.STATUS_COMPLETADA:
      estado = "Completada";
      break;
    case AppointmentStatus.STATUS_NO_ASISTIDA:
      estado = "No asistida";
      break;
    default:
      estado = "-";
      break;
  }
  return estado;
}

final Map<String, Color> statusColorMap = {
  AppointmentStatus.STATUS_CANCELADA: Colors.red,
  AppointmentStatus.STATUS_COMPLETADA: Colors.green,
  AppointmentStatus.STATUS_CONFIRMADA: Colors.blue,
  AppointmentStatus.STATUS_NO_ASISTIDA: Colors.grey,
  AppointmentStatus.STATUS_PENDIENTE: Colors.orange,
};