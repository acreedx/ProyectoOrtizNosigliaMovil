import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/components/appointmentCard.dart';

class AppointmentTabCompleted extends StatelessWidget {
  const AppointmentTabCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            appointmentCard(
              confirmation: "Confirmed",
              mainText: "Dr. Marcus Horizon",
              subText: "Chardiologist",
              date: "26/06/2022",
              time: "10:30 AM",
              image: "lib/icons/male-doctor.png",
            ),
            SizedBox(
              height: 10,
            ),
            appointmentCard(
              confirmation: "Confirmed",
              mainText: "Dr. Marcus Horizon",
              subText: "Chardiologist",
              date: "26/06/2022",
              time: "2:00 PM",
              image: "lib/icons/female-doctor2.png",
            ),
            SizedBox(
              height: 10,
            ),
            appointmentCard(
              confirmation: "Confirmed",
              mainText: "Dr. Marcus Horizon",
              subText: "Chardiologist",
              date: "26/06/2022",
              time: "2:00 PM",
              image: "lib/icons/female-doctor2.png",
            ),
            SizedBox(
              height: 10,
            ),
            appointmentCard(
              confirmation: "Confirmed",
              mainText: "Dr. Marcus Horizon",
              subText: "Chardiologist",
              date: "26/06/2022",
              time: "2:00 PM",
              image: "lib/icons/female-doctor2.png",
            )
          ]),
        ));
  }
}
