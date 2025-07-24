class MonthlyAttendanceEntity {
  final String id;
  final String employeeId;
  final String yearMonth;
  final int workingDays;
  final int onTime;
  final int late;
  final int leftTimely;
  final int leftEarly;
  final int onLeave;
  final int absent;
  final DateTime? updatedAt;

  MonthlyAttendanceEntity({
    required this.id,
    required this.employeeId,
    required this.yearMonth,
    required this.workingDays,
    required this.onTime,
    required this.late,
    required this.leftTimely,
    required this.leftEarly,
    required this.onLeave,
    required this.absent,
    this.updatedAt,
  });

  // Create a copy with modified fields
  MonthlyAttendanceEntity copyWith({
    String? id,
    String? employeeId,
    String? yearMonth,
    int? workingDays,
    int? onTime,
    int? late,
    int? leftTimely,
    int? leftEarly,
    int? onLeave,
    int? absent,
    DateTime? updatedAt,
  }) {
    return MonthlyAttendanceEntity(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      yearMonth: yearMonth ?? this.yearMonth,
      workingDays: workingDays ?? this.workingDays,
      onTime: onTime ?? this.onTime,
      late: late ?? this.late,
      leftTimely: leftTimely ?? this.leftTimely,
      leftEarly: leftEarly ?? this.leftEarly,
      onLeave: onLeave ?? this.onLeave,
      absent: absent ?? this.absent,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Equality operator
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthlyAttendanceEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          employeeId == other.employeeId &&
          yearMonth == other.yearMonth &&
          workingDays == other.workingDays &&
          onTime == other.onTime &&
          late == other.late &&
          leftTimely == other.leftTimely &&
          leftEarly == other.leftEarly &&
          onLeave == other.onLeave &&
          absent == other.absent;

  @override
  int get hashCode =>
      id.hashCode ^
      employeeId.hashCode ^
      yearMonth.hashCode ^
      workingDays.hashCode ^
      onTime.hashCode ^
      late.hashCode ^
      leftTimely.hashCode ^
      leftEarly.hashCode ^
      onLeave.hashCode ^
      absent.hashCode;

  @override
  String toString() {
    return 'MonthlyAttendanceEntity(id: $id, employeeId: $employeeId, yearMonth: $yearMonth, workingDays: $workingDays, onTime: $onTime, late: $late, leftTimely: $leftTimely, leftEarly: $leftEarly, onLeave: $onLeave, absent: $absent)';
  }

  // Helper methods for business logic and calculations
  int get totalDays => workingDays + onLeave + absent;

  int get totalPresent => onTime + late;

  double get attendancePercentage {
    if (totalDays == 0) return 0.0;
    return (totalPresent / totalDays) * 100;
  }

  double get punctualityPercentage {
    if (totalPresent == 0) return 0.0;
    return (onTime / totalPresent) * 100;
  }

  double get leavePercentage {
    if (totalDays == 0) return 0.0;
    return (onLeave / totalDays) * 100;
  }

  double get absentPercentage {
    if (totalDays == 0) return 0.0;
    return (absent / totalDays) * 100;
  }

  // Get year and month separately
  int get year {
    final parts = yearMonth.split('-');
    return int.parse(parts[0]);
  }

  int get month {
    final parts = yearMonth.split('-');
    return int.parse(parts[1]);
  }

  String get monthName {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month];
  }

  String get formattedPeriod => '$monthName $year';

  // Check if this is current month
  bool get isCurrentMonth {
    final now = DateTime.now();
    final currentYearMonth =
        '${now.year}-${now.month.toString().padLeft(2, '0')}';
    return yearMonth == currentYearMonth;
  }

  // Attendance summary methods
  bool get hasGoodAttendance => attendancePercentage >= 90.0;

  bool get hasExcellentPunctuality => punctualityPercentage >= 95.0;

  bool get hasHighAbsenteeism => absentPercentage > 20.0;

  // Create year-month string from DateTime
  static String yearMonthFromDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}';
  }

  // Parse year-month string to DateTime (first day of month)
  DateTime get monthStartDate {
    return DateTime(year, month, 1);
  }

  // Get last day of the month
  DateTime get monthEndDate {
    return DateTime(year, month + 1, 0);
  }
}
