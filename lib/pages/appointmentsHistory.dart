import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointmentDetail.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/citas.dart';
import 'package:proyecto_ortiz_nosiglia_movil/utils/AppointmentStatusFormater.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Appointmentshistory extends StatefulWidget {
  const Appointmentshistory({super.key});

  @override
  State<Appointmentshistory> createState() => _AppointmentshistoryState();
}

class _AppointmentshistoryState extends State<Appointmentshistory> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AppointmentDetail>>(
      future: getPastAppointments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final appointments = snapshot.data!;
          if (appointments.isEmpty) {
            return const Center(child: Text('No hay citas pasadas'));
          }
          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  title: Text(
                    "Paciente ${'${appointment.patient.first_name} ${appointment.patient.last_name}'}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  subtitle: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Especialidad: ${appointment.specialty}',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'Razón: ${appointment.reason}',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Estado: ${appointmentStatusFormatter(appointment.status)}',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'Fecha: ${appointment.programed_date_time.day}/${appointment.programed_date_time.month}/${appointment.programed_date_time.year}',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('No se encontraron citas'));
        }
      },
    );
  }
}
