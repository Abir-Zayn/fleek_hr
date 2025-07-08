/// Enum representing the duration of a leave.
/// Corresponds to the 'duration_type_enum' in the database.
enum DurationType {
  fullDay,
  halfDay;

  /// Converts a string from the database to a DurationType enum member.
  factory DurationType.fromString(String value) {
    switch (value) {
      case 'Full Day':
        return DurationType.fullDay;
      case 'Half Day':
        return DurationType.halfDay;
      default:
        throw ArgumentError('Unknown DurationType: $value');
    }
  }

  /// Converts a DurationType enum member to a string for the database.
  String toJson() {
    switch (this) {
      case DurationType.fullDay:
        return 'Full Day';
      case DurationType.halfDay:
        return 'Half Day';
    }
  }

  String get value => toJson();
}
