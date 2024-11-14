import 'package:flutter/material.dart';
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
  int _currentStep = 0;

  String? _selectedPatient;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  TimeOfDay? _selectedTimeEnd;
  String _appointmentReason = '';

  final List<String> _patients = [
    'Jhon',
    'Luis',
    'Andres',
    'Veronica',
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
        key: _stepperKey,
        currentStep: _currentStep,
        onStepTapped: (step) => setState(() => _currentStep = step),
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() {
              _currentStep += 1;
            });
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
        controlsBuilder: (context, details) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: details.onStepContinue,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent),
                child: const Text('Continuar',
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () async => {

                },
                child: const Text('Cancelar',
                    style: TextStyle(color: Colors.orange)),
              ),
            ],
          );
        },
        steps: [
          Step(
            title: const Text('Seleccionar Paciente',
                style: TextStyle(color: Colors.orange)),
            content: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: DropdownButton<String>(
                hint: const Text('Selecciona un paciente'),
                value: _selectedPatient,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPatient = newValue;
                  });
                },
                items: _patients.map((String patient) {
                  return DropdownMenuItem<String>(
                    value: patient,
                    child: Text(patient),
                  );
                }).toList(),
              ),
            ),
          ),
          Step(
            title: const Text('Seleccionar Fecha y Hora',
                style: TextStyle(color: Colors.orange)),
            content: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent),
                    child: Text(
                        _selectedDate == null
                            ? 'Selecciona una fecha'
                            : 'Fecha: ${formatDate(_selectedDate!)}',
                        style: const TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _selectTime(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent),
                    child: Text(
                        _selectedTime == null
                            ? 'Selecciona una hora'
                            : 'Hora: ${_selectedTime!.format(context)}',
                        style: const TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _selectTimeEnd(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent),
                    child: Text(
                        _selectedTimeEnd == null
                            ? 'Selecciona una hora'
                            : 'Hora: ${_selectedTimeEnd!.format(context)}',
                        style: const TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
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
                    onChanged: (value) {
                      setState(() {
                        _appointmentReason = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Step(
            title:
                const Text('Resumen', style: TextStyle(color: Colors.orange)),
            content: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                          color: Colors.orangeAccent, width: 1.5),
                    ),
                    elevation: 4, // Sombra sutil
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'Paciente: ${_selectedPatient ?? 'No seleccionado'},\n'
                        'Fecha: ${_selectedDate != null ? formatDate(_selectedDate!) : 'No seleccionada'}, \n'
                        'Hora Inicio: ${_selectedTime?.format(context) ?? 'No seleccionada'}, \n'
                        'Hora Fin: ${_selectedTimeEnd?.format(context) ?? 'No seleccionada'}, \n'
                        'Motivo: $_appointmentReason',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _selectTimeEnd(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTimeEnd ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTimeEnd) {
      setState(() {
        _selectedTimeEnd = picked;
      });
    }
  }

  void _confirmAppointment() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cita Confirmada'),
          content: Container(
            padding: const EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Bordes redondeados
                side: const BorderSide(
                    color: Colors.orangeAccent, width: 1.5), // Borde naranja
              ),
              elevation: 4, // Sombra sutil
              child: Padding(
                padding: const EdgeInsets.all(15), // Espaciado interno
                child: Text(
                  'Cita para $_selectedPatient\n'
                  'Fecha: ${_selectedDate != null ? formatDate(_selectedDate!) : ""}\n'
                  'Hora Inicio: ${_selectedTime?.format(context)}\n'
                  'Hora Fin: ${_selectedTimeEnd?.format(context)}\n'
                  'Motivo: $_appointmentReason',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('Aceptar', style: TextStyle(color: Colors.orange)),
            ),
          ],
        );
      },
    );
  }
}
