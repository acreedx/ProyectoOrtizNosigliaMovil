import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_ortiz_nosiglia_movil/components/appointmentCard.dart';
import 'package:proyecto_ortiz_nosiglia_movil/components/dentistCard.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointment.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointmentTestList.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/dentist.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/citas.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/dentistas.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Inicio",
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.orange,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dentistas Destacados",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 46, 46, 46),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FutureBuilder<List<Dentist>>(
            future: getDentists(),
            builder: (BuildContext context, AsyncSnapshot<List<Dentist>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No se encontraron dentistas.'));
              } else {
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      height: 250,
                      width: 400,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final dentist = snapshot.data![index];
                          return DentistCard(
                            name: dentist.firstName + (dentist.secondName != null ? ' ${dentist.secondName}' : '') + ' ${dentist.familyName}',
                            specialty: 'Dentista',
                            imageUrl: "https://proyecto-ortiz-nosiglia-front-end-r7fs.vercel.app/${dentist.photoUrl}",
                        );
                      },
                    )
                  )
                );
              }
            },
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tu Cita Actual",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromARGB(255, 46, 46, 46),
                  ),
                ),
                const SizedBox(height: 20),
                FutureBuilder<Appointment?>(
                  future: getCurrentAppointment(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return const Text("No hay citas actuales.");
                    } else {
                      Appointment appointment = snapshot.data!;
                      return appointmentCard(
                        id: appointment.id,
                        confirmation: appointment.status,
                        mainText: "Paciente ${appointment.subject}",
                        subText: appointment.specialty,
                        date: "${appointment.start.day}/${appointment.start.month}/${appointment.start.year}",
                        time: "${appointment.start.hour}:${appointment.start.minute}",
                        image: "lib/icons/male-doctor.png",
                        status: appointment.status,
                      );
                    }
                  },
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
        ]),
      ),
    );
  }
}
