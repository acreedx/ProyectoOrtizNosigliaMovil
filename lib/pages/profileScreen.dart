import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_ortiz_nosiglia_movil/components/appointmentListView.dart';
import 'package:proyecto_ortiz_nosiglia_movil/components/profileList.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/allergy.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/person.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/loginScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final Person person = Person(
  id: "12345",
  firstName: "Juan",
  secondName: "Carlos",
  familyName: "Pérez",
  gender: "Male",
  birthDate: DateTime(1990, 5, 20),
  phone: "123456789",
  mobile: "987654321",
  email: "juan.perez@example.com",
  addressLine: "Calle Falsa 123",
  addressCity: "La Paz",
  maritalStatus: "Single",
  identification: "CI123456",
  photoUrl:
      "https://plus.unsplash.com/premium_photo-1689977968861-9c91dbb16049?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Zm90byUyMGRlJTIwcGVyZmlsfGVufDB8fDB8fHww",
  allergies: [],
);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Center(
              child: Stack(
                children: [
                  const SizedBox(height: 50),
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                        )
                      ],
                      shape: BoxShape.circle,
                      image: person.photoUrl.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(person.photoUrl),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image: AssetImage("lib/icons/avatar.png"),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "${person.firstName} ${person.secondName ?? ''} ${person.familyName}",
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow("Género:",
                      person.gender == "Male" ? "Masculino" : "Femenino"),
                  _buildInfoRow("Fecha de nacimiento:",
                      "${person.birthDate.toLocal()}".split(' ')[0]),
                  _buildInfoRow("Teléfono:", person.phone ?? "No disponible"),
                  _buildInfoRow("Celular:", person.mobile ?? "No disponible"),
                  _buildInfoRow("Email:", person.email),
                  _buildInfoRow("Dirección:",
                      "${person.addressLine}, ${person.addressCity}"),
                  _buildInfoRow("Estado Civil:",
                      person.maritalStatus == "Married" ? "Casado" : "Soltero"),
                  _buildInfoRow("CI:", person.identification),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          textStyle: GoogleFonts.inter(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ), // Color del texto y los iconos
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30), // Bordes redondeados
                          ),
                          minimumSize: Size(
                              MediaQuery.of(context).size.width * 0.9,
                              60), // Tamaño mínimo
                          elevation: 5, // Sombra para el botón
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.power_settings_new,
                              size: 24,
                              color: Colors.red,
                            ),
                            Expanded(
                              child: Text(
                                "Cerrar Sesión",
                                style: GoogleFonts.inter(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black, // Color del texto
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        "$title $value",
        style: GoogleFonts.poppins(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
