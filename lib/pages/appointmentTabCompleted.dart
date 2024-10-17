import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/components/appointmentCard.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointmentTestList.dart';

class AppointmentTabCompleted extends StatefulWidget {
  const AppointmentTabCompleted({super.key});

  @override
  State<AppointmentTabCompleted> createState() =>
      _AppointmentTabCompletedState();
}

class _AppointmentTabCompletedState extends State<AppointmentTabCompleted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: appointments.map((appointment) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  appointmentCard(
                    confirmation: appointment.status,
                    mainText: "Paciente ${appointment.subject}",
                    subText: appointment.specialty,
                    date:
                        "${appointment.start.day}/${appointment.start.month}/${appointment.start.year}",
                    time:
                        "${appointment.start.hour}:${appointment.start.minute}",
                    image: "lib/icons/male-doctor.png",
                  ),
                ],
              );
            }).toList(),
          ),
        ));
  }
}
