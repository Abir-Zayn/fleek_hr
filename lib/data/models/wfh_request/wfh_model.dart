import 'package:equatable/equatable.dart';
import 'package:fleekhr/data/models/wfh_request/enum/work_from_home_status.dart';

class WorkFromHome extends Equatable {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final String employeeId;
  final String employeeName;
  final WorkFromHomeStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const WorkFromHome({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.employeeId,
    required this.employeeName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        startDate,
        endDate,
        reason,
        employeeId,
        employeeName,
        status,
        createdAt,
        updatedAt,
      ];

  WorkFromHome copyWith({
    String? id,
    DateTime? startDate,
    DateTime? endDate,
    String? reason,
    String? employeeId,
    String? employeeName,
    WorkFromHomeStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WorkFromHome(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reason: reason ?? this.reason,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
