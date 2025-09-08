import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointmentDetail.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentScreen.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/menuScreen.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/citas.dart';
import 'package:proyecto_ortiz_nosiglia_movil/utils/AppointmentStatusFormater.dart';
import 'package:proyecto_ortiz_nosiglia_movil/utils/DateTimeFormater.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppointmentCompleteScreen extends StatefulWidget {
  final String id_cita;

  const AppointmentCompleteScreen({super.key, required this.id_cita});

  @override
  State<AppointmentCompleteScreen> createState() =>
      _AppointmentCompleteScreenState();
}

class _AppointmentCompleteScreenState extends State<AppointmentCompleteScreen> {
  final _formKey = GlobalKey<FormState>();
  String diagnostico = '';
  final TextEditingController _diagnosisController = TextEditingController();
  late Future<AppointmentDetail?> appointmentFuture;

  @override
  void initState() {
    super.initState();
    appointmentFuture = getAppointmentInfo(widget.id_cita);
  }

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
      resizeToAvoidBottomInset: true,
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
                              'Especialidad: ${appointment.specialty}\n'
                              'Razón: ${appointment.reason}\n'
                              'Estado: ${appointmentStatusFormatter(appointment.status)}\n'
                              'Hora inicio: ${formatTime(appointment.programed_date_time)}\n'
                              'Hora fin: ${formatTime(appointment.programed_end_date_time)}\n'
                              'Notas: ${appointment.note ?? 'Ninguna'}\n'
                              'Instrucciones del paciente: ${appointment.patient_instruction ?? 'Ninguna'}\n'
                              'Paciente: ${appointment.patient.first_name} ${appointment.patient.last_name}',
                              style: TextStyle(fontSize: 16.sp),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Diagnóstico:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _diagnosisController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Ingrese el diagnóstico',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El campo es requerido';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final String diagnosis = _diagnosisController.text;
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Completar la cita'),
                              content: Text('Diagnóstico: $diagnosis'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      String mensaje =
                                          await completeAppointment(
                                              appointment.id.toString(),
                                              diagnosis);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Éxito al completar la cita'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const MenuScreen(initialPage: 1), // el índice de AppointmentScreen
                                        ),
                                            (Route<dynamic> route) => false,
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(e.toString()),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('Continuar'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor:
                                        Colors.white, // texto del botón
                                  ),
                                  child: const Text('Cancelar'),
                                ),
                              ],
                            ),
                          );
                        }
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
            );
          } else {
            return const Center(
                child: Text('No se encontraron detalles para esta cita.'));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _diagnosisController.dispose();
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
