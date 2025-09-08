import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/components/appointmentCard.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointmentDetail.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/citas.dart';

class AppointmentTabUpcoming extends StatefulWidget {
  const AppointmentTabUpcoming({super.key});
  @override
  State<AppointmentTabUpcoming> createState() => _AppointmentTabUpcomingState();
}

class _AppointmentTabUpcomingState extends State<AppointmentTabUpcoming> {
  late Future<List<AppointmentDetail>> _futurePendingAppointments;
  @override
  void initState() {
    super.initState();
    _futurePendingAppointments = getPendingAppointments();
  }
  void _actualizarDatos() {
    setState(() {
      _futurePendingAppointments = getPendingAppointments();
    });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AppointmentDetail>>(
      future: _futurePendingAppointments,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final appointments = snapshot.data!;
          if (appointments.isEmpty) {
            return const Center(child: Text('No hay citas pendientes'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: appointmentCard(
                  appointment: appointment,
                  onRegistroCreado: _actualizarDatos,
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