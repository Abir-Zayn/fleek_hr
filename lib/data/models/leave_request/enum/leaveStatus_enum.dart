/// Enum representing the status of a leave request.
/// Corresponds to the 'leave_status_enum' in the database.
enum LeaveStatus {
  pending,
  approved,
  rejected;

  /// Converts a string from the database to a LeaveStatus enum member.
  factory LeaveStatus.fromString(String value) {
    switch (value) {
      case 'Pending':
        return LeaveStatus.pending;
      case 'Approved':
        return LeaveStatus.approved;
      case 'Rejected':
        return LeaveStatus.rejected;
      default:
        throw ArgumentError('Unknown LeaveStatus: $value');
    }
  }

  /// Converts a LeaveStatus enum member to a string for the database.
  String toJson() {
    switch (this) {
      case LeaveStatus.pending:
        return 'Pending';
      case LeaveStatus.approved:
        return 'Approved';
      case LeaveStatus.rejected:
        return 'Rejected';
    }
  }

  String get value => toJson();
}
