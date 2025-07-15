import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/data/models/expense/enums/expenseStatus.dart';
import 'package:fleekhr/data/models/expense/expense_model.dart';
import 'package:fleekhr/domain/entities/expense/expense_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ExpenseAPIService {
  //expense related methods
  Future<Either<Failure, List<ExpenseEntity>>> getAllExpenses(
      String employeeId);
  Future<Either<Failure, ExpenseEntity>> getExpenseById(String id);
  Future<Either<Failure, ExpenseEntity>> createExpense(ExpenseEntity expense);
  Future<Either<Failure, void>> deleteExpense(String id);
  Future<Either<Failure, ExpenseEntity>> updateExpense(ExpenseEntity expense);
}

class ExpenseServiceImpl implements ExpenseAPIService {
  final SupabaseClient _supabaseClient;
  static const String _tableName = 'expense';

  ExpenseServiceImpl(this._supabaseClient);

  @override
  Future<Either<Failure, List<ExpenseEntity>>> getAllExpenses(
      String employeeId) async {
    // Fetch all expense for the employee

    try {
      final response = await _supabaseClient
          .from(_tableName)
          .select()
          .eq('employee_id', employeeId);

      final List<ExpenseEntity> expenses = (response as List)
          .map((json) => ExpenseModel.fromJson(json).toEntity())
          .toList();
      return Right(expenses);
    } on PostgrestException catch (e) {
      return Left(ServerFailure('Database error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ExpenseEntity>> getExpenseById(String id) async {
    // Fetch a specific expense by ID
    try {
      final response = await _supabaseClient
          .from(_tableName)
          .select('*')
          .eq('id', id)
          .single();

      final expense = ExpenseModel.fromJson(response).toEntity();
      return Right(expense);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        return Left(NotFoundFailure('Expense not found'));
      }
      return Left(ServerFailure('Database error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ExpenseEntity>> createExpense(
      ExpenseEntity expense) async {
    // Prepare data for creation
    try {
      final expenseModel = ExpenseModel.fromEntity(expense);
      final data = expenseModel.toJson();

      // Remove id for insertion as it should be auto-generated
      data.remove('id');

      final response =
          await _supabaseClient.from(_tableName).insert(data).select().single();

      final createdExpense = ExpenseModel.fromJson(response).toEntity();
      return Right(createdExpense);
    } on PostgrestException catch (e) {
      return Left(ServerFailure('Database error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense(String id) async {
    try {
      // First check if expense exists and is not approved
      final checkResponse = await _supabaseClient
          .from(_tableName)
          .select('status')
          .eq('id', id)
          .single();

      final status = ExpenseStatusExtension.fromString(checkResponse['status']);

      if (status == ExpenseStatus.Approved) {
        return Left(UnauthorizedFailure('Cannot delete approved expense'));
      }

      await _supabaseClient.from(_tableName).delete().eq('id', id);

      return const Right(null);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        return Left(NotFoundFailure('Expense not found'));
      }
      return Left(ServerFailure('Database error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  // NOT PROPERLY IMPLEMENTED UPDATE METHOD
  @override
  Future<Either<Failure, ExpenseEntity>> updateExpense(
      ExpenseEntity expense) async {
    try {
      final expenseModel = ExpenseModel.fromEntity(expense);
      final data = expenseModel.toJson();

      // Ensure the ID is present for the update
      if (data['id'] == null) {
        return Left(UnauthorizedFailure('Expense ID is required for update'));
      }

      final response = await _supabaseClient
          .from(_tableName)
          .update(data)
          .eq('id', data['id'])
          .select()
          .single();

      final updatedExpense = ExpenseModel.fromJson(response).toEntity();
      return Right(updatedExpense);
    } on PostgrestException catch (e) {
      return Left(ServerFailure('Database error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
