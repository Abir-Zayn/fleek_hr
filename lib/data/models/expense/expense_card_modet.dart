class ExpenseCardData {
  final String id;
  final String employeeId;
  final String employeeName;
  final String status;
  final String purpose;
  final double amount;
  final DateTime date;

  ExpenseCardData({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.status,
    required this.purpose,
    required this.amount,
    required this.date,
  });
  
}