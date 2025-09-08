import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/citas.dart';

void confirmarCita(BuildContext context, VoidCallback onRegistroCreado, String appointmentId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFFFFF3E0),
        title: const Text('Confirmación'),
        content: Text('Esta seguro de confirmar esta cita?'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              try {
                var mensaje = await confirmAppointment(appointmentId);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Cita confirmada con éxito"),
                    backgroundColor: Colors.green,
                  ),
                );
                onRegistroCreado();
                Navigator.pop(context);
              } catch (e) {
                String errorMessage;
                if (e is Exception) {
                  errorMessage = e.toString().replaceFirst('Exception: ', '');
                } else {
                  errorMessage = 'Error al confirmar la cita';
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirmar'),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white, // texto del botón
            ),
            child: const Text('Cancelar'),
          ),
        ],
      );
    },
  );
}