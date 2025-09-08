import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyecto_ortiz_nosiglia_movil/enums/appointmentStatus.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointmentDetail.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentComplete.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/citas.dart';
import 'package:proyecto_ortiz_nosiglia_movil/utils/AppointmentStatusFormater.dart';
import 'package:proyecto_ortiz_nosiglia_movil/utils/DateTimeFormater.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppointmentDetailScreen extends StatefulWidget {
  final String id_cita;

  const AppointmentDetailScreen({super.key, required this.id_cita});

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  late Future<AppointmentDetail?> appointmentFuture;

  @override
  void initState() {
    super.initState();
    appointmentFuture = getAppointmentInfo(widget.id_cita);
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<AppointmentDetail?>(
        future: appointmentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            var appointment = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
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
                            _buildTitle('Información del Paciente'),
                            const SizedBox(height: 8),
                            _buildDetailTile('Nombre',
                                '${snapshot.data!.patient.first_name} ${snapshot.data!.patient.last_name}'),
                            _buildDetailTile('Edad',
                                calculateAge(appointment.patient.birth_date)),
                            _buildDetailTile(
                                'Teléfono', snapshot.data!.patient.phone),
                            _buildDetailTile(
                                'Móvil', snapshot.data!.patient.mobile),
                            _buildDetailTile(
                                'Email', snapshot.data!.patient.email),
                            _buildDetailTile('Dirección',
                                '${snapshot.data!.patient.address_line}, ${snapshot.data!.patient.address_city}'),
                            _buildDetailTile('Identificación',
                                snapshot.data!.patient.identification),
                            _buildDetailTileWithPhoto(
                                'Imagen',
                                'Foto de perfil',
                                snapshot.data!.patient.photo_url),
                            const SizedBox(height: 8),
                            snapshot.data!.patient.allergies != null
                                ? _buildTitle('Alergias')
                                : const SizedBox(height: 1),
                            const SizedBox(height: 4),
                            Text(
                              snapshot.data!.patient.allergies != null &&
                                      snapshot
                                          .data!.patient.allergies!.isNotEmpty
                                  ? snapshot.data!.patient.allergies!
                                  : "ninguna",
                            ),
                            const SizedBox(height: 4),
                            if (snapshot.data!.status ==
                                AppointmentStatus.STATUS_CONFIRMADA)
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: AppointmentCompleteScreen(
                                          id_cita:
                                              snapshot.data!.id.toString()),
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
                                    color: const Color.fromARGB(
                                        255, 252, 252, 252),
                                  ),
                                ),
                              ),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildTitle('Información de la cita'),
                            const SizedBox(height: 8), // Espaciador
                            _buildDetailTile(
                                'Especialidad', appointment.specialty),
                            _buildDetailTile('Razón', appointment.reason),
                            _buildDetailTile('Estado',
                                appointmentStatusFormatter(appointment.status)),
                            _buildDetailTile('Hora inicio',
                                formatTime(appointment.programed_date_time)),
                            _buildDetailTile(
                                'Hora fin',
                                formatTime(
                                    appointment.programed_end_date_time)),
                            if (appointment.note != null)
                              _buildDetailTile('Notas', appointment.note!),
                            if (appointment.patient_instruction != null)
                              _buildDetailTile('Instrucciones del paciente',
                                  appointment.patient_instruction!),
                            _buildDetailTile('Paciente',
                                '${appointment.patient.first_name} ${appointment.patient.last_name}'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
                child: Text('No se encontraron detalles para esta cita.'));
          }
        },
      ),
    );
  }
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
    margin: const EdgeInsets.symmetric(vertical: 1),
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
          style: TextStyle(fontSize: 14.sp),
        ),
        contentPadding: const EdgeInsets.only(left: 8, right: 8)),
  );
}

Widget _buildDetailTileWithPhoto(
    String title, String subtitle, String? photoUrl) {
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
      leading: photoUrl != null && photoUrl.isNotEmpty
          ? CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(photoUrl),
              backgroundColor: Colors.transparent,
            )
          : const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
      title: Text(
        title,
        style: TextStyle(color: Colors.orange, fontSize: 14.sp),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 13.sp),
      ),
      contentPadding: const EdgeInsets.only(left: 8, right: 8),
    ),
  );
}
