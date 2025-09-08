import 'package:intl/intl.dart';

String formatTime(DateTime dateTime) {
  return DateFormat('hh:mm').format(dateTime);
}

String calculateAge(DateTime birthDate) {
  final today = DateTime.now();
  final age = today.year - birthDate.year;
  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < birthDate.day)) {
    return (age - 1).toString();
  }
  return age.toString();
}

String formatDate(DateTime dateTime) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(dateTime);
}

String formatDateISO(DateTime dateTime) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(dateTime);
}