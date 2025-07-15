import 'package:equatable/equatable.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/domain/entities/expense/expense_entity.dart';
import 'package:fleekhr/domain/usecase/expense/create_expense_usecase.dart';
import 'package:fleekhr/domain/usecase/expense/delete_expense_usecase.dart';
import 'package:fleekhr/domain/usecase/expense/get_all_expense_usecase.dart';
import 'package:fleekhr/domain/usecase/expense/get_expense_by_id_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseCubit() : super(ExpenseInitial());

  final GetAllExpenseUsecase _getAllExpenseUsecase = sl<GetAllExpenseUsecase>();
  final GetExpenseByIdUsecase _getExpenseByIdUsecase =
      sl<GetExpenseByIdUsecase>();
  final CreateExpenseUsecase _createExpenseUsecase = sl<CreateExpenseUsecase>();
  final DeleteExpenseUsecase _deleteExpenseUsecase = sl<DeleteExpenseUsecase>();

  /// Get all expenses for an employee
  Future<void> getAllExpenses(String employeeId) async {
    try {
      emit(ExpenseLoading());

      // Add 1.2 seconds delay for UI loading state
      await Future.delayed(const Duration(milliseconds: 1200));

      final result = await _getAllExpenseUsecase.call(params: employeeId);

      result.fold(
        (failure) => emit(ExpenseError(message: failure.message)),
        (expenses) {
          if (expenses.isEmpty) {
            emit(const ExpenseEmpty(message: 'No expenses found'));
          } else {
            emit(ExpenseLoaded(
              expenses: expenses,
              filteredExpenses: expenses,
              currentFilter: 'All',
            ));
          }
        },
      );
    } catch (e) {
      emit(ExpenseError(
          message: 'An unexpected error occurred: ${e.toString()}'));
    }
  }

  /// Filter expenses by status
  void filterExpenses(String filter) {
    try {
      final currentState = state;
      if (currentState is ExpenseLoaded) {
        List<ExpenseEntity> filteredExpenses;

        if (filter == 'All') {
          filteredExpenses = currentState.expenses;
        } else {
          filteredExpenses = currentState.expenses.where((expense) {
            return expense.status.name.toLowerCase() == filter.toLowerCase();
          }).toList();
        }

        emit(currentState.copyWith(
          filteredExpenses: filteredExpenses,
          currentFilter: filter,
        ));
      }
    } catch (e) {
      emit(ExpenseError(message: 'Error filtering expenses: ${e.toString()}'));
    }
  }

  /// Get expense by ID
  Future<ExpenseEntity?> getExpenseById(String expenseId) async {
    try {
      emit(ExpenseLoading());

      final result = await _getExpenseByIdUsecase.call(params: expenseId);

      return result.fold(
        (failure) {
          emit(ExpenseError(message: failure.message));
          return null;
        },
        (expense) {
          emit(ExpenseDetailLoaded(expense: expense));
          return expense;
        },
      );
    } catch (e) {
      emit(ExpenseError(message: 'Error fetching expense: ${e.toString()}'));
      return null;
    }
  }

  /// Create new expense
  Future<void> createExpense(ExpenseEntity expense) async {
    try {
      emit(ExpenseCreating());

      final result = await _createExpenseUsecase.call(params: expense);

      result.fold(
        (failure) => emit(ExpenseError(message: failure.message)),
        (createdExpense) {
          emit(const ExpenseCreated(message: 'Expense created successfully'));
          // Refresh the expense list after creating
          getAllExpenses(expense.employeeId);
        },
      );
    } catch (e) {
      emit(ExpenseError(message: 'Error creating expense: ${e.toString()}'));
    }
  }

  /// Delete expense
  Future<void> deleteExpense(String expenseId, String employeeId) async {
    try {
      emit(ExpenseDeleting(expenseId: expenseId));

      final result = await _deleteExpenseUsecase.call(params: expenseId);

      result.fold(
        (failure) => emit(ExpenseError(message: failure.message)),
        (_) {
          emit(const ExpenseDeleted(message: 'Expense deleted successfully'));
          // Refresh the expense list after deletion
          getAllExpenses(employeeId);
        },
      );
    } catch (e) {
      emit(ExpenseError(message: 'Error deleting expense: ${e.toString()}'));
    }
  }

  /// Refresh expense list
  Future<void> refreshExpenses(String employeeId) async {
    try {
      // Don't emit loading state for refresh to avoid UI flickering
      final result = await _getAllExpenseUsecase.call(params: employeeId);

      result.fold(
        (failure) => emit(ExpenseError(message: failure.message)),
        (expenses) {
          if (expenses.isEmpty) {
            emit(const ExpenseEmpty(message: 'No expenses found'));
          } else {
            emit(ExpenseLoaded(
              expenses: expenses,
              filteredExpenses: expenses,
              currentFilter: 'All',
            ));
          }
        },
      );
    } catch (e) {
      emit(ExpenseError(message: 'Error refreshing expenses: ${e.toString()}'));
    }
  }

  /// Reset to initial state
  void resetState() {
    emit(ExpenseInitial());
  }

  /// Clear error state
  void clearError() {
    if (state is ExpenseError) {
      emit(ExpenseInitial());
    }
  }
}
