import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/entities/expense/expense_entity.dart';
import 'package:fleekhr/domain/repository/expense/expense_repo.dart';


class GetAllExpenseUsecase
    implements Usecase<Either<Failure, List<ExpenseEntity>>, String> {
  final ExpenseRepository repository;
  GetAllExpenseUsecase(this.repository);

  @override
  Future<Either<Failure, List<ExpenseEntity>>> call(
      {required String params}) async {
    return await repository.getAllExpenses(params);
  }
}
