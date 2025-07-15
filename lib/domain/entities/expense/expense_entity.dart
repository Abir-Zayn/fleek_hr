import 'package:equatable/equatable.dart';
import 'package:fleekhr/data/models/expense/enums/expenseStatus.dart';
import 'package:fleekhr/data/models/expense/enums/expensetypes.dart';

class ExpenseEntity extends Equatable {
  final int id;
  final String employeeId;
  final ExpenseType expenseType;
  final String? from;
  final String? to;
  final double amount;
  final ExpenseStatus status;
  final String? description;

  const ExpenseEntity({
    required this.id,
    required this.employeeId,
    required this.expenseType,
    this.from,
    this.to,
    required this.amount,
    required this.status,
    this.description,
  });

  @override
  List<Object?> get props => [
        id,
        employeeId,
        expenseType,
        from,
        to,
        amount,
        status,
        description,
      ];
}
