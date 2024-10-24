import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointmentTestList.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentComplete.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentDetail.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class appointmentCard extends StatelessWidget {
  final String mainText;
  final String subText;
  final String image;
  final String date;
  final String time;
  final String confirmation;

  const appointmentCard(
      {super.key,
      required this.mainText,
      required this.subText,
      required this.date,
      required this.confirmation,
      required this.time,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.22,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(children: [
          Row(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mainText,
                          style: GoogleFonts.poppins(
                              fontSize: 15.sp, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Tipo de atención: $subText',
                          style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 99, 99, 99)),
                        ),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://plus.unsplash.com/premium_photo-1689977968861-9c91dbb16049?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Zm90byUyMGRlJTIwcGVyZmlsfGVufDB8fDB8fHww"),
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Fecha: $date",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 99, 99, 99),
                      ),
                    ),
                    Text(
                      "De: $time",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 99, 99, 99),
                      ),
                    ),
                    Text(
                      "a: $time",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 99, 99, 99),
                      ),
                    ),
                    Text(
                      confirmation,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: confirmation == "pendiente"
                            ? Colors.orange
                            : confirmation == "cancelada"
                                ? Colors.red
                                : confirmation == "completada"
                                    ? Colors.green
                                    : const Color.fromARGB(255, 99, 99, 99),
                      ),
                    ),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.25,
                      30,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Cancelar",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 252, 252, 252),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Bordes redondeados
                    ),
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.25,
                      30,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: AppointmentDetailScreen(
                          appointment: appointments[0],
                        ),
                        inheritTheme: true,
                        ctx: context,
                        duration: const Duration(),
                      ),
                    );
                  },
                  child: Text(
                    "Información",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 252, 252, 252),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.25,
                      30,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const AppointmentCompleteScreen(),
                        inheritTheme: true,
                        ctx: context,
                        duration: const Duration(),
                      ),
                    );
                  },
                  child: Text(
                    "Completar",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 252, 252, 252),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
