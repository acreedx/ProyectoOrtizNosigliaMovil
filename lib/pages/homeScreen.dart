import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_ortiz_nosiglia_movil/components/appointmentCard.dart';
import 'package:proyecto_ortiz_nosiglia_movil/components/dentistCard.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointmentDetail.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/dentist.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/citas.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/dentistas.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<AppointmentDetail?> _futureActualAppointment;

  @override
  void initState() {
    super.initState();
    _futureActualAppointment = getCurrentAppointment();
  }
  void _actualizarDatos() {
    setState(() {
      _futureActualAppointment = getCurrentAppointment();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Inicio",
          style: GoogleFonts.poppins(color: Colors.orange, fontSize: 18.sp),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 60,
        backgroundColor: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(children: [
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
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No se encontraron dentistas.'));
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
                          return DentistCard(dentista: dentist,
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
                FutureBuilder<AppointmentDetail?>(
                  future: _futureActualAppointment,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return const Text("No hay citas actuales.");
                    } else {
                      if(snapshot.data != null) {
                        AppointmentDetail appointment = snapshot.data!;
                        return appointmentCard(
                          appointment: appointment,
                          onRegistroCreado: _actualizarDatos,
                        );
                      } else {
                        return const Text("No hay citas actuales.");
                      }
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
