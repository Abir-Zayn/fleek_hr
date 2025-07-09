import 'package:fleekhr/data/models/leave_request/enum/leaveType_enum.dart';

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

  LeaveType toDomainEnum() {
    return LeaveType.fromString(name);
  }
}
