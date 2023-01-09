import 'package:date_format/date_format.dart';

String toDate(int date) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date);
  if (dateTime.day == DateTime.now().day) {
    return formatDate(dateTime, [HH, ':', nn]);
  } else {
    return formatDate(dateTime, [M, '/', d]);
  }
}
