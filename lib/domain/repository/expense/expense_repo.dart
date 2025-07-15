import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/domain/entities/expense/expense_entity.dart';

abstract class ExpenseRepository {
  Future<Either<Failure, List<ExpenseEntity>>> getAllExpenses(String employeeId);

  Future<Either<Failure, ExpenseEntity>> getExpenseById(String id);

  Future<Either<Failure, ExpenseEntity>> createExpense(ExpenseEntity expense);

  Future<Either<Failure, ExpenseEntity>> updateExpense(ExpenseEntity expense);

  Future<Either<Failure, void>> deleteExpense(String id);
}