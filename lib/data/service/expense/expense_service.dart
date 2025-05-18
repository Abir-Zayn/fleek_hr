import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/data/models/expense/expense_model.dart';
import 'package:flutter/material.dart';

abstract class ExpenseService {
  Future<Either<Failure, List<ExpenseModel>>> getExpenses();
  Future<Either<Failure, ExpenseModel>> submitExpense(ExpenseModel expense);
}

class ExpenseServiceImplementation extends ExpenseService {
  @override
   Future<Either<Failure, List<ExpenseModel>>> getExpenses() async {
    // Implementation for fetching expenses
    // This could involve making an API call or querying a database
    // For now, returning a placeholder value
    try {
      await Future.delayed(Duration(seconds: 1)); // Simulating network delay
      debugPrint('Fetching expenses...');
      final List<ExpenseModel> placeholderExpenses = [
        ExpenseModel.fromJson({
          'id': '1',
          'purpose': 'Team Lunch',
          'amount': '150.00',
          'date': '2025-05-15',
          'status': 'pending',
          'from': 'user123',
          'to': 'company'
        }),
      ];
      return Right(placeholderExpenses);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch expenses: ${e.toString()}'));
    }
  }

  @override
   Future<Either<Failure, ExpenseModel>> submitExpense(ExpenseModel expense) async {
    // Implementation for submitting an expense
    // This could involve making an API call or saving to a database
    // For now, returning a placeholder value
    return Right(expense);
  }
}
