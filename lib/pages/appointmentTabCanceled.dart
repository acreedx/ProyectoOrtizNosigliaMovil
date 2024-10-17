import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/components/appointmentCard.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointmentTestList.dart';

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
