import 'package:intl/intl.dart';

DateTime onlyDate(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

// Short date and time
String formatShort(DateTime dateTime) {
  return DateFormat('d MMM, h:mm a').format(dateTime); // → 20 Jul, 3:45 PM
}

// Full readable format
String formatFull(DateTime dateTime) {
  return DateFormat(
    'EEE, d MMM yyyy · h:mm a',
  ).format(dateTime); // → Sat, 20 Jul 2025 · 3:45 PM
}

String formatSmart(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final taskDate = DateTime(date.year, date.month, date.day);

  if (taskDate == today) {
    return 'Today · ${DateFormat('h:mm a').format(date)}';
  }
  if (taskDate == today.add(const Duration(days: 1))) {
    return 'Tomorrow · ${DateFormat('h:mm a').format(date)}';
  }
  return DateFormat('EEE, d MMM · h:mm a').format(date);
}
