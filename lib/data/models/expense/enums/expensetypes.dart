enum ExpenseType {
  Travel,
  Meals,
  Supplies,
  Equipment,
  Entertainment,
  Utilities,
  Class,
}
extension ExpenseTypeExtension on ExpenseType {
  static ExpenseType fromString(String value) {
    return ExpenseType.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => ExpenseType.Travel,
    );
  }
}