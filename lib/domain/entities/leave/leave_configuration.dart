import 'package:fleekhr/data/models/leave_request/enum/leaveType_enum.dart';

/// Represents the configuration for a specific type of leave.
/// This is a core domain entity, free of data layer concerns.
/// Enum representing the type of leave.
/// These enums are part of the core domain logic.


class LeaveConfigurationEntity {
  final LeaveType leaveType;
  final int maxDays;

  LeaveConfigurationEntity({
    required this.leaveType,
    required this.maxDays,
  });
}
