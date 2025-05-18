//Represents the status of an expense request.
enum StatusType {
  accepted,
  pending,
  rejected,
}

class ExpenseEntities {
  /// Unique identifier for the expense
  final String id;
  final String purpose;
  final double amount;
  final DateTime date;
  final StatusType status;
  final String from;
  final String to;

  ExpenseEntities({
    required this.id,
    required this.purpose,
    required this.amount,
    required this.date,
    required this.status,
    this.from = "",
    this.to = "",
  });

  // creates a copy of this expense with the given fields replaced
  ExpenseEntities copyWith({
    String? id,
    String? purpose,
    double? amount,
    DateTime? date,
    StatusType? status,
    String? from,
    String? to,
  }) {
    return ExpenseEntities(
      id: id ?? this.id,
      purpose: purpose ?? this.purpose,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      status: status ?? this.status,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  // Converts an ExpenseEntities instance to a JSON map
  static StatusType statusFromString(String? status) {
    switch (status?.toLowerCase()) {
      case 'accepted':
        return StatusType.accepted;
      case 'pending':
        return StatusType.pending;
      case 'rejected':
        return StatusType.rejected;
      default:
        return StatusType.pending;
    }
  }

  ///Returns a String representation of the expense
  @override
  String toString() {
    return 'ExpenseEntities(id: $id, purpose: $purpose, amount: $amount, date: $date, status: $status, from: $from, to: $to)';
  }

  /// Checks if this expense is equal to another object
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseEntities &&
        other.id == id &&
        other.purpose == purpose &&
        other.amount == amount &&
        other.date == date &&
        other.status == status &&
        other.from == from &&
        other.to == to;
  }

  /// Generates a hash code for this expense
  @override
  int get hashCode {
    return id.hashCode ^
        purpose.hashCode ^
        amount.hashCode ^
        date.hashCode ^
        status.hashCode ^
        from.hashCode ^
        to.hashCode;
  }
}
