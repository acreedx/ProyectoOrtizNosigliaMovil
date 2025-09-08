import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/Person.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/patientHistoryDetailScreen.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/pacientes.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Person>>(
      future: getPersons(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final patients = snapshot.data!;
          if (patients.isEmpty) {
            return const Center(child: Text('No hay pacientes registrados'));
          }
          return ListView.builder(
            itemCount: patients.length,
            itemBuilder: (context, index) {
              final patient = patients[index];
              return Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 6,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(
                    "Paciente: ${patient.first_name} ${patient.last_name}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blueAccent,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Carnet de Identidad: ${patient.identification}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Email: ${patient.email}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.history,
                      color: Colors.green,
                      size: 24,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: PatientHistoryDetailScreen(id_paciente: patient.id.toString()),
                          inheritTheme: true,
                          ctx: context,
                          duration: const Duration(),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('No se encontraron pacientes registrados'));
        }
      },
    );
  }
}
