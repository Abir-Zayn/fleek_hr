import 'package:fleekhr/data/models/wfh_request/enum/work_from_home_status.dart';
import 'package:fleekhr/data/models/wfh_request/wfh_model.dart';

class WorkFromHomeEntity extends WorkFromHome {
  const WorkFromHomeEntity({
    required super.id,
    required super.startDate,
    required super.endDate,
    required super.reason,
    required super.employeeId,
    required super.employeeName,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
  });

  factory WorkFromHomeEntity.fromJson(Map<String, dynamic> json) {
    return WorkFromHomeEntity(
      id: json['id'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      reason: json['reason'] as String,
      employeeId: json['employee_id'] as String,
      employeeName: json['employee_name'] as String,
      status: _parseStatus(json['status'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'reason': reason,
      'employee_id': employeeId,
      'employee_name': employeeName,
      'status': status.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  static WorkFromHomeStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return WorkFromHomeStatus.pending;
      case 'approved':
        return WorkFromHomeStatus.approved;
      case 'rejected':
        return WorkFromHomeStatus.rejected;
      default:
        return WorkFromHomeStatus.pending;
    }
  }

  factory WorkFromHomeEntity.fromEntity(WorkFromHome entity) {
    return WorkFromHomeEntity(
      id: entity.id,
      startDate: entity.startDate,
      endDate: entity.endDate,
      reason: entity.reason,
      employeeId: entity.employeeId,
      employeeName: entity.employeeName,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
