extension ShowDataInOwnFormat on DateTime {
  List<String> showDateInOwnFormat() {
    List<String> newdatetime = [];
    newdatetime.add('$day-$month-$year');
    newdatetime.add('$hour$minute$second');
  return newdatetime;
}}
/*
extension showDateTimeInOwnFormat on DateTime {
  String showDateInOwnFormat() {
  return '$day-$month-$year';
}}
*/
