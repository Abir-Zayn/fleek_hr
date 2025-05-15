/// Work From Home Model
library;

class WfhModel {
  final DateTime startDate;
  final DateTime endDate;
  final int totalDays;
  final String reason;

  WfhModel(
      {required this.startDate,
      required this.endDate,
      required this.totalDays,
      required this.reason});

  /// Creates an initial model with default values
  factory WfhModel.initial() {
    final now = DateTime.now();
    return WfhModel(
      startDate: now,
      endDate: now.add(const Duration(days: 1)),
      totalDays: 1,
      reason: '',
    );
  }

  /// Creates a copy with optional new values
  WfhModel copyWith({
    DateTime? startDate,
    DateTime? endDate,
    int? totalDays,
    String? reason,
  }) {
    return WfhModel(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalDays: totalDays ?? this.totalDays,
      reason: reason ?? this.reason,
    );
  }

  /// Converts model to JSON for API
  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'totalDays': totalDays,
      'reason': reason,
    };
  }
}
