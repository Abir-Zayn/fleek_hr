class DailyAttendanceModel {
  final String? id;
  final String? employeeId;
  final DateTime? workDay;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String? status;
  final bool? isWeekend;
  final bool? isLeave;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DailyAttendanceModel({
    this.id,
    this.employeeId,
    this.workDay,
    this.checkIn,
    this.checkOut,
    this.status,
    this.isWeekend,
    this.isLeave,
    this.createdAt,
    this.updatedAt,
  });

  // Create model from JSON map
  factory DailyAttendanceModel.fromJson(Map<String, dynamic> json) {
    return DailyAttendanceModel(
      id: json['id'] as String?,
      employeeId: json['employee_id'] as String?,
      workDay:
          json['work_day'] != null ? DateTime.parse(json['work_day']) : null,
      checkIn: json['check_in'] != null
          ? DateTime.parse('1970-01-01 ${json['check_in']}')
          : null,
      checkOut: json['check_out'] != null
          ? DateTime.parse('1970-01-01 ${json['check_out']}')
          : null,
      status: json['status'] as String?,
      isWeekend: json['is_weekend'] as bool?,
      isLeave: json['is_leave'] as bool?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  // Convert model to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'work_day': workDay?.toIso8601String().split('T')[0],
      'check_in': checkIn != null
          ? '${checkIn!.hour.toString().padLeft(2, '0')}:${checkIn!.minute.toString().padLeft(2, '0')}:${checkIn!.second.toString().padLeft(2, '0')}'
          : null,
      'check_out': checkOut != null
          ? '${checkOut!.hour.toString().padLeft(2, '0')}:${checkOut!.minute.toString().padLeft(2, '0')}:${checkOut!.second.toString().padLeft(2, '0')}'
          : null,
      'status': status,
      'is_weekend': isWeekend,
      'is_leave': isLeave,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Create a copy with modified fields
  DailyAttendanceModel copyWith({
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
    return DailyAttendanceModel(
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
      other is DailyAttendanceModel &&
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
    return 'DailyAttendanceModel(id: $id, employeeId: $employeeId, workDay: $workDay, checkIn: $checkIn, checkOut: $checkOut, status: $status, isWeekend: $isWeekend, isLeave: $isLeave)';
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
}
