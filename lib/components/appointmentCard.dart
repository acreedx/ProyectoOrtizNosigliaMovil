import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        height: MediaQuery.of(context).size.height * 0.24,
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
                          subText,
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
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(image),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover)),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
            width: MediaQuery.of(context).size.width * 0.8500,
            child: Row(children: [
              Text(
                "Fecha: $date",
                style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 99, 99, 99)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Text(
                "De: $time",
                style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 99, 99, 99)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Text(
                "a: $time",
                style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 99, 99, 99)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Text(
                "estado: $confirmation",
                style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 99, 99, 99)),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 232, 233, 233),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.30,
                      MediaQuery.of(context).size.height * 0.040,
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 61, 61, 61),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * 0.30,
                      MediaQuery.of(context).size.height * 0.040,
                    ),
                  ),
                  onPressed: () {},
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
