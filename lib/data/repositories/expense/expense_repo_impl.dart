import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/data/service/expense/expense_service.dart';
import 'package:fleekhr/domain/entities/expense/expense_entity.dart';
import 'package:fleekhr/domain/repository/expense/expense_repo.dart';

class ExpenseRepoImpl implements ExpenseRepository {
  @override
  Future<Either<Failure, List<ExpenseEntity>>> getAllExpenses(
      String employeeId) async {
    return await sl<ExpenseAPIService>().getAllExpenses(employeeId);
  }

  @override
  Future<Either<Failure, ExpenseEntity>> getExpenseById(String id) async {
    return await sl<ExpenseAPIService>().getExpenseById(id);
  }

  @override
  Future<Either<Failure, ExpenseEntity>> createExpense(
      ExpenseEntity expenseRequest) async {
    return await sl<ExpenseAPIService>().createExpense(expenseRequest);
  }

  @override
  Future<Either<Failure, ExpenseEntity>> updateExpense(
      ExpenseEntity expenseRequest) async {
    return await sl<ExpenseAPIService>().updateExpense(expenseRequest);
  }

  @override
  Future<Either<Failure, void>> deleteExpense(String id) async {
    return await sl<ExpenseAPIService>().deleteExpense(id);
  }
}
