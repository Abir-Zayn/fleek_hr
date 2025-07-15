enum ExpenseStatus {
  Pending,
  Approved,
  Reject,
}

extension ExpenseStatusExtension on ExpenseStatus {
  static ExpenseStatus fromString(String value) {
    return ExpenseStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => ExpenseStatus.Pending,
    );
  }
}
