import './date.dart';

String getBackgroundPath(DateTime date) {
  if (isNight(date)) {
    return 'assets/images/night.jpg';
  } else if (isMorning(date)) {
    return 'assets/images/morning.jpg';
  } else if (isEvening(date)) {
    return 'assets/images/evening.jpg';
  } else {
    return 'assets/images/day.jpg';
  }
}
