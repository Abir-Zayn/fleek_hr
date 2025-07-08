import 'package:fleekhr/data/models/leave_request/enum/leaveDuration_enum.dart';
import 'package:fleekhr/data/models/leave_request/enum/leaveStatus_enum.dart';
import 'package:fleekhr/data/models/leave_request/enum/leaveType_enum.dart';


class LeaveRequest {
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

  LeaveRequest({
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

  /// Creates a LeaveRequest instance from a JSON map.
  factory LeaveRequest.fromJson(Map<String, dynamic> json) {
    return LeaveRequest(
      id: json['id'],
      employeeId: json['employee_id'],
      leaveType: LeaveType.fromString(json['leave_type']),
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      reason: json['reason'],
      status: LeaveStatus.fromString(json['status']),
      requestedDays: json['requested_days'],
      proofImageUrl: json['proof_image_url'],
      durationType: DurationType.fromString(json['duration_type']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  /// Converts a LeaveRequest instance to a JSON map.
  /// Note: 'id', 'created_at', and 'updated_at' are typically handled by the database
  /// and might not be needed in the JSON payload for inserts.
  Map<String, dynamic> toJson() {
    return {
      // 'id': id, // Usually omitted for inserts
      'employee_id': employeeId,
      'leave_type': leaveType.toJson(),
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'reason': reason,
      'status': status.toJson(),
      'requested_days': requestedDays,
      'proof_image_url': proofImageUrl,
      'duration_type': durationType.toJson(),
      // 'created_at': createdAt.toIso8601String(), // Usually omitted
      // 'updated_at': updatedAt.toIso8601String(), // Usually omitted
    };
  }
}
