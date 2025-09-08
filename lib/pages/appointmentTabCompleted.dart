import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/components/appointmentCard.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointment.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointmentDetail.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/citas.dart';

class AppointmentTabCompleted extends StatefulWidget {
  const AppointmentTabCompleted({super.key});

  @override
  State<AppointmentTabCompleted> createState() =>
      _AppointmentTabCompletedState();
}

class _AppointmentTabCompletedState extends State<AppointmentTabCompleted> {
  late Future<List<AppointmentDetail>> _futureConfirmedAppointments;

  @override
  void initState() {
    super.initState();
    _futureConfirmedAppointments = getCompletedAppointments();
  }
  void _actualizarDatos() {
    setState(() {
      _futureConfirmedAppointments = getCompletedAppointments();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<List<AppointmentDetail>>(
          future: _futureConfirmedAppointments,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final appointments = snapshot.data!;
              if (appointments.isEmpty) {
                return const Center(child: Text('No hay citas confirmadas'));
              }
              return ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      appointmentCard(
                        appointment: appointment,
                        onRegistroCreado: _actualizarDatos,
                      ),
                    ],
                  );
                },
              );
            } else {
              return const Center(child: Text('No se encontraron citas'));
            }
          },
        ),);
  }
}
