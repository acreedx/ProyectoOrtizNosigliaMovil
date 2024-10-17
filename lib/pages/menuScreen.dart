import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointment.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/person.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentScreen.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentsHistory.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/homeScreen.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/loginScreen.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/profileScreen.dart';

final List<Appointment> appointments = [
  Appointment(
    id: '1',
    resourceType: 'Appointment',
    status: 'booked',
    cancellationReason: null,
    specialty: 'Dentistry',
    reason: 'Check-up',
    description: 'Annual dental check-up',
    previousAppointment: null,
    originatingAppointment: null,
    start: DateTime.now().subtract(const Duration(hours: 2)),
    end: DateTime.now().subtract(const Duration(hours: 1)),
    account: '12345',
    cancellationDate: null,
    note: 'No issues found',
    patientInstruction: 'Arrive 15 minutes early',
    subject: 'Patient 1',
  ),
  Appointment(
    id: '2',
    resourceType: 'Appointment',
    status: 'cancelled',
    cancellationReason: 'Patient no-show',
    specialty: 'Dermatology',
    reason: 'Skin consultation',
    description: 'Consultation for skin issues',
    previousAppointment: null,
    originatingAppointment: null,
    start: DateTime.now().add(const Duration(hours: 2)),
    end: DateTime.now().add(const Duration(hours: 3)),
    account: '67890',
    cancellationDate: DateTime.now().subtract(const Duration(hours: 1)),
    note: 'Patient did not show up',
    patientInstruction: 'Reschedule appointment',
    subject: 'Patient 2',
  ),
];

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int page = 0;
  List<IconData> icons = [
    Icons.home,
    Icons.schedule,
    Icons.medical_information,
    Icons.person,
  ];

  List<Widget> pages = [
    const HomeScreen(),
    const AppointmentScreen(),
    const Appointmentshistory(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[page],
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: icons,
          iconSize: 20,
          activeIndex: page,
          height: 80,
          splashSpeedInMilliseconds: 300,
          gapLocation: GapLocation.none,
          activeColor: Colors.orange,
          inactiveColor: const Color.fromARGB(255, 223, 219, 219),
          onTap: (int tappedIndex) {
            setState(() {
              page = tappedIndex;
            });
          },
        ));
  }
}
