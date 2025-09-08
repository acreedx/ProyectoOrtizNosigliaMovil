import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentCreate.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentScreen.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentsHistory.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/homeScreen.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/loginScreen.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/patientListScreen.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/profileScreen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../utils/JwtTokenHandler.dart';

class MenuScreen extends StatefulWidget {
  final int initialPage;
  const MenuScreen({Key? key, this.initialPage = 0}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late int page;

  @override
  void initState() {
    super.initState();
    page = widget.initialPage;
  }
  List<IconData> icons = [
    Icons.home,
    Icons.schedule,
    Icons.medical_information,
    Icons.file_copy,
    Icons.person
  ];

  List<Widget> pages = [
    const HomeScreen(),
    const AppointmentScreen(),
    const Appointmentshistory(),
    const PatientListScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    List<AppBar> appBars = [
      AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      AppBar(
          title: Text(
            "Listado de citas",
            style: GoogleFonts.poppins(color: Colors.orange, fontSize: 18.sp),
          ),
          centerTitle: false,
          elevation: 0,
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.create_new_folder_outlined,
                  color: Colors.orange),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const AppointmentCreateScreen(),
                    inheritTheme: true,
                    ctx: context,
                    duration: const Duration(),
                  ),
                );
              },
            ),
          ]),
      AppBar(
        title: Text(
          "Historial de Citas",
          style: GoogleFonts.poppins(color: Colors.orange, fontSize: 18.sp),
        ),
        centerTitle: false,
        elevation: 0,
        toolbarHeight: 60,
        backgroundColor: Colors.white,
      ),
      AppBar(
        title: Text(
          "Listado de pacientes",
          style: GoogleFonts.poppins(color: Colors.orange, fontSize: 18.sp),
        ),
        centerTitle: false,
        elevation: 0,
        toolbarHeight: 60,
        backgroundColor: Colors.white,
      ),
      AppBar(
          title: Text(
            "Perfil",
            style: GoogleFonts.poppins(color: Colors.orange, fontSize: 18.sp),
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 60,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.red),
                onPressed: () async {
                  if (await signOut() == true) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) =>
                          const LoginScreen()),
                          (Route<dynamic> route) => false,
                    );
                  }
                }
            ),
          ]
      ),
    ];
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBars[page],
        body: FutureBuilder<bool>(
            future: isUserLogged(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData && snapshot.data == false) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const LoginScreen()),
                  );
                });
                return Container();
              }
              return pages[page];
            }),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: icons,
          iconSize: 20,
          activeIndex: page,
          height: 80,
          splashSpeedInMilliseconds: 300,
          gapLocation: GapLocation.none,
          activeColor: Colors.orange,
          inactiveColor: const Color.fromARGB(255, 223, 219, 219),
          onTap: (int tappedIndex) async {
            bool isLogged = await isUserLogged();
            if (isLogged) {
              setState(() {
                page = tappedIndex;
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Por favor, inicie sesión para continuar'),
                  backgroundColor: Colors.red,
                ),
              );
              Navigator.pushReplacement(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: const LoginScreen(),
                ),
              );
            }
          },
        ));
  }
}
