enum LeaveType {
  annual,
  sick,
  maternity,
  vacation,
  bereavement,
  casual,
  leaveWithoutPay;

  /// Converts a string from the database to a LeaveType enum member.
  factory LeaveType.fromString(String value) {
    switch (value) {
      case 'Annual':
        return LeaveType.annual;
      case 'Sick':
        return LeaveType.sick;
      case 'Maternity':
        return LeaveType.maternity;
      case 'Vacation':
        return LeaveType.vacation;
      case 'Bereavement':
        return LeaveType.bereavement;
      case 'Casual':
        return LeaveType.casual;
      case 'Leave Without Pay':
        return LeaveType.leaveWithoutPay;
      default:
        throw ArgumentError('Unknown LeaveType: $value');
    }
  }

  /// Converts a LeaveType enum member to a string for the database.
  String toJson() {
    switch (this) {
      case LeaveType.annual:
        return 'Annual';
      case LeaveType.sick:
        return 'Sick';
      case LeaveType.maternity:
        return 'Maternity';
      case LeaveType.vacation:
        return 'Vacation';
      case LeaveType.bereavement:
        return 'Bereavement';
      case LeaveType.casual:
        return 'Casual';
      case LeaveType.leaveWithoutPay:
        return 'Leave Without Pay';
    }
  }

  String get value => toJson();
}
