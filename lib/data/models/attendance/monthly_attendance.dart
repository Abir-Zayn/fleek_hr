import 'package:fleekhr/domain/entities/attendance/monthly_attendance_entity.dart';

class MonthlyAttendanceModel {
  final String? id;
  final String? employeeId;
  final String? yearMonth;
  final int? workingDays;
  final int? onTime;
  final int? late;
  final int? leftTimely;
  final int? leftEarly;
  final int? onLeave;
  final int? absent;
  final DateTime? updatedAt;

  MonthlyAttendanceModel({
    this.id,
    this.employeeId,
    this.yearMonth,
    this.workingDays,
    this.onTime,
    this.late,
    this.leftTimely,
    this.leftEarly,
    this.onLeave,
    this.absent,
    this.updatedAt,
  });

  // Create model from JSON map
  factory MonthlyAttendanceModel.fromJson(Map<String, dynamic> json) {
    return MonthlyAttendanceModel(
      id: json['id'] as String?,
      employeeId: json['employee_id'] as String?,
      yearMonth: json['year_month'] as String?,
      workingDays: json['working_days'] as int?,
      onTime: json['on_time'] as int?,
      late: json['late'] as int?,
      leftTimely: json['left_timely'] as int?,
      leftEarly: json['left_early'] as int?,
      onLeave: json['on_leave'] as int?,
      absent: json['absent'] as int?,
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
      'year_month': yearMonth,
      'working_days': workingDays,
      'on_time': onTime,
      'late': late,
      'left_timely': leftTimely,
      'left_early': leftEarly,
      'on_leave': onLeave,
      'absent': absent,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Convert model to entity
  MonthlyAttendanceEntity toEntity() {
    return MonthlyAttendanceEntity(
      id: id ?? '',
      employeeId: employeeId ?? '',
      yearMonth: yearMonth ?? '',
      workingDays: workingDays ?? 0,
      onTime: onTime ?? 0,
      late: late ?? 0,
      leftTimely: leftTimely ?? 0,
      leftEarly: leftEarly ?? 0,
      onLeave: onLeave ?? 0,
      absent: absent ?? 0,
      updatedAt: updatedAt,
    );
  }

  // Create model from entity
  factory MonthlyAttendanceModel.fromEntity(MonthlyAttendanceEntity entity) {
    return MonthlyAttendanceModel(
      id: entity.id,
      employeeId: entity.employeeId,
      yearMonth: entity.yearMonth,
      workingDays: entity.workingDays,
      onTime: entity.onTime,
      late: entity.late,
      leftTimely: entity.leftTimely,
      leftEarly: entity.leftEarly,
      onLeave: entity.onLeave,
      absent: entity.absent,
      updatedAt: entity.updatedAt,
    );
  }

  // Create a copy with modified fields
  MonthlyAttendanceModel copyWith({
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
    return MonthlyAttendanceModel(
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
      other is MonthlyAttendanceModel &&
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
    return 'MonthlyAttendanceModel(id: $id, employeeId: $employeeId, yearMonth: $yearMonth, workingDays: $workingDays, onTime: $onTime, late: $late, leftTimely: $leftTimely, leftEarly: $leftEarly, onLeave: $onLeave, absent: $absent)';
  }
}
