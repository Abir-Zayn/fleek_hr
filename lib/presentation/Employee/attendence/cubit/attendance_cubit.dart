import 'package:equatable/equatable.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/domain/entities/attendance/daily_attendance_entity.dart';
import 'package:fleekhr/domain/entities/attendance/monthly_attendance_entity.dart';
import 'package:fleekhr/domain/usecase/attendance/checkin_usecase.dart';
import 'package:fleekhr/domain/usecase/attendance/checkout_usecase.dart';
import 'package:fleekhr/domain/usecase/attendance/get_today_attendance_usecase.dart';
import 'package:fleekhr/domain/usecase/attendance/get_attendance_history_usecase.dart';
import 'package:fleekhr/domain/usecase/attendance/get_monthly_attendance_usecase.dart';
import 'package:fleekhr/domain/usecase/attendance/get_daily_attendance_by_month_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  // Use cases
  final CheckInUseCase _checkInUseCase = sl<CheckInUseCase>();
  final CheckOutUseCase _checkOutUseCase = sl<CheckOutUseCase>();
  final GetTodayAttendanceUseCase _getTodayAttendanceUseCase = sl<GetTodayAttendanceUseCase>();
  final GetAttendanceHistoryUseCase _getAttendanceHistoryUseCase = sl<GetAttendanceHistoryUseCase>();
  final GetMonthlyAttendanceUseCase _getMonthlyAttendanceUseCase = sl<GetMonthlyAttendanceUseCase>();
  final GetDailyAttendanceByMonthUseCase _getDailyAttendanceByMonthUseCase = sl<GetDailyAttendanceByMonthUseCase>();

  AttendanceCubit() : super(AttendanceInitial());

  // Cache for current user's data
  DailyAttendanceEntity? _todayAttendance;
  List<DailyAttendanceEntity>? _attendanceHistory;
  MonthlyAttendanceEntity? _monthlyAttendance;
  
  /// Get current user ID from Supabase auth
  String? get _currentUserId => Supabase.instance.client.auth.currentUser?.id;

  /// Load today's attendance for current user
  Future<void> loadTodayAttendance() async {
    final userId = _currentUserId;
    if (userId == null) {
      emit(AttendanceError('User not logged in'));
      return;
    }

    emit(AttendanceLoading());

    final result = await _getTodayAttendanceUseCase.call(params: userId);
    result.fold(
      (failure) => emit(AttendanceError(failure.message)),
      (todayAttendance) {
        _todayAttendance = todayAttendance;
        emit(TodayAttendanceLoaded(todayAttendance: todayAttendance));
      },
    );
  }

  /// Check in for current user
  Future<void> checkIn() async {
    final userId = _currentUserId;
    if (userId == null) {
      emit(AttendanceError('User not logged in'));
      return;
    }

    emit(AttendanceProcessing());

    final result = await _checkInUseCase.call(params: userId);
    result.fold(
      (failure) => emit(AttendanceError(failure.message)),
      (attendance) {
        _todayAttendance = attendance;
        emit(CheckInSuccess(attendance: attendance));
      },
    );
  }

  /// Check out for current user
  Future<void> checkOut() async {
    final userId = _currentUserId;
    if (userId == null) {
      emit(AttendanceError('User not logged in'));
      return;
    }

    // Check if user has checked in today
    if (_todayAttendance == null || !_todayAttendance!.hasCheckedIn) {
      emit(AttendanceError('You must check in first before checking out'));
      return;
    }

    emit(AttendanceProcessing());

    final result = await _checkOutUseCase.call(params: userId);
    result.fold(
      (failure) => emit(AttendanceError(failure.message)),
      (attendance) {
        _todayAttendance = attendance;
        emit(CheckOutSuccess(attendance: attendance));
      },
    );
  }

  /// Load attendance history for current user
  Future<void> loadAttendanceHistory({int limit = 30}) async {
    final userId = _currentUserId;
    if (userId == null) {
      emit(AttendanceError('User not logged in'));
      return;
    }

    emit(AttendanceLoading());

    final params = GetAttendanceHistoryParams(
      employeeId: userId,
      limit: limit,
    );

    final result = await _getAttendanceHistoryUseCase.call(params: params);
    result.fold(
      (failure) => emit(AttendanceError(failure.message)),
      (history) {
        _attendanceHistory = history;
        emit(AttendanceHistoryLoaded(history: history));
      },
    );
  }

  /// Load monthly attendance for current user
  Future<void> loadMonthlyAttendance(String yearMonth) async {
    final userId = _currentUserId;
    if (userId == null) {
      emit(AttendanceError('User not logged in'));
      return;
    }

    emit(AttendanceLoading());

    final params = GetMonthlyAttendanceParams(
      employeeId: userId,
      yearMonth: yearMonth,
    );

    final result = await _getMonthlyAttendanceUseCase.call(params: params);
    result.fold(
      (failure) => emit(AttendanceError(failure.message)),
      (monthlyAttendance) {
        _monthlyAttendance = monthlyAttendance;
        emit(MonthlyAttendanceLoaded(monthlyAttendance: monthlyAttendance));
      },
    );
  }

  /// Load daily attendance by month for current user
  Future<void> loadDailyAttendanceByMonth(String yearMonth) async {
    final userId = _currentUserId;
    if (userId == null) {
      emit(AttendanceError('User not logged in'));
      return;
    }

    emit(AttendanceLoading());

    final params = GetDailyAttendanceByMonthParams(
      employeeId: userId,
      yearMonth: yearMonth,
    );

    final result = await _getDailyAttendanceByMonthUseCase.call(params: params);
    result.fold(
      (failure) => emit(AttendanceError(failure.message)),
      (dailyAttendance) {
        emit(DailyAttendanceByMonthLoaded(dailyAttendance: dailyAttendance));
      },
    );
  }

  /// Load complete attendance dashboard data
  Future<void> loadHistoryTabData(String yearMonth) async {
    final userId = _currentUserId;
    if (userId == null) {
      emit(AttendanceError('User not logged in'));
      return;
    }

    emit(AttendanceLoading());

    try {
      final monthlyParams = GetMonthlyAttendanceParams(
        employeeId: userId,
        yearMonth: yearMonth,
      );
      final monthlyResult = await _getMonthlyAttendanceUseCase.call(params: monthlyParams);

      final dailyParams = GetDailyAttendanceByMonthParams(
        employeeId: userId,
        yearMonth: yearMonth,
      );
      final dailyResult = await _getDailyAttendanceByMonthUseCase.call(params: dailyParams);

      if (monthlyResult.isLeft() || dailyResult.isLeft()) {
        final error = monthlyResult.fold((l) => l.message, (r) => null) ??
            dailyResult.fold((l) => l.message, (r) => null) ??
            'Unknown error occurred';
        emit(AttendanceError(error));
        return;
      }

      final monthlyAttendance = monthlyResult.fold((l) => null, (r) => r);
      final dailyAttendance = dailyResult.fold((l) => <DailyAttendanceEntity>[], (r) => r);

      emit(AttendanceHistoryTabLoaded(
        monthlyAttendance: monthlyAttendance,
        dailyAttendance: dailyAttendance,
      ));
    } catch (e) {
      emit(AttendanceError('Failed to load history tab data: ${e.toString()}'));
    }
  }
  Future<void> loadAttendanceDashboard({String? yearMonth}) async {
    final userId = _currentUserId;
    if (userId == null) {
      emit(AttendanceError('User not logged in'));
      return;
    }

    emit(AttendanceLoading());

    try {
      // Get current month if not provided
      final currentMonth = yearMonth ?? 
          '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}';

      // Load today's attendance
      final todayResult = await _getTodayAttendanceUseCase.call(params: userId);
      
      // Load monthly attendance
      final monthlyParams = GetMonthlyAttendanceParams(
        employeeId: userId,
        yearMonth: currentMonth,
      );
      final monthlyResult = await _getMonthlyAttendanceUseCase.call(params: monthlyParams);
      
      // Load recent history
      final historyParams = GetAttendanceHistoryParams(
        employeeId: userId,
        limit: 7,
      );
      final historyResult = await _getAttendanceHistoryUseCase.call(params: historyParams);

      // Process results
      if (todayResult.isLeft() || monthlyResult.isLeft() || historyResult.isLeft()) {
        // Handle any failures
        final error = todayResult.fold((l) => l.message, (r) => null) ??
                     monthlyResult.fold((l) => l.message, (r) => null) ??
                     historyResult.fold((l) => l.message, (r) => null) ??
                     'Unknown error occurred';
        emit(AttendanceError(error));
        return;
      }

      // Extract successful results
      final todayAttendance = todayResult.fold((l) => null, (r) => r);
      final monthlyAttendance = monthlyResult.fold((l) => null, (r) => r);
      final recentHistory = historyResult.fold((l) => <DailyAttendanceEntity>[], (r) => r);

      _todayAttendance = todayAttendance;
      _monthlyAttendance = monthlyAttendance;
      _attendanceHistory = recentHistory;

      emit(AttendanceDashboardLoaded(
        todayAttendance: todayAttendance,
        monthlyAttendance: monthlyAttendance,
        recentHistory: recentHistory,
      ));

    } catch (e) {
      emit(AttendanceError('Failed to load dashboard: ${e.toString()}'));
    }
  }

  /// Refresh all attendance data
  Future<void> refreshAttendanceData() async {
    await loadAttendanceDashboard();
  }

  /// Get today's attendance status
  String getTodayStatus() {
    if (_todayAttendance == null) return 'Not checked in';
    
    if (_todayAttendance!.hasCheckedIn && !_todayAttendance!.hasCheckedOut) {
      return 'Checked in';
    } else if (_todayAttendance!.isCompleteAttendance) {
      return 'Day completed';
    } else {
      return _todayAttendance!.status;
    }
  }

  /// Check if user can check in
  bool canCheckIn() {
    return _todayAttendance == null || !_todayAttendance!.hasCheckedIn;
  }

  /// Check if user can check out
  bool canCheckOut() {
    return _todayAttendance != null && 
           _todayAttendance!.hasCheckedIn && 
           !_todayAttendance!.hasCheckedOut;
  }

  /// Get work duration for today
  String getTodayWorkDuration() {
    if (_todayAttendance?.workDuration != null) {
      return _todayAttendance!.workDurationFormatted;
    }
    return 'N/A';
  }

  /// Clear error state
  void clearError() {
    if (state is AttendanceError) {
      emit(AttendanceInitial());
    }
  }

  /// Reset to initial state
  void resetState() {
    _todayAttendance = null;
    _attendanceHistory = null;
    _monthlyAttendance = null;
    emit(AttendanceInitial());
  }

  // Getters for cached data
  DailyAttendanceEntity? get todayAttendance => _todayAttendance;
  List<DailyAttendanceEntity>? get attendanceHistory => _attendanceHistory;
  MonthlyAttendanceEntity? get monthlyAttendance => _monthlyAttendance;
}
