import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyecto_ortiz_nosiglia_movil/components/dentistCard.dart';

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
              "Bienvenido al Centro Odontológico Ortiz Nosiglia",
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.orange,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          // Sección de dentistas destacados
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: 250,
              width: 400,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: const [
                  DentistCard(
                    name: "Dr. Juan Pérez",
                    specialty: "Ortodoncia",
                    imageUrl:
                        "https://odontologiaespecializadasevilla.com/wp-content/uploads/2018/07/dentista-sevilla.jpg",
                  ),
                  DentistCard(
                    name: "Dra. Ana Martínez",
                    specialty: "Endodoncia",
                    imageUrl:
                        "https://odontologiaespecializadasevilla.com/wp-content/uploads/2018/07/dentista-sevilla.jpg",
                  ),
                  DentistCard(
                    name: "Dra. Ana Martínez",
                    specialty: "Cirugía dental",
                    imageUrl:
                        "https://odontologiaespecializadasevilla.com/wp-content/uploads/2018/07/dentista-sevilla.jpg",
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Sección de artículos de salud dental
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const Placeholder(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Bordes redondeados
                    ),
                  ),
                  child: Text(
                    "Ver Cita",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.white, // Color del texto
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ]),
      ),
    );
  }
}
