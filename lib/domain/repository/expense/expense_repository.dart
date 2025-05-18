import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/domain/entities/expense/expense_entities.dart';

abstract class ExpenseRepository {
  Future<Either<Failure, List<ExpenseEntities>>> getExpenses();
  Future<Either<Failure, ExpenseEntities>> submitExpense(ExpenseEntities expense);
}