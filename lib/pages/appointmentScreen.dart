import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentCreate.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentTabCanceled.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentTabCompleted.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentTabUpcoming.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
            "Listado de citas",
            style: GoogleFonts.poppins(color: Colors.black, fontSize: 18.sp),
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
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
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
                                      text: "Completadas",
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Tab(
                                      text: "Canceladas",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
