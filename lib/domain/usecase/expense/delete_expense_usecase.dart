import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/repository/expense/expense_repo.dart';

class DeleteExpenseUsecase implements Usecase<Either<dynamic, void>, String> {
  final ExpenseRepository repository;

  DeleteExpenseUsecase(this.repository);

  @override
  Future<Either<dynamic, void>> call({required String params}) async {
    return await repository.deleteExpense(params);
  }
}
