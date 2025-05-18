// domain/usecase/expense/get_expense_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/entities/expense/expense_entities.dart';
import 'package:fleekhr/domain/repository/expense/expense_repository.dart';

class GetExpenseUseCase implements Usecase<List<ExpenseEntities>, NoParams> {
  final ExpenseRepository repository;

  GetExpenseUseCase(this.repository);

  @override
  Future<Either<Failure, List<ExpenseEntities>>> call(NoParams params) async {
    return await repository.getExpenses();
  }
}