import 'package:fleekhr/data/models/expense/enums/expenseStatus.dart';
import 'package:fleekhr/data/models/expense/enums/expensetypes.dart';
import 'package:fleekhr/domain/entities/expense/expense_entity.dart';

class ExpenseModel {
  final int id;
  final String employeeId;
  final ExpenseType expenseType;
  final String? from;
  final String? to;
  final double amount;
  final ExpenseStatus status;
  final String? description;

  ExpenseModel({
    required this.id,
    required this.employeeId,
    required this.expenseType,
    this.from,
    this.to,
    required this.amount,
    required this.status,
    this.description,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] as int,
      employeeId: json['employee_id'] as String,
      expenseType: ExpenseTypeExtension.fromString(json['expense_type']),
      from: json['from'],
      to: json['to'],
      amount: (json['amount'] as num).toDouble(),
      status: ExpenseStatusExtension.fromString(json['status']),
      description: json['description'],
    );
  }

  // Changed from instance method to static factory constructor
  factory ExpenseModel.fromEntity(ExpenseEntity entity) {
    return ExpenseModel(
      id: entity.id,
      employeeId: entity.employeeId,
      expenseType: entity.expenseType,
      from: entity.from,
      to: entity.to,
      amount: entity.amount,
      status: entity.status,
      description: entity.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'expense_type': expenseType.name,
      'from': from,
      'to': to,
      'amount': amount,
      'status': status.name,
      'description': description,
    };
  }
}

extension ExpenseModelExtensions on ExpenseModel {
  ExpenseEntity toEntity() {
    return ExpenseEntity(
      id: id,
      employeeId: employeeId,
      expenseType: expenseType,
      from: from,
      to: to,
      amount: amount,
      status: status,
      description: description,
    );
  }
}
