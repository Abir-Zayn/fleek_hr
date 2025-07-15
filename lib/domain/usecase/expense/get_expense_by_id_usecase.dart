import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/usecase/usecase.dart';

import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/domain/entities/expense/expense_entity.dart';
import 'package:fleekhr/domain/repository/expense/expense_repo.dart';

class GetExpenseByIdUsecase
    implements Usecase<Either<Failure, ExpenseEntity>, String> {
  final ExpenseRepository repository;

  GetExpenseByIdUsecase(this.repository);

  @override
  Future<Either<Failure, ExpenseEntity>> call({required String params}) async {
    return await repository.getExpenseById(params);
  }
}
