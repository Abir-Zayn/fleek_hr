class LeaveTypeModel {
  final String name;
  final int availableDays;
  final List<DateTime> usedDates;

  LeaveTypeModel({
    required this.name,
    required this.availableDays,
    required this.usedDates,
  });

  int get usedDays => usedDates.length;
  int get remainingDays => availableDays - usedDays;
}
