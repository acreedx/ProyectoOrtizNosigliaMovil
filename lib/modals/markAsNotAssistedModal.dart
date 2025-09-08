import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/citas.dart';

void marcarCitaComoNoAsistida(BuildContext context, VoidCallback onRegistroCreado, String appointmentId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFFFFF3E0),
        title: const Text('Confirmación'),
        content: Text('Esta seguro de marcar esta cita como no asistida?'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              try {
                var message = await markAppointmentAsMissed(appointmentId);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Cita marcada con éxito"),
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
                  errorMessage = 'Error al marcar la cita';
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