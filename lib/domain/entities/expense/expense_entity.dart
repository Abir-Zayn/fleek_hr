import 'package:equatable/equatable.dart';
import 'package:fleekhr/data/models/expense/enums/expenseStatus.dart';
import 'package:fleekhr/data/models/expense/enums/expensetypes.dart';

class ExpenseEntity extends Equatable {
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

  const ExpenseEntity({
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

  /// Factory constructor for creating expense requests from UI
  /// Employee name and created timestamp will be set by the cubit
  factory ExpenseEntity.request({
    required int id,
    required String employeeId,
    required ExpenseType expenseType,
    String? from,
    String? to,
    required double amount,
    required ExpenseStatus status,
    String? description,
  }) {
    return ExpenseEntity(
      id: id,
      employeeId: employeeId,
      employeeName: '', // Will be populated by cubit
      expenseType: expenseType,
      from: from,
      to: to,
      amount: amount,
      status: status,
      description: description,
      createdAt:
          DateTime.now(), // Default timestamp, will be overridden by cubit
    );
  }

  /// Copy with method for creating modified instances
  ExpenseEntity copyWith({
    int? id,
    String? employeeId,
    String? employeeName,
    ExpenseType? expenseType,
    String? from,
    String? to,
    double? amount,
    ExpenseStatus? status,
    String? description,
    DateTime? createdAt,
  }) {
    return ExpenseEntity(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      expenseType: expenseType ?? this.expenseType,
      from: from ?? this.from,
      to: to ?? this.to,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        employeeId,
        employeeName,
        expenseType,
        from,
        to,
        amount,
        status,
        description,
        createdAt,
      ];
}
