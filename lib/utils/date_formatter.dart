import 'package:intl/intl.dart';

String formatDate(String date) {
  DateTime unFormatted = DateTime.parse(date);
  return DateFormat("EEEE, MMM d, yyyy").format(unFormatted);
}
