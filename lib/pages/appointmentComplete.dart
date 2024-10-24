import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/menuScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppointmentCompleteScreen extends StatefulWidget {
  const AppointmentCompleteScreen({super.key});

  @override
  State<AppointmentCompleteScreen> createState() =>
      _AppointmentCompleteScreenState();
}

class _AppointmentCompleteScreenState extends State<AppointmentCompleteScreen> {
  final TextEditingController _diagnosisController = TextEditingController();

  final String appointmentSummary = 'Especialidad: Dentista\n'
      'Razón: Revisión general\n'
      'Estado: Completada\n'
      'Hora inicio: 10:00 AM\n'
      'Hora fin: 11:00 AM\n'
      'Notas: Ninguna\n'
      'Instrucciones del paciente: Mantener buena higiene dental.\n'
      'Paciente: Jhon Doe';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Finalización de Cita',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orangeAccent,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildTitle("Información de la cita"),
                      const SizedBox(height: 8),
                      Text(
                        appointmentSummary,
                        style: TextStyle(fontSize: 16.sp),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 16), // Espaciador

            // Campo para ingresar diagnóstico
            const Text(
              'Diagnóstico:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8), // Espaciador
            TextField(
              controller: _diagnosisController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingrese el diagnóstico...',
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final String diagnosis = _diagnosisController.text;
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Cita Completada'),
                      content: Text('Diagnóstico: $diagnosis'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MenuScreen()),
                            );
                          },
                          child: const Text('Continuar'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                ),
                child: const Text(
                  'Completar Cita',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _diagnosisController.dispose(); // Limpiar el controlador al salir
    super.dispose();
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
}
