import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointment.dart';

class AppointmentDetailScreen extends StatefulWidget {
  final Appointment appointment; // Recibe una cita

  const AppointmentDetailScreen({super.key, required this.appointment});

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // Obtener la cita del widget
    final appointment = widget.appointment;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Specialty'),
              subtitle: Text(appointment.specialty),
            ),
            ListTile(
              title: const Text('Reason'),
              subtitle: Text(appointment.reason),
            ),
            ListTile(
              title: const Text('Status'),
              subtitle: Text(appointment.status),
            ),
            ListTile(
              title: const Text('Start Time'),
              subtitle: Text(appointment.start.toString()),
            ),
            ListTile(
              title: const Text('End Time'),
              subtitle: Text(appointment.end.toString()),
            ),
            if (appointment.cancellationReason != null)
              ListTile(
                title: const Text('Cancellation Reason'),
                subtitle: Text(appointment.cancellationReason!),
              ),
            ListTile(
              title: const Text('Account'),
              subtitle: Text(appointment.account),
            ),
            if (appointment.note != null)
              ListTile(
                title: const Text('Note'),
                subtitle: Text(appointment.note!),
              ),
            if (appointment.patientInstruction != null)
              ListTile(
                title: const Text('Patient Instructions'),
                subtitle: Text(appointment.patientInstruction!),
              ),
            ListTile(
              title: const Text('Subject'),
              subtitle: Text(appointment.subject),
            ),
            ListTile(
              title: const Text('Created At'),
              subtitle: Text(appointment.createdAt.toString()),
            ),
            ListTile(
              title: const Text('Updated At'),
              subtitle: Text(appointment.updatedAt.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
