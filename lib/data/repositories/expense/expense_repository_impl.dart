import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/data/models/expense/expense_model.dart';
import 'package:fleekhr/data/service/expense/expense_service.dart';
import 'package:fleekhr/domain/entities/expense/expense_entities.dart';
import 'package:fleekhr/domain/repository/expense/expense_repository.dart';

class ExpenseRepositoryImplementation extends ExpenseRepository {
  final ExpenseService expenseService;
  
  ExpenseRepositoryImplementation(this.expenseService);
  
  @override
  Future<Either<Failure, List<ExpenseEntities>>> getExpenses() async {
    // try {
    //   final result = await expenseService.getExpenses();
    //   return result.fold(
    //     (failure) => Left(failure),
    //     (expenseModels) {
    //       final expenseEntities = 
    //           expenseModels.map((model) => model.toEntity()).toList();
    //       return Right(expenseEntities);
    //     },
    //   );
    // } catch (e) {
    //   return Left(UnknownFailure('An unexpected error occurred: ${e.toString()}'));
    // }
    final result = await sl<ExpenseService>().getExpenses();
    return result.fold(
      (failure) => Left(failure),
      (expenseModels) => Right(expenseModels.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, ExpenseEntities>> submitExpense(ExpenseEntities expense) async {
    try {
      // Convert entity to model before sending to service
      final expenseModel = ExpenseModel.fromEntity(expense);
      
      // Send to service
      final result = await expenseService.submitExpense(expenseModel);
      
      // Convert result back to entity
      return result.fold(
        (failure) => Left(failure),
        (submittedModel) => Right(submittedModel.toEntity()),
      );
    } catch (e) {
      return Left(UnknownFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }
}