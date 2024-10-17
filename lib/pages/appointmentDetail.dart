import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/allergy.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointment.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/personTestList.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentComplete.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/profileScreen.dart';
import 'package:proyecto_ortiz_nosiglia_movil/utils/DateTimeFormater.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          'Detalles de la cita',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Tarjeta de información de la cita
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildTitle('Información de la cita'),
                      const SizedBox(height: 8), // Espaciador
                      _buildDetailTile('Especialidad', appointment.specialty),
                      _buildDetailTile('Razón', appointment.reason),
                      _buildDetailTile('Estado', appointment.status),
                      _buildDetailTile(
                          'Hora inicio', formatTime(appointment.start)),
                      _buildDetailTile('Hora fin', formatTime(appointment.end)),
                      if (appointment.note != null)
                        _buildDetailTile('Notas', appointment.note!),
                      if (appointment.patientInstruction != null)
                        _buildDetailTile('Instrucciones del paciente',
                            appointment.patientInstruction!),
                      _buildDetailTile('Paciente', appointment.subject),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Alineación izquierda
                    children: [
                      _buildTitle('Información del Paciente'),
                      const SizedBox(height: 8), // Espaciador
                      _buildDetailTile('Nombre',
                          '${defaultPerson.firstName} ${defaultPerson.secondName ?? ''} ${defaultPerson.familyName}'),
                      _buildDetailTile(
                          'Edad', calculateAge(defaultPerson.birthDate)),
                      _buildDetailTile(
                          'Teléfono', defaultPerson.phone ?? 'No disponible'),
                      _buildDetailTile(
                          'Móvil', defaultPerson.mobile ?? 'No disponible'),
                      _buildDetailTile('Email', defaultPerson.email),
                      _buildDetailTile('Dirección',
                          '${defaultPerson.addressLine}, ${defaultPerson.addressCity}'),
                      _buildDetailTile(
                          'Estado Civil', defaultPerson.maritalStatus),
                      _buildDetailTile(
                          'Identificación', defaultPerson.identification),
                      _buildDetailTile(
                          'Foto',
                          defaultPerson.photoUrl.isNotEmpty
                              ? 'Disponible'
                              : 'No disponible'),
                      const SizedBox(height: 8), // Espaciador
                      _buildTitle('Alergias'),
                      const SizedBox(height: 4), // Espaciador
                      ...defaultPerson.allergies
                          .map((allergy) => _buildAllergyTile(allergy))
                          .toList(),
                      const SizedBox(height: 4),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.25,
                            30,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const AppointmentCompleteScreen(),
                              inheritTheme: true,
                              ctx: context,
                              duration: const Duration(),
                            ),
                          );
                        },
                        child: Text(
                          "Completar",
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 252, 252, 252),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildAllergyTile(Allergy allergy) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: Colors.orange[50],
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: ListTile(
      title: Text(allergy.substance,
          style: TextStyle(color: Colors.orange, fontSize: 14.sp)),
      subtitle: Text(
        'Reacción: ${allergy.reaction}\nSeveridad: ${allergy.severity}\nNotas: ${allergy.notes ?? 'N/A'}',
        style: TextStyle(fontSize: 13.sp),
      ),
    ),
  );
}

Widget _buildTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: Colors.orange,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
  );
}

Widget _buildDetailTile(String title, String subtitle) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 2),
    decoration: BoxDecoration(
      color: Colors.orange[50],
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: ListTile(
        dense: true,
        title: Text(title,
            style: TextStyle(color: Colors.orange, fontSize: 14.sp)),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 13.sp),
        ),
        contentPadding: const EdgeInsets.only(left: 8, right: 8)),
  );
}
