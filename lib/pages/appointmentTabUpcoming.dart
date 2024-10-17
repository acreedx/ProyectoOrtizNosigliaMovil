import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/components/appointmentCard.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointmentTestList.dart';

class AppointmentTabUpcoming extends StatefulWidget {
  const AppointmentTabUpcoming({super.key});

  @override
  State<AppointmentTabUpcoming> createState() => _AppointmentTabUpcomingState();
}

class _AppointmentTabUpcomingState extends State<AppointmentTabUpcoming> {
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
                  time: "${appointment.start.hour}:${appointment.start.minute}",
                  image: "lib/icons/male-doctor.png",
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
