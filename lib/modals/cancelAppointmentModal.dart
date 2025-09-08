import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/citas.dart';

void cancelarCita(
    BuildContext context, VoidCallback onRegistroCreado, String appointmentId) {
  final _formKey = GlobalKey<FormState>();
  String motivo = '';
  final TextEditingController _motivoController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Ingrese el motivo de cancelación de la cita'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _motivoController,
            decoration: const InputDecoration(
              labelText: 'Motivo de cancelación',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El campo es requerido';
              }
              return null;
            },
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                try {
                    final motivoCancelacion = _motivoController.text.trim();
                    var mensaje = await cancelAppointment(
                        appointmentId, motivoCancelacion);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Cita cancelada con éxito"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    onRegistroCreado();
                    Navigator.of(context).pop();
                } catch (e) {
                  String errorMessage;
                  if (e is Exception) {
                    errorMessage = e.toString().replaceFirst('Exception: ', '');
                  } else {
                    errorMessage = 'Error al cancelar la cita';
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errorMessage),
                      backgroundColor: Colors.red,
                    ),
                  );
                  Navigator.of(context).pop();
                }
              }
            },
            child: const Text('Confirmar'),
          ),
        ],
      );
    },
  );
}
