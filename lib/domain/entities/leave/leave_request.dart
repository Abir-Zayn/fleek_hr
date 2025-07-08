import 'package:equatable/equatable.dart';
import 'package:fleekhr/data/models/leave_request/enum/leaveDuration_enum.dart';
import 'package:fleekhr/data/models/leave_request/enum/leaveStatus_enum.dart';
import 'package:fleekhr/data/models/leave_request/enum/leaveType_enum.dart';

class LeaveRequestEntity extends Equatable {
  final int id;
  final String employeeId;
  final LeaveType leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final String? reason;
  final LeaveStatus status;
  final int requestedDays;
  final String? proofImageUrl;
  final DurationType durationType;
  final DateTime createdAt;
  final DateTime updatedAt;

  const LeaveRequestEntity({
    required this.id,
    required this.employeeId,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    this.reason,
    required this.status,
    required this.requestedDays,
    this.proofImageUrl,
    required this.durationType,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        employeeId,
        leaveType,
        startDate,
        endDate,
        reason,
        status,
        requestedDays,
        proofImageUrl,
        durationType,
        createdAt,
        updatedAt,
      ];
}
