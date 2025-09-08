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
    return Container(
      color: Colors.orange,
      height: double.infinity,
      child: FutureBuilder<Map<String, dynamic>>(
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
                              image: snapshot.data!['access_token']['photo_url']
                                      .isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(snapshot
                                          .data!['access_token']['photo_url']),
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
                      "${snapshot.data!['access_token']['first_name']} ${snapshot.data!['access_token']['last_name'] ?? ''}",
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
                          _buildInfoRow(
                              "Fecha de nacimiento:",
                              formatDate(DateTime.parse(snapshot
                                  .data!['access_token']['birth_date']))),
                          _buildInfoRow(
                              "Teléfono:",
                              snapshot.data!['access_token']['phone'] ??
                                  "No disponible"),
                          _buildInfoRow(
                              "Celular:",
                              snapshot.data!['access_token']['mobile'] ??
                                  "No disponible"),
                          _buildInfoRow("Email:",
                              snapshot.data!['access_token']['email']),
                          _buildInfoRow("Dirección:",
                              "${snapshot.data!['access_token']['address_line']}, ${snapshot.data!['access_token']['address_city']}"),
                          _buildInfoRow("CI:",
                              snapshot.data!['access_token']['identification']),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          }),
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
