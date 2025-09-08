import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/patientHistoryDetail.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/pacientes.dart';
import 'package:proyecto_ortiz_nosiglia_movil/utils/DateTimeFormater.dart';

class PatientHistoryDetailScreen extends StatefulWidget {
  final String id_paciente;

  const PatientHistoryDetailScreen({super.key, required this.id_paciente});

  @override
  State<PatientHistoryDetailScreen> createState() =>
      _PatientHistoryDetailScreenState();
}

class _PatientHistoryDetailScreenState
    extends State<PatientHistoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial del paciente'),
      ),
      body: FutureBuilder<PatientHistoryDetail>(
        future: getPatientHistory(widget.id_paciente),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (snapshot.hasData) {
            final patient = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Datos personales',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: 'Nombre: ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                  TextSpan(
                                    text:
                                        '${patient.first_name} ${patient.last_name}',
                                  ),
                                ])),
                            RichText(
                                text: TextSpan(
                                    text: 'Carnet de Identidad: ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                  TextSpan(
                                    text: patient.identification,
                                  ),
                                ])),
                            RichText(
                                text: TextSpan(
                                    text: 'Fecha de nacimiento: ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                  TextSpan(
                                    text: formatDate(patient.birth_date),
                                  ),
                                ])),
                            RichText(
                              text: TextSpan(
                                text: 'Teléfono: ',
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: [
                                  TextSpan(
                                    text: patient.phone ?? "No disponible",
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Celular: ',
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: [
                                  TextSpan(
                                    text: patient.mobile ?? "No disponible",
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Email: ',
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: [
                                  TextSpan(
                                    text: patient.email,
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Dirección: ',
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: [
                                  TextSpan(
                                    text:
                                        '${patient.address_line}, ${patient.address_city}',
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Seguro: ',
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: [
                                  TextSpan(
                                    text: patient.organization ?? "Ninguna",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Antecedentes médicos',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: 'Alergias: ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                  TextSpan(
                                    text: patient.allergies ?? "Ninguna",
                                  ),
                                ])),
                            RichText(
                                text: TextSpan(
                                    text: 'Precondiciones: ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                  TextSpan(
                                    text: patient.preconditions ?? "Ninguna",
                                  ),
                                ])),
                          ],
                        ),
                      ),
                    ),
                    ...[
                      if (patient.emergencyContact != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Contacto de emergencia',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Nombre: ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(
                                        text: patient.emergencyContact!.name,
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Relación: ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(
                                        text:
                                            patient.emergencyContact!.relation,
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Teléfono: ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(
                                        text: patient.emergencyContact!.phone,
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Celular: ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(
                                        text: patient.emergencyContact!.mobile,
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Dirección: ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(
                                        text:
                                            '${patient.emergencyContact!.address_line} ${patient.emergencyContact!.address_city}',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                    ],
                    const SizedBox(height: 16),
                    Text(
                      'Atenciones realizadas',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: patient.encounters.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final encounter = patient.encounters[index];
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tipo de atención: ${encounter.type}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  'Motivo: ${encounter.reason}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  'Especialidad: ${encounter.specialty}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  'Diagnóstico: ${encounter.diagnosis}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  'Fecha y hora: ${formatDate(encounter.performed_on)} ${formatTime(encounter.performed_on)}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: Text(
              'No se encontraron datos del paciente.',
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
