import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointment.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentDetail.dart';

class AppointmentListView extends StatefulWidget {
  const AppointmentListView({super.key});

  @override
  State<AppointmentListView> createState() => _AppointmentListViewState();
}

class _AppointmentListViewState extends State<AppointmentListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 0,
      itemBuilder: (context, index) {
        final appointment = new Appointment(id: 1, status: "", specialty: "specialty", reason: "reason", programed_date_time: new DateTime.now(), programed_end_date_time: new DateTime.now(), patient_id: 1, doctor_id: 1);
        return ListTile(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AppointmentDetailScreen(id_cita: appointment.id.toString(),),
              ),
            )
          },
          title: Text('Especialidad: ${appointment.specialty}'),
          subtitle: Text(
              'Motivo: ${appointment.reason} \nEstado: ${appointment.status}'),
          trailing: Text('Hora inicio: ${appointment.programed_date_time}'),
        );
      },
    );
  }
}
