import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileList extends StatelessWidget {
  final String title;
  final Color color;

  const ProfileList({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print("Botón presionado");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            const Color.fromARGB(255, 10, 218, 10), // Color de fondo
        textStyle: GoogleFonts.inter(
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ), // Color del texto y los iconos
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Bordes redondeados
        ),
        minimumSize:
            Size(MediaQuery.of(context).size.width * 0.9, 60), // Tamaño mínimo
        elevation: 5, // Sombra para el botón
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.power_settings_new,
              size: 24), // Icono a la izquierda
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black, // Color del texto
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Icon(Icons.arrow_right, size: 24), // Icono a la derecha
        ],
      ),
    );
  }
}
