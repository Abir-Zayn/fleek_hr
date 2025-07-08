import 'package:fleekhr/data/models/leave_request/enum/leaveType_enum.dart';

/// Data model for the 'leave_configuration' table.
/// Stores the maximum number of days allowed for each leave type.
class LeaveConfiguration {
  final int id;
  final LeaveType leaveType;
  final int maxDays;
  final DateTime createdAt;
  final DateTime updatedAt;

  LeaveConfiguration({
    required this.id,
    required this.leaveType,
    required this.maxDays,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates a LeaveConfiguration instance from a JSON map.
  factory LeaveConfiguration.fromJson(Map<String, dynamic> json) {
    return LeaveConfiguration(
      id: json['id'],
      leaveType: LeaveType.fromString(json['leave_type']),
      maxDays: json['max_days'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  /// Converts a LeaveConfiguration instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'leave_type': leaveType.toJson(),
      'max_days': maxDays,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}