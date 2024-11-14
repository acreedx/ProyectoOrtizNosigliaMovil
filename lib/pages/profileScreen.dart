import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/loginScreen.dart';
import 'package:proyecto_ortiz_nosiglia_movil/utils/DateTimeFormater.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:proyecto_ortiz_nosiglia_movil/utils/JwtTokenHandler.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: FutureBuilder<Map<String, dynamic>>(
          future: getTokenInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
        return SingleChildScrollView(
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
                        image: snapshot.data!['access_token']['photoUrl'].isNotEmpty
                            ? DecorationImage(
                          image: NetworkImage("https://proyecto-ortiz-nosiglia-front-end-r7fs.vercel.app/${snapshot.data!['access_token']['photoUrl']}"),
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
                "${snapshot.data!['access_token']['firstName']} ${snapshot.data!['access_token']['secondName'] ?? ''} ${snapshot.data!['access_token']['familyName']}",
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
                    _buildInfoRow("Género:", snapshot.data!['access_token']['gender'].toString()),
                    _buildInfoRow("Fecha de nacimiento:", formatDate(DateTime.parse(snapshot.data!['access_token']['birthDate']))),
                    _buildInfoRow("Teléfono:", snapshot.data!['access_token']['phone'] ?? "No disponible"),
                    _buildInfoRow("Celular:", snapshot.data!['access_token']['mobile'] ?? "No disponible"),
                    _buildInfoRow("Email:", snapshot.data!['access_token']['email']),
                    _buildInfoRow("Dirección:",
                        "${snapshot.data!['access_token']['addressLine']}, ${snapshot.data!['access_token']['addressCity']}"),
                    _buildInfoRow("Estado Civil:",
                        snapshot.data!['access_token']['maritalStatus'] == 'Single' ? 'Soltero' : 'Casado'),
                    _buildInfoRow("CI:", snapshot.data!['access_token']['identification']),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Column(
                children: [
                  const SizedBox(height: 15),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () async {
                          if(await signOut() == true) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          }
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
            ],
          ),
        );
        }
        return Container();
          }
      ));

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
