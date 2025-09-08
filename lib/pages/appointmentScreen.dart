import 'package:flutter/material.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentTabCanceled.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentTabCompleted.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentTabUpcoming.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 58,
              width: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 235, 235, 235)),
                color: const Color.fromARGB(255, 241, 241, 241),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      indicatorColor:
                      const Color.fromARGB(255, 241, 241, 241),
                      unselectedLabelColor:
                      const Color.fromARGB(255, 32, 32, 32),
                      labelColor:
                      const Color.fromARGB(255, 255, 255, 255),
                      controller: tabController,
                      tabs: const [
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 2.0),
                          child: Tab(
                            text: "Pendientes",
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 2.0),
                          child: Tab(
                            text: "Confirmadas",
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 2.0),
                          child: Tab(
                            text: "Historial",
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: TabBarView(
                  controller: tabController,
                  children: const [
                    AppointmentTabUpcoming(),
                    AppointmentTabCompleted(),
                    AppointmentTabCanceled(),
                  ]))
        ],
      ),
    );
  }
}
