import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/components/appointmentCard.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointment.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointmentTestList.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/citas.dart';

class AppointmentTabCanceled extends StatefulWidget {
  const AppointmentTabCanceled({super.key});

  @override
  State<AppointmentTabCanceled> createState() => _AppointmentTabCanceledState();
}

class _AppointmentTabCanceledState extends State<AppointmentTabCanceled> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<List<Appointment>>(
          future: getCanceledAppointments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final appointments = snapshot.data!;
              if (appointments.isEmpty) {
                return const Center(child: Text('No hay citas canceladas'));
              }

              return ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      appointmentCard(
                        id: appointment.id,
                        confirmation: appointment.status,
                        mainText: "Paciente Juan Perez Mendoza",
                        subText: appointment.specialty,
                        date:
                        "${appointment.start.day}/${appointment.start.month}/${appointment.start.year}",
                        time:
                        "${appointment.start.hour}:${appointment.start.minute}",
                        image: "lib/icons/male-doctor.png",
                        status: appointment.status,
                      ),
                    ],
                  );
                },
              );
            } else {
              return const Center(child: Text('No se encontraron citas'));
            }
          },
        ),);
  }
}
