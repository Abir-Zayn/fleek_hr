class DailyAttendanceEntity {
  final String id;
  final String employeeId;
  final DateTime workDay;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String status;
  final bool isWeekend;
  final bool isLeave;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DailyAttendanceEntity({
    required this.id,
    required this.employeeId,
    required this.workDay,
    this.checkIn,
    this.checkOut,
    required this.status,
    required this.isWeekend,
    required this.isLeave,
    this.createdAt,
    this.updatedAt,
  });

  // Create a copy with modified fields
  DailyAttendanceEntity copyWith({
    String? id,
    String? employeeId,
    DateTime? workDay,
    DateTime? checkIn,
    DateTime? checkOut,
    String? status,
    bool? isWeekend,
    bool? isLeave,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DailyAttendanceEntity(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      workDay: workDay ?? this.workDay,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      status: status ?? this.status,
      isWeekend: isWeekend ?? this.isWeekend,
      isLeave: isLeave ?? this.isLeave,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Equality operator
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyAttendanceEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          employeeId == other.employeeId &&
          workDay == other.workDay &&
          checkIn == other.checkIn &&
          checkOut == other.checkOut &&
          status == other.status &&
          isWeekend == other.isWeekend &&
          isLeave == other.isLeave;

  @override
  int get hashCode =>
      id.hashCode ^
      employeeId.hashCode ^
      workDay.hashCode ^
      checkIn.hashCode ^
      checkOut.hashCode ^
      status.hashCode ^
      isWeekend.hashCode ^
      isLeave.hashCode;

  @override
  String toString() {
    return 'DailyAttendanceEntity(id: $id, employeeId: $employeeId, workDay: $workDay, checkIn: $checkIn, checkOut: $checkOut, status: $status, isWeekend: $isWeekend, isLeave: $isLeave)';
  }

  // Helper methods for business logic
  bool get isPresent => status == 'present' || status == 'late';

  bool get isAbsent => status == 'absent';

  bool get isOnLeave => isLeave || status == 'on_leave';

  bool get isLate => status == 'late';

  bool get leftEarly => status == 'left_early';

  bool get leftTimely => status == 'left_timely';

  bool get hasCheckedIn => checkIn != null;

  bool get hasCheckedOut => checkOut != null;

  bool get isCompleteAttendance => hasCheckedIn && hasCheckedOut;

  // Calculate work duration if both check-in and check-out are available
  Duration? get workDuration {
    if (checkIn != null && checkOut != null) {
      return checkOut!.difference(checkIn!);
    }
    return null;
  }

  // Get formatted work duration as string
  String get workDurationFormatted {
    final duration = workDuration;
    if (duration == null) return 'N/A';

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }
}

// Attendance status enum for type safety
enum AttendanceStatus {
  present('present'),
  late('late'),
  leftEarly('left_early'),
  leftTimely('left_timely'),
  weekend('weekend'),
  onLeave('on_leave'),
  absent('absent');

  const AttendanceStatus(this.value);
  final String value;

  static AttendanceStatus fromString(String status) {
    return AttendanceStatus.values.firstWhere(
      (e) => e.value == status,
      orElse: () => AttendanceStatus.absent,
    );
  }

  String get displayName {
    switch (this) {
      case AttendanceStatus.present:
        return 'Present';
      case AttendanceStatus.late:
        return 'Late';
      case AttendanceStatus.leftEarly:
        return 'Left Early';
      case AttendanceStatus.leftTimely:
        return 'Left Timely';
      case AttendanceStatus.weekend:
        return 'Weekend';
      case AttendanceStatus.onLeave:
        return 'On Leave';
      case AttendanceStatus.absent:
        return 'Absent';
    }
  }
}
