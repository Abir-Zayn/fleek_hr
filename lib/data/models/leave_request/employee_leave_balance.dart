import 'package:fleekhr/data/models/leave_request/enum/leaveType_enum.dart';

/// Data model for the 'employee_leave_balance' table.
/// Tracks the leave balance for each employee for a given year.
class EmployeeLeaveBalance {
  final int id;
  final String employeeId;
  final LeaveType leaveType;
  final int totalAllocated;
  final int usedDays;
  final int remainingDays;
  final int year;
  final DateTime createdAt;
  final DateTime updatedAt;

  EmployeeLeaveBalance({
    required this.id,
    required this.employeeId,
    required this.leaveType,
    required this.totalAllocated,
    required this.usedDays,
    required this.remainingDays,
    required this.year,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates an EmployeeLeaveBalance instance from a JSON map.
  factory EmployeeLeaveBalance.fromJson(Map<String, dynamic> json) {
    return EmployeeLeaveBalance(
      id: json['id'],
      employeeId: json['employee_id'],
      leaveType: LeaveType.fromString(json['leave_type']),
      totalAllocated: json['total_allocated'],
      usedDays: json['used_days'],
      remainingDays: json['remaining_days'],
      year: json['year'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  /// Converts an EmployeeLeaveBalance instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'leave_type': leaveType.toJson(),
      'total_allocated': totalAllocated,
      'used_days': usedDays,
      'remaining_days': remainingDays,
      'year': year,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
