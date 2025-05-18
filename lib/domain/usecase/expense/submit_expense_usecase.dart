import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/entities/expense/expense_entities.dart';
import 'package:fleekhr/domain/repository/expense/expense_repository.dart';
import 'package:equatable/equatable.dart';

class SubmitExpenseParams extends Equatable {
  final ExpenseEntities expense;

  const SubmitExpenseParams({required this.expense});

  @override
  List<Object?> get props => [expense];
}

class SubmitExpenseUsecase implements Usecase<void, SubmitExpenseParams> {
  final ExpenseRepository repository;

  SubmitExpenseUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitExpenseParams params) async {
    return await repository.submitExpense(params.expense);
  }
}