import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointment.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentScreen.dart';

class BottomsServiceNavigationBar extends StatefulWidget {
  const BottomsServiceNavigationBar({super.key});
  @override
  State<BottomsServiceNavigationBar> createState() =>
      _BottomsServiceNavigationBarState();
}

class _BottomsServiceNavigationBarState
    extends State<BottomsServiceNavigationBar> {
  
  int page = 0;
  List<IconData> icons = [
    Icons.home,
    Icons.person,
    Icons.person,
    Icons.person,
  ];
  List<Widget> pages = [
    const AppointmentScreen(), // You can replace this with your actual pages
    const AppointmentScreen(),
    const AppointmentScreen(),
    const AppointmentScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
      icons: icons,
      iconSize: 20,
      activeIndex: page,
      height: 80,
      splashSpeedInMilliseconds: 300,
      gapLocation: GapLocation.none,
      activeColor: const Color.fromARGB(255, 0, 190, 165),
      inactiveColor: const Color.fromARGB(255, 223, 219, 219),
      onTap: (int tappedIndex) {
        setState(() {
          page = tappedIndex;
        });
      },
    );
  }
}
