part of 'attendance_cubit.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object?> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceProcessing extends AttendanceState {}

class AttendanceError extends AttendanceState {
  final String message;

  const AttendanceError(this.message);

  @override
  List<Object?> get props => [message];
}

// Today's attendance states
class TodayAttendanceLoaded extends AttendanceState {
  final DailyAttendanceEntity? todayAttendance;

  const TodayAttendanceLoaded({required this.todayAttendance});

  @override
  List<Object?> get props => [todayAttendance];
}

// Check in/out success states
class CheckInSuccess extends AttendanceState {
  final DailyAttendanceEntity attendance;

  const CheckInSuccess({required this.attendance});

  @override
  List<Object?> get props => [attendance];
}

class CheckOutSuccess extends AttendanceState {
  final DailyAttendanceEntity attendance;

  const CheckOutSuccess({required this.attendance});

  @override
  List<Object?> get props => [attendance];
}

// History states
class AttendanceHistoryLoaded extends AttendanceState {
  final List<DailyAttendanceEntity> history;

  const AttendanceHistoryLoaded({required this.history});

  @override
  List<Object?> get props => [history];
}

// Monthly attendance states
class MonthlyAttendanceLoaded extends AttendanceState {
  final MonthlyAttendanceEntity? monthlyAttendance;

  const MonthlyAttendanceLoaded({required this.monthlyAttendance});

  @override
  List<Object?> get props => [monthlyAttendance];
}

// Daily attendance by month
class DailyAttendanceByMonthLoaded extends AttendanceState {
  final List<DailyAttendanceEntity> dailyAttendance;

  const DailyAttendanceByMonthLoaded({required this.dailyAttendance});

  @override
  List<Object?> get props => [dailyAttendance];
}

class AttendanceHistoryTabLoaded extends AttendanceState {
  final MonthlyAttendanceEntity? monthlyAttendance;
  final List<DailyAttendanceEntity> dailyAttendance;

  const AttendanceHistoryTabLoaded({
    required this.monthlyAttendance,
    required this.dailyAttendance,
  });

  @override
  List<Object?> get props => [monthlyAttendance, dailyAttendance];
}

// Dashboard state with all data loaded
class AttendanceDashboardLoaded extends AttendanceState {
  final DailyAttendanceEntity? todayAttendance;
  final MonthlyAttendanceEntity? monthlyAttendance;
  final List<DailyAttendanceEntity> recentHistory;

  const AttendanceDashboardLoaded({
    required this.todayAttendance,
    required this.monthlyAttendance,
    required this.recentHistory,
  });

  @override
  List<Object?> get props => [todayAttendance, monthlyAttendance, recentHistory];

  // Helper methods for UI
  bool get hasCheckedInToday => todayAttendance?.hasCheckedIn ?? false;
  bool get hasCheckedOutToday => todayAttendance?.hasCheckedOut ?? false;
  bool get canCheckIn => !hasCheckedInToday;
  bool get canCheckOut => hasCheckedInToday && !hasCheckedOutToday;
  
  String get todayStatus {
    if (todayAttendance == null) return 'Not checked in';
    
    if (hasCheckedInToday && !hasCheckedOutToday) {
      return 'Checked in';
    } else if (todayAttendance!.isCompleteAttendance) {
      return 'Day completed';
    } else {
      return todayAttendance!.status;
    }
  }

  String get todayWorkDuration {
    return todayAttendance?.workDurationFormatted ?? 'N/A';
  }

  // Monthly stats helper methods
  int get monthlyPresentDays => (monthlyAttendance?.onTime ?? 0) + (monthlyAttendance?.late ?? 0);
  int get monthlyAbsentDays => monthlyAttendance?.absent ?? 0;
  int get monthlyLateDays => monthlyAttendance?.late ?? 0;
  int get monthlyOnLeaveDays => monthlyAttendance?.onLeave ?? 0;
  int get monthlyWorkingDays => monthlyAttendance?.workingDays ?? 0;
  
  double get attendancePercentage {
    if (monthlyWorkingDays == 0) return 0.0;
    return (monthlyPresentDays / monthlyWorkingDays) * 100;
  }
}
