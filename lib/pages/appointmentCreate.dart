import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/Person.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentScreen.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/homeScreen.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/menuScreen.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/citas.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/pacientes.dart';
import 'package:proyecto_ortiz_nosiglia_movil/utils/DateTimeFormater.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppointmentCreateScreen extends StatefulWidget {
  const AppointmentCreateScreen({super.key});

  @override
  State<AppointmentCreateScreen> createState() =>
      _AppointmentCreateScreenState();
}

class _AppointmentCreateScreenState extends State<AppointmentCreateScreen> {
  final _stepperKey = GlobalKey<FormState>();
  late Future<List<Person>> _futurePersons;
  String? _selectedPatientId;
  Person? _selectedPatient;
  int _currentStep = 0;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _appointmentReason;
  String? _especialidad;
  String? _nota;
  String? _instrucciones;
  late List<Person> pacientes;

  @override
  void initState() {
    super.initState();
    _futurePersons = getPersons();
  }

  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  List<Step> stepList() => [
        Step(
            state: _currentStep <= 0 ? StepState.indexed : StepState.complete,
            isActive: _currentStep >= 0,
            title:
                const Text('Paciente', style: TextStyle(color: Colors.orange)),
            content: Column(
              children: [
                Form(
                    key: _formKeys[0],
                    child: FutureBuilder<List<Person>>(
                      future: _futurePersons,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Text("Error al cargar pacientes");
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty ||
                            snapshot.data == null) {
                          return const Text("No hay pacientes disponibles");
                        } else {
                          pacientes = snapshot.data!;
                          return SizedBox(
                            width: double.infinity,
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              decoration: const InputDecoration(
                                labelText: "Selecciona un paciente",
                                border: OutlineInputBorder(),
                              ),
                              value: _selectedPatientId,
                              validator: (value) => value == null
                                  ? "Selecciona un paciente"
                                  : null,
                              onChanged: (String? idPaciente) {
                                if (idPaciente != null) {
                                  setState(() {
                                    _selectedPatientId = idPaciente;
                                    _selectedPatient = pacientes.firstWhere(
                                        (e) =>
                                            e.id ==
                                            int.parse(_selectedPatientId!));
                                  });
                                }
                              },
                              items: pacientes.map((Person patient) {
                                return DropdownMenuItem<String>(
                                  value: patient.id.toString(),
                                  child: Text(
                                      "${patient.first_name} ${patient.last_name}"),
                                );
                              }).toList(),
                            ),
                          );
                        }
                      },
                    )),
                ...[
                  if (_selectedPatient != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Información del paciente',
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
                                    text: '${_selectedPatient!.first_name} ${_selectedPatient!.last_name}',
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Carnet de identidad: ',
                                style:
                                Theme.of(context).textTheme.bodyMedium,
                                children: [
                                  TextSpan(
                                    text: _selectedPatient!.identification,
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Edad: ',
                                style:
                                Theme.of(context).textTheme.bodyMedium,
                                children: [
                                  TextSpan(
                                    text: calculateAge(_selectedPatient!.birth_date),
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
                                    text: _selectedPatient?.phone ?? "Ninguno",
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
                                    text: _selectedPatient?.mobile ?? "Ninguno",
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
                                    text: '${_selectedPatient?.address_line} ${_selectedPatient?.address_city}',
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Correo: ',
                                style:
                                Theme.of(context).textTheme.bodyMedium,
                                children: [
                                  TextSpan(
                                    text: _selectedPatient?.email,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
                ]
              ],
            )),
        Step(
            state: _currentStep <= 1 ? StepState.indexed : StepState.complete,
            isActive: _currentStep >= 1,
            title: const Text('Fecha y Hora',
                style: TextStyle(color: Colors.orange)),
            content: Form(
              key: _formKeys[1],
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text(_selectedDate == null
                        ? 'Selecciona una Fecha'
                        : 'Fecha: ${formatDate(_selectedDate!)}'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _selectTime(context),
                    child: Text(
                      _selectedTime == null
                          ? 'Selecciona una hora de inicio'
                          : 'Hora: ${_selectedTime!.format(context)}',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: _especialidad,
                    decoration: const InputDecoration(
                      labelText: 'Especialidad',
                      labelStyle: TextStyle(color: Colors.orange),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'La especialidad es obligatoria';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _especialidad = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: _appointmentReason,
                    decoration: const InputDecoration(
                      labelText: 'Motivo',
                      labelStyle: TextStyle(color: Colors.orange),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'El motivo es obligatorio';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _appointmentReason = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: _nota,
                    decoration: const InputDecoration(
                      labelText: 'Nota',
                      labelStyle: TextStyle(color: Colors.orange),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _nota = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: _instrucciones,
                    decoration: const InputDecoration(
                      labelText: 'Instrucciones',
                      labelStyle: TextStyle(color: Colors.orange),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _instrucciones = value;
                      });
                    },
                  ),
                ],
              ),
            )),
        Step(
          state: StepState.indexed,
          isActive: _currentStep >= 2,
          title: const Text('Resumen', style: TextStyle(color: Colors.orange)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side:
                      const BorderSide(color: Colors.orangeAccent, width: 1.5),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Paciente: ${_selectedPatient != null ? ('${_selectedPatient!.first_name} ${_selectedPatient!.last_name}') : ("No seleccionado")}\n'
                    'Fecha: ${_selectedDate != null ? formatDate(_selectedDate!) : 'No seleccionada'}, \n'
                    'Hora: ${_selectedTime?.format(context) ?? 'No seleccionada'}, \n'
                    'Especialidad; $_especialidad\n'
                    'Motivo: ${_appointmentReason ?? "Ninguno"}\n'
                    'Nota: ${_nota ?? "Ninguna"}\n'
                    'Instrucciones: ${_instrucciones ?? "Ninguna"}',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cita', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
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
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        key: _stepperKey,
        onStepContinue: () {
          if (_currentStep < 2) {
            if (_currentStep == 1) {
              if (_selectedDate == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor selecciona una fecha'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              if (_selectedTime == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor selecciona una hora'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
            }
            if (_formKeys[_currentStep].currentState!.validate()) {
              setState(() {
                _currentStep += 1;
              });
            }
          } else {
            _confirmAppointment();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        onStepTapped: (int step) => setState(() => _currentStep = step),
        controlsBuilder: (context, details) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (details.currentStep > 0)
                ElevatedButton(
                  onPressed: details.onStepCancel,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Regresar',
                      style: TextStyle(color: Colors.white)),
                ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: details.onStepContinue,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Continuar',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
        steps: stepList(),
      ),
    );
  }

  void _confirmAppointment() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Esta seguro de crear esta cita?'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white, // texto del botón
              ),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  if (_appointmentReason == null ||
                      _selectedDate == null ||
                      _selectedTime == null ||
                      _selectedPatient == null) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Complete todos los campos antes de continuar"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    var response = await crearCita(
                        _selectedDate!,
                        _selectedTime!.format(context),
                        _especialidad ?? "ninguna",
                        _appointmentReason ?? "ninguna",
                        _nota,
                        _instrucciones,
                        int.parse(_selectedPatientId!));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(response),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const MenuScreen(initialPage: 1),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  }
                } catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
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
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale('es', 'ES'),
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final times = generateTimeOptions("08:00", "17:00", 30);
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Selecciona una hora"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: times.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(times[index]),
                  onTap: () {
                    final selectedTimeParts =
                        times[index].split(":").map(int.parse).toList();
                    setState(() {
                      _selectedTime = TimeOfDay(
                        hour: selectedTimeParts[0],
                        minute: selectedTimeParts[1],
                      );
                    });
                    Navigator.pop(context, times[index]);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

List<String> generateTimeOptions(String start, String end, int interval) {
  final times = <String>[];
  var startParts = start.split(":").map(int.parse).toList();
  var endParts = end.split(":").map(int.parse).toList();

  int startHour = startParts[0];
  int startMinute = startParts[1];
  int endHour = endParts[0];
  int endMinute = endParts[1];

  while (startHour < endHour ||
      (startHour == endHour && startMinute < endMinute)) {
    final formattedTime =
        '${startHour.toString().padLeft(2, '0')}:${startMinute.toString().padLeft(2, '0')}';
    times.add(formattedTime);
    startMinute += interval;
    if (startMinute >= 60) {
      startHour++;
      startMinute -= 60;
    }
  }

  return times;
}
