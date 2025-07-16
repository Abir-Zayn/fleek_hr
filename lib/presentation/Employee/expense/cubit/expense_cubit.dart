import 'package:equatable/equatable.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/domain/entities/expense/expense_entity.dart';
import 'package:fleekhr/domain/usecase/expense/create_expense_usecase.dart';
import 'package:fleekhr/domain/usecase/expense/delete_expense_usecase.dart';
import 'package:fleekhr/domain/usecase/expense/get_all_expense_usecase.dart';
import 'package:fleekhr/domain/usecase/expense/get_expense_by_id_usecase.dart';
import 'package:fleekhr/domain/usecase/auth/getuser_usecase.dart';
import 'package:fleekhr/data/models/expense/enums/expenseStatus.dart';
import 'package:fleekhr/data/models/expense/enums/expensetypes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseCubit() : super(ExpenseInitial());

  List<ExpenseEntity>? _cachedList;

  final GetAllExpenseUsecase _getAllExpenseUsecase = sl<GetAllExpenseUsecase>();
  final GetExpenseByIdUsecase _getExpenseByIdUsecase =
      sl<GetExpenseByIdUsecase>();
  final CreateExpenseUsecase _createExpenseUsecase = sl<CreateExpenseUsecase>();
  final DeleteExpenseUsecase _deleteExpenseUsecase = sl<DeleteExpenseUsecase>();
  final GetUserUseCase _getUserUsecase = sl<GetUserUseCase>();

  /// Get all expenses for an employee
  Future<void> getAllExpenses(String employeeId) async {
    try {
      if (_cachedList == null || _cachedList!.isEmpty) {
        emit(ExpenseLoading());
      }

      // Add 1.1 seconds delay for UI loading state (loading all expense data cards)
      await Future.delayed(const Duration(milliseconds: 1100));

      final result = await _getAllExpenseUsecase.call(params: employeeId);

      result.fold(
        (failure) => emit(ExpenseError(message: failure.message)),
        (expenses) {
          _cachedList = expenses;
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

      // Simulate loading time for viewing single expense detail (500ms)
      await Future.delayed(const Duration(milliseconds: 500));

      final result = await _getExpenseByIdUsecase.call(params: expenseId);

      return result.fold(
        (failure) {
          emit(ExpenseError(message: failure.message));
          return null;
        },
        (expense) {
          if (_cachedList != null) {
            emit(ExpenseDetailSuccess(
              expense: expense,
              expenseList: _cachedList!,
            ));
          } else {
            emit(ExpenseDetailLoaded(expense: expense));
          }
          return expense;
        },
      );
    } catch (e) {
      emit(ExpenseError(message: 'Error fetching expense: ${e.toString()}'));
      return null;
    }
  }

  /// Create new expense
  Future<void> createExpense(ExpenseEntity expenseRequest) async {
    try {
      emit(ExpenseCreating());

      // Simulate adding expense data delay (500ms)
      await Future.delayed(const Duration(milliseconds: 500));

      // Get current user to retrieve employee name
      final userResult = await _getUserUsecase.call();

      await userResult.fold(
        (failure) async {
          emit(ExpenseError(
              message: 'Failed to get user data: ${failure.message}'));
        },
        (user) async {
          // Create expense with employee name and current timestamp
          final enrichedExpense = expenseRequest.copyWith(
            employeeName: user.name, // Set employee name from current user
            createdAt: DateTime.now(), // Set current timestamp
          );

          final result =
              await _createExpenseUsecase.call(params: enrichedExpense);

          result.fold(
            (failure) => emit(ExpenseError(message: failure.message)),
            (createdExpense) {
              emit(const ExpenseCreated(
                  message: 'Expense created successfully'));
              // Refresh the expense list after creating
              getAllExpenses(enrichedExpense.employeeId);
            },
          );
        },
      );
    } catch (e) {
      emit(ExpenseError(message: 'Error creating expense: ${e.toString()}'));
    }
  }

  /// Helper method to create expense request from UI inputs
  /// This method handles getting the current user's ID automatically
  Future<void> createExpenseFromUI({
    required ExpenseType expenseType,
    String? from,
    String? to,
    required double amount,
    required ExpenseStatus status,
    String? description,
  }) async {
    try {
      emit(ExpenseCreating());

      // Get current user to retrieve employee ID and name
      final userResult = await _getUserUsecase.call();

      await userResult.fold(
        (failure) async {
          emit(ExpenseError(
              message: 'Failed to get user data: ${failure.message}'));
        },
        (user) async {
          // Create expense request with current user's data
          final expenseRequest = ExpenseEntity.request(
            id: 0, // Will be auto-generated by the database
            employeeId: user.id,
            expenseType: expenseType,
            from: from,
            to: to,
            amount: amount,
            status: status,
            description: description,
          );

          // Create the expense (this will call the createExpense method above)
          await createExpense(expenseRequest);
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
          if (_cachedList != null) {
            _cachedList = _cachedList!
                .where((item) => item.id.toString() != expenseId)
                .toList();
            if (_cachedList!.isEmpty) {
              emit(const ExpenseEmpty(message: 'No expenses found'));
            } else {
              emit(ExpenseLoaded(
                expenses: _cachedList!,
                filteredExpenses: _cachedList!,
                currentFilter: 'All',
              ));
            }
          } else {
            emit(const ExpenseDeleted(message: 'Expense deleted successfully'));
            // Refresh the expense list after deletion
            getAllExpenses(employeeId);
          }
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

  /// Restore list state when navigating back from details
  void restoreListState() {
    if (_cachedList != null) {
      if (_cachedList!.isEmpty) {
        emit(const ExpenseEmpty(message: 'No expenses found'));
      } else {
        emit(ExpenseLoaded(
          expenses: _cachedList!,
          filteredExpenses: _cachedList!,
          currentFilter: 'All',
        ));
      }
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

  /// Get cached expense list
  List<ExpenseEntity>? get cachedExpenseList => _cachedList;
}
