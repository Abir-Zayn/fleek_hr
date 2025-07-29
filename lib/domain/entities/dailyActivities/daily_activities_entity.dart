import 'package:equatable/equatable.dart';

class DailyActivitiesEntity extends Equatable {
  final String id;
  final String employeeId;
  final String companyName;
  final String department;
  final int quantity;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime? deliveryTime;
  final String workStatus;
  final String workType;
  final String assistedBy;
  final String workDetails;
  final int yourSatisfaction;
  final bool checkedYourWork;
  final String remarksByManagement;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DailyActivitiesEntity({
    required this.id,
    required this.employeeId,
    required this.companyName,
    required this.department,
    required this.quantity,
    required this.startTime,
    required this.endTime,
    required this.deliveryTime,
    required this.workStatus,
    required this.workType,
    required this.assistedBy,
    required this.workDetails,
    required this.yourSatisfaction,
    required this.checkedYourWork,
    required this.remarksByManagement,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        employeeId,
        companyName,
        department,
        quantity,
        startTime,
        endTime,
        deliveryTime,
        workStatus,
        workType,
        assistedBy,
        workDetails,
        yourSatisfaction,
        checkedYourWork,
        remarksByManagement,
        createdAt,
        updatedAt,
      ];

  DailyActivitiesEntity copyWith({
    String? id,
    String? employeeId,
    String? companyName,
    String? department,
    int? quantity,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? deliveryTime,
    String? workStatus,
    String? workType,
    String? assistedBy,
    String? workDetails,
    int? yourSatisfaction,
    bool? checkedYourWork,
    String? remarksByManagement,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    {
      return DailyActivitiesEntity(
        id: id ?? this.id,
        employeeId: employeeId ?? this.employeeId,
        companyName: companyName ?? this.companyName,
        department: department ?? this.department,
        quantity: quantity ?? this.quantity,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        deliveryTime: deliveryTime ?? this.deliveryTime,
        workStatus: workStatus ?? this.workStatus,
        workType: workType ?? this.workType,
        assistedBy: assistedBy ?? this.assistedBy,
        workDetails: workDetails ?? this.workDetails,
        yourSatisfaction: yourSatisfaction ?? this.yourSatisfaction,
        checkedYourWork: checkedYourWork ?? this.checkedYourWork,
        remarksByManagement: remarksByManagement ?? this.remarksByManagement,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
    }
  }
}
