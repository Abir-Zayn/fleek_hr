import 'package:fleekhr/domain/entities/expense/expense_entities.dart';

// Using the StatusType from entities instead of defining it again

class ExpenseModel {
  final String id;
  final String purpose;
  final double amount;
  final DateTime date;
  final StatusType status;
  final String from;
  final String to;

  ExpenseModel({
    required this.id,
    required this.purpose,
    required this.amount,
    required this.date,
    required this.status,
    required this.from,
    required this.to,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] ?? '',
      purpose: json['purpose'] ?? '',
      // Parse amount as double
      amount: json['amount'] is String
          ? double.tryParse(json['amount']) ?? 0.0
          : (json['amount'] ?? 0.0),
      // Parse date from string
      date: json['date'] is String
          ? DateTime.tryParse(json['date']) ?? DateTime.now()
          : (json['date'] ?? DateTime.now()),
      status: _statusFromString(json['status']),
      from: json['from'] ?? '',
      to: json['to'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'purpose': purpose,
      'amount': amount,
      // Convert DateTime to ISO string format for consistent serialization
      'date': date.toIso8601String(),
      'status': status.toString().split('.').last,
      'from': from,
      'to': to,
    };
  }

  // Convert model to entity for domain layer usage
  ExpenseEntities toEntity() {
    return ExpenseEntities(
      id: id,
      purpose: purpose,
      amount: amount,
      date: date,
      status: status,
      from: from,
      to: to,
    );
  }

  // Create model from entity
  factory ExpenseModel.fromEntity(ExpenseEntities entity) {
    return ExpenseModel(
      id: entity.id,
      purpose: entity.purpose,
      amount: entity.amount,
      date: entity.date,
      status: entity.status,
      from: entity.from,
      to: entity.to,
    );
  }

  static StatusType _statusFromString(String? status) {
    // Consider using the one from ExpenseEntities instead
    return ExpenseEntities.statusFromString(status);
  }
}
