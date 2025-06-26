class DailyActivitiesCardModel {
  final String id;
  final String taskTitle;
  final DateTime date;
  final String department;
  final String company;
  final int quantity;
  final String feedback;
  final DateTime startTime;
  final DateTime endTime;
  final String status;

  final String workType;
  final String statisfaction;
  final String employeeId;
  final String employeeName;

  DailyActivitiesCardModel({
    required this.employeeId,
    required this.employeeName,
    required this.workType,
    required this.statisfaction,
    required this.feedback,
    required this.quantity,
    required this.taskTitle,
    required this.id,
    required this.date,
    required this.department,
    required this.company,
    required this.startTime,
    required this.endTime,
    required this.status,
  });
}
