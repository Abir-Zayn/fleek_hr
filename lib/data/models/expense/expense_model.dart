import 'package:fleekhr/data/models/expense/enums/expenseStatus.dart';
import 'package:fleekhr/data/models/expense/enums/expensetypes.dart';
import 'package:fleekhr/domain/entities/expense/expense_entity.dart';

class ExpenseModel {
  final int id;
  final String employeeId;
  final String employeeName;
  final ExpenseType expenseType;
  final String? from;
  final String? to;
  final double amount;
  final ExpenseStatus status;
  final String? description;
  final DateTime createdAt;

  ExpenseModel({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.expenseType,
    this.from,
    this.to,
    required this.amount,
    required this.status,
    this.description,
    required this.createdAt,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] as int,
      employeeId: json['employee_id'] as String,
      employeeName: json['employee_name'] as String? ?? 'Unknown',
      expenseType: ExpenseTypeExtension.fromString(json['expense_type']),
      from: json['from'],
      to: json['to'],
      amount: (json['amount'] as num).toDouble(),
      status: ExpenseStatusExtension.fromString(json['status']),
      description: json['description'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  // Changed from instance method to static factory constructor
  factory ExpenseModel.fromEntity(ExpenseEntity entity) {
    return ExpenseModel(
      id: entity.id,
      employeeId: entity.employeeId,
      employeeName: entity.employeeName,
      expenseType: entity.expenseType,
      from: entity.from,
      to: entity.to,
      amount: entity.amount,
      status: entity.status,
      description: entity.description,
      createdAt: entity.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'employee_name': employeeName,
      'expense_type': expenseType.name,
      'from': from,
      'to': to,
      'amount': amount,
      'status': status.name,
      'description': description,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

extension ExpenseModelExtensions on ExpenseModel {
  ExpenseEntity toEntity() {
    return ExpenseEntity(
      id: id,
      employeeId: employeeId,
      employeeName: employeeName,
      expenseType: expenseType,
      from: from,
      to: to,
      amount: amount,
      status: status,
      description: description,
      createdAt: createdAt,
    );
  }
}
