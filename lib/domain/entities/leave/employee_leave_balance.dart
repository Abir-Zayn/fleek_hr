/// Represents an employee's leave balance for a given year.
/// This is a core domain entity.
library;

import 'package:fleekhr/data/models/leave_request/enum/leaveType_enum.dart';

class EmployeeLeaveBalanceEntity {
  final String employeeId;
  final LeaveType leaveType;
  final int totalAllocated;
  final int usedDays;
  final int remainingDays;
  final int year;

  EmployeeLeaveBalanceEntity({
    required this.employeeId,
    required this.leaveType,
    required this.totalAllocated,
    required this.usedDays,
    required this.remainingDays,
    required this.year,
  });
}
