extension DateTimeExtension on DateTime {
  bool isSameDay(DateTime other) => year == other.year && month == other.month && day == other.day;

  bool isBetween(DateTime start, DateTime end) {
    final currentDate = DateTime(year, month, day);
    final startDate = DateTime(start.year, start.month, start.day);
    final endDate = DateTime(end.year, end.month, end.day);
    return currentDate.isAfter(startDate.subtract(const Duration(days: 1))) && currentDate.isBefore(endDate.add(const Duration(days: 1)));
  }

  DateTime get yesterday => subtract(const Duration(days: 1));
  DateTime get beforeYesterday => subtract(const Duration(days: 2));
  DateTime get tomorrow => add(const Duration(days: 1));
  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);
}
