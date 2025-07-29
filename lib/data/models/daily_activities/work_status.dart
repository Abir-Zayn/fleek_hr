enum WorkStatus {
  progress,
  complete,
  reviewed,
  refactoring,
  removal;

  String get displayName {
    switch (this) {
      case WorkStatus.progress:
        return 'In Progress';
      case WorkStatus.complete:
        return 'Complete';
      case WorkStatus.reviewed:
        return 'Reviewed';
      case WorkStatus.refactoring:
        return 'Refactoring';
      case WorkStatus.removal:
        return 'Removal';
    }
  }
}