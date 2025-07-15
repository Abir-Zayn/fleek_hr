import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/entities/expense/expense_entity.dart';
import 'package:fleekhr/domain/repository/expense/expense_repo.dart';


class CreateExpenseUsecase
    implements
        Usecase<Either<Failure, ExpenseEntity>, ExpenseEntity> {
  final ExpenseRepository repository;
  CreateExpenseUsecase(this.repository);

  @override
  Future<Either<Failure, ExpenseEntity>> call(
      {required ExpenseEntity params}) async {
    return await repository.createExpense(params);
  }
}
