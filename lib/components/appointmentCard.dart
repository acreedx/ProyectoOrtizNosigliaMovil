import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyecto_ortiz_nosiglia_movil/enums/appointmentStatus.dart';
import 'package:proyecto_ortiz_nosiglia_movil/modals/cancelAppointmentModal.dart';
import 'package:proyecto_ortiz_nosiglia_movil/modals/completeAppointmentFormDialog.dart';
import 'package:proyecto_ortiz_nosiglia_movil/modals/confirmAppointmentModal.dart';
import 'package:proyecto_ortiz_nosiglia_movil/modals/markAsNotAssistedModal.dart';
import 'package:proyecto_ortiz_nosiglia_movil/models/appointmentDetail.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentComplete.dart';
import 'package:proyecto_ortiz_nosiglia_movil/pages/appointmentDetail.dart';
import 'package:proyecto_ortiz_nosiglia_movil/providers/citas.dart';
import 'package:proyecto_ortiz_nosiglia_movil/utils/AppointmentStatusFormater.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class appointmentCard extends StatelessWidget {
  final AppointmentDetail appointment;
  final VoidCallback onRegistroCreado;

  const appointmentCard(
      {super.key, required this.appointment, required this.onRegistroCreado});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
                          "Paciente ${'${appointment.patient.first_name} ${appointment.patient.last_name}'}",
                          style: GoogleFonts.poppins(
                              fontSize: 15.sp, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Tipo de atención: ${appointment.specialty}',
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
                      image: NetworkImage(appointment.patient.photo_url),
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
                      "Fecha: ${appointment.programed_date_time.day}/${appointment.programed_date_time.month}/${appointment.programed_date_time.year}",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 99, 99, 99),
                      ),
                    ),
                    Text(
                      "De: ${(appointment.programed_date_time.hour).toString().padLeft(2, '0')}:${appointment.programed_date_time.minute.toString().padLeft(2, '0')}",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 99, 99, 99),
                      ),
                    ),
                    Text(
                      "a: ${(appointment.programed_end_date_time.hour).toString().padLeft(2, '0')}:${appointment.programed_end_date_time.minute.toString().padLeft(2, '0')}",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 99, 99, 99),
                      ),
                    ),
                    Text(
                      appointmentStatusFormatter(appointment.status),
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color:
                            statusColorMap[appointment.status] ?? Colors.black,
                      ),
                    ),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Wrap(
              spacing: 4,
              alignment: WrapAlignment.spaceBetween,
              children: [
                /*if (appointment.status !=
                        AppointmentStatus.STATUS_NO_ASISTIDA &&
                    appointment.status != AppointmentStatus.STATUS_COMPLETADA &&
                    appointment.status != AppointmentStatus.STATUS_CANCELADA)
                  //boton editar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                    ),
                    onPressed: () async {
                      //todo hacer el formulario de editar
                      mostrarAlertaConfirmacion(context, onRegistroCreado, "1");
                    },
                    child: Text(
                      "Editar",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 252, 252, 252),
                      ),
                    ),
                  ),*/
                if (appointment.status == AppointmentStatus.STATUS_PENDIENTE)
                  //boton confirmar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                    ),
                    onPressed: () async {
                      confirmarCita(context, onRegistroCreado, appointment.id.toString());
                    },
                    child: Text(
                      "Confirmar",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 252, 252, 252),
                      ),
                    ),
                  ),
                if (appointment.status == AppointmentStatus.STATUS_CONFIRMADA)
                  //boton completar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                    ),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: AppointmentCompleteScreen(
                            id_cita: appointment.id.toString(),
                          ),
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
                if (appointment.status == AppointmentStatus.STATUS_CONFIRMADA)
                  //boton no asistida
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                    ),
                    onPressed: () async {
                      marcarCitaComoNoAsistida(
                          context, onRegistroCreado, appointment.id.toString());
                    },
                    child: Text(
                      "Marcar como no asistida",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 252, 252, 252),
                      ),
                    ),
                  ),
                if (appointment.status !=
                        AppointmentStatus.STATUS_NO_ASISTIDA &&
                    appointment.status != AppointmentStatus.STATUS_COMPLETADA &&
                    appointment.status != AppointmentStatus.STATUS_CANCELADA)
                  //boton cancelar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                    ),
                    onPressed: () async {
                      cancelarCita(
                          context, onRegistroCreado, appointment.id.toString());
                    },
                    child: Text(
                      "Cancelar",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 252, 252, 252),
                      ),
                    ),
                  ),
                if (!(appointment.status !=
                        AppointmentStatus.STATUS_NO_ASISTIDA &&
                    appointment.status != AppointmentStatus.STATUS_COMPLETADA &&
                    appointment.status != AppointmentStatus.STATUS_CANCELADA))
                  //boton informacion
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: AppointmentDetailScreen(
                            id_cita: appointment.id.toString(),
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
              ],
            ),
          )
        ]),
      ),
    );
  }
}
