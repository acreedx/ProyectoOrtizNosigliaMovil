import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointmentTestList.dart';
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
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return ListTile(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AppointmentDetailScreen(appointment: appointment),
              ),
            )
          },
          title: Text('Especialidad: ${appointment.specialty}'),
          subtitle: Text(
              'Motivo: ${appointment.reason} \nEstado: ${appointment.status}'),
          trailing: Text('Hora inicio: ${appointment.start}'),
        );
      },
    );
  }
}
