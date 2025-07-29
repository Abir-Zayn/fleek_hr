import 'package:fleekhr/domain/entities/dailyActivities/daily_activities_entity.dart';

class DailyActivitiesModel extends DailyActivitiesEntity {
  const DailyActivitiesModel({
    required super.id,
    required super.employeeId,
    required super.companyName,
    required super.department,
    required super.quantity,
    required super.startTime,
    required super.endTime,
    required super.deliveryTime,
    required super.workStatus,
    required super.workType,
    required super.assistedBy,
    required super.workDetails,
    required super.yourSatisfaction,
    required super.checkedYourWork,
    required super.remarksByManagement,
    required super.createdAt,
    required super.updatedAt,
  });

  factory DailyActivitiesModel.fromJson(Map<String, dynamic> json) {
    return DailyActivitiesModel(
      id: json['id'],
      employeeId: json['employee_id'],
      companyName: json['company_name'],
      department: json['department'],
      quantity: json['quantity'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      deliveryTime: json['delivery_time'] != null
          ? DateTime.parse(json['delivery_time'])
          : null,
      workStatus: json['work_status'],
      workType: json['work_type'],
      assistedBy: json['assisted_by'] ?? '',
      workDetails: json['work_details'] ?? '',
      yourSatisfaction: json['your_satisfaction'] ?? 0,
      checkedYourWork: json['checked_your_work'] ?? false,
      remarksByManagement: json['remarks_by_management'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'company_name': companyName,
      'department': department,
      'quantity': quantity,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'delivery_time': deliveryTime?.toIso8601String(),
      'work_status': workStatus,
      'work_type': workType,
      'assisted_by': assistedBy,
      'work_details': workDetails,
      'your_satisfaction': yourSatisfaction,
      'checked_your_work': checkedYourWork,
      'remarks_by_management': remarksByManagement,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory DailyActivitiesModel.fromEntity(DailyActivitiesEntity entity) {
    return DailyActivitiesModel(
      id: entity.id,
      employeeId: entity.employeeId,
      companyName: entity.companyName,
      department: entity.department,
      quantity: entity.quantity,
      startTime: entity.startTime,
      endTime: entity.endTime,
      deliveryTime: entity.deliveryTime,
      workStatus: entity.workStatus,
      workType: entity.workType,
      assistedBy: entity.assistedBy,
      workDetails: entity.workDetails,
      yourSatisfaction: entity.yourSatisfaction,
      checkedYourWork: entity.checkedYourWork,
      remarksByManagement: entity.remarksByManagement,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
