enum WorkType {
  newTask,
  oldTask;

  String get displayName {
    switch (this) {
      case WorkType.newTask:
        return 'New';
      case WorkType.oldTask:
        return 'Old';
    }
  }
}
