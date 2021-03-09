import 'package:intl/intl.dart';

String getStringifiedDate(DateTime date) {
  final formatedDate = DateFormat('MMMMEEEEd').format(date);
  return '${formatedDate[0].toUpperCase()}${formatedDate.substring(1)}';
}

bool isMorning(DateTime date) {
  final int hour = date.hour;
  return hour >= 6 && hour < 10;
}

bool isEvening(DateTime date) {
  final int hour = date.hour;
  return hour >= 18 && hour < 22;
}

bool isNight(DateTime date) {
  final int hour = date.hour;
  return hour >= 22 && hour < 6;
}
