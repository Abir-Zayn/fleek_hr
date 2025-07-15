part of 'expense_cubit.dart';

sealed class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

final class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<ExpenseEntity> expenses;
  final List<ExpenseEntity> filteredExpenses;
  final String currentFilter;

  const ExpenseLoaded({
    required this.expenses,
    required this.filteredExpenses,
    required this.currentFilter,
  });

  @override
  List<Object> get props => [expenses, filteredExpenses, currentFilter];

  ExpenseLoaded copyWith({
    List<ExpenseEntity>? expenses,
    List<ExpenseEntity>? filteredExpenses,
    String? currentFilter,
  }) {
    return ExpenseLoaded(
      expenses: expenses ?? this.expenses,
      filteredExpenses: filteredExpenses ?? this.filteredExpenses,
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }
}

class ExpenseEmpty extends ExpenseState {
  final String message;

  const ExpenseEmpty({required this.message});

  @override
  List<Object> get props => [message];
}

class ExpenseDetailLoaded extends ExpenseState {
  final ExpenseEntity expense;

  const ExpenseDetailLoaded({required this.expense});

  @override
  List<Object> get props => [expense];
}

class ExpenseError extends ExpenseState {
  final String message;

  const ExpenseError({required this.message});

  @override
  List<Object> get props => [message];
}

class ExpenseCreating extends ExpenseState {}

class ExpenseCreated extends ExpenseState {
  final String message;

  const ExpenseCreated({required this.message});

  @override
  List<Object> get props => [message];
}

class ExpenseDeleting extends ExpenseState {
  final String expenseId;

  const ExpenseDeleting({required this.expenseId});

  @override
  List<Object> get props => [expenseId];
}

class ExpenseDeleted extends ExpenseState {
  final String message;

  const ExpenseDeleted({required this.message});

  @override
  List<Object> get props => [message];
}
