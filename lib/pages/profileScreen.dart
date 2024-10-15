import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_ortiz_nosiglia_movil/components/profileList.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/patient.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/person.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileDetailsScreen extends StatelessWidget {
  final Person person;
  const ProfileDetailsScreen({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 226, 215),
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
                              image: NetworkImage(person
                                  .photoUrl), // Muestra la foto de la persona
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image: AssetImage("lib/icons/avatar.png"),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: Colors.white),
                        color: Colors.white,
                        image: const DecorationImage(
                          image: AssetImage("lib/icons/camra.png"),
                        ),
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
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow("Género:", person.gender),
                  _buildInfoRow("Fecha de nacimiento:",
                      "${person.birthDate.toLocal()}".split(' ')[0]),
                  _buildInfoRow("Teléfono:", person.phone ?? "No disponible"),
                  _buildInfoRow("Móvil:", person.mobile ?? "No disponible"),
                  _buildInfoRow("Email:", person.email),
                  _buildInfoRow("Dirección:",
                      "${person.addressLine}, ${person.addressCity}"),
                  _buildInfoRow("Estado Civil:", person.maritalStatus),
                  _buildInfoRow("Identificación:", person.identification),
                  _buildAllergiesSection(person.allergies),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Container(
              height: 550,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: const Column(
                children: [
                  SizedBox(height: 50),
                  ProfileList(
                    image: "lib/icons/heart2.png",
                    title: "My Saved",
                    color: Colors.black87,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Divider(),
                  ),
                  ProfileList(
                    image: "lib/icons/appoint.png",
                    title: "Appointment",
                    color: Colors.black87,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Divider(),
                  ),
                  ProfileList(
                    image: "lib/icons/chat.png",
                    title: "FAQs",
                    color: Colors.black87,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Divider(),
                  ),
                  ProfileList(
                    image: "lib/icons/pay.png",
                    title: "Payment Method",
                    color: Colors.black87,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Divider(),
                  ),
                  ProfileList(
                    image: "lib/icons/logout.png",
                    title: "Log out",
                    color: Colors.red,
                  ),
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
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildAllergiesSection(List<Allergy> allergies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          "Alergias:",
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        ...allergies.map((allergy) => Text(
              allergy.substance, // Asegúrate de que tu clase Allergy tenga un atributo "name"
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            )),
      ],
    );
  }
}
