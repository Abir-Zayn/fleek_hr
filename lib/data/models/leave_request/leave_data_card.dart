class LeaveDataCard {
  final String id;
  final String employeeId;
  final String employeeName;
  final String leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final bool isHalfDay;
  final String halfDayType;
  final String status;
  final String reason; //leave reason hidden summary in the card code.

  LeaveDataCard({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    this.isHalfDay = false,
    required this.halfDayType,
    this.status = 'Pending',
    this.reason = '',
  });

  // Calculate the total number of leave days
  double get totalDays {
    if (isHalfDay) return 0.5;
    return endDate.difference(startDate).inDays + 1;
  }

  String get leaveCategory =>
      isHalfDay ? 'Half Day ($halfDayType)' : 'Full Day';
}
