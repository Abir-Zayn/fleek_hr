class WfhModel {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final String employeeName;
  final String employeeId;
  final String status;
  final int totalDays;
  final String reason;

  WfhModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.employeeName,
    required this.employeeId,
    this.status = 'Pending',
    required this.reason,
  }) : totalDays = endDate.difference(startDate).inDays + 1;

  // Factory constructor to create a WfhModel from JSON
  factory WfhModel.fromJson(Map<String, dynamic> json) {
    return WfhModel(
      id: json['id'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      employeeName: json['employeeName'] as String,
      employeeId: json['employeeId'] as String,
      status: json['status'] as String? ?? 'Pending',
      reason: json['reason'] as String? ?? '',
    );
  }

  // Convert WfhModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'employeeName': employeeName,
      'employeeId': employeeId,
      'status': status,
      'totalDays': totalDays,
      'reason': reason,
    };
  }

  // Copy with method to create a new instance with some properties changed
  WfhModel copyWith({
    String? id,
    DateTime? startDate,
    DateTime? endDate,
    String? employeeName,
    String? employeeId,
    String? status,
    String? reason,
  }) {
    return WfhModel(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      employeeName: employeeName ?? this.employeeName,
      employeeId: employeeId ?? this.employeeId,
      status: status ?? this.status,
      reason: reason ?? this.reason,
    );
  }
}
