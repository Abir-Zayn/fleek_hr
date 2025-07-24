import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/domain/entities/attendance/daily_attendance_entity.dart';
import 'package:fleekhr/domain/entities/attendance/monthly_attendance_entity.dart';

abstract class AttendanceRepository {
  /// Refresh monthly attendance data by calling the nightly refresh function
  Future<Either<Failure, void>> refreshMonthlyAttendance();

  /// Check in employee for the current day
  Future<Either<Failure, DailyAttendanceEntity>> checkIn(String employeeId);

  /// Check out employee for the current day
  Future<Either<Failure, DailyAttendanceEntity>> checkOut(String employeeId);

  /// Get daily attendance records for a specific month
  Future<Either<Failure, List<DailyAttendanceEntity>>> getDailyAttendanceByMonth(
      String employeeId, String yearMonth);

  /// Get monthly attendance summary for a specific month
  Future<Either<Failure, MonthlyAttendanceEntity?>> getMonthlyAttendance(
      String employeeId, String yearMonth);

  /// Get today's attendance record for an employee
  Future<Either<Failure, DailyAttendanceEntity?>> getTodayAttendance(
      String employeeId);

  /// Get attendance history for an employee with optional limit
  Future<Either<Failure, List<DailyAttendanceEntity>>> getAttendanceHistory(
      String employeeId, {int limit = 30});

  /// Mark employee as on leave for a specific date
  Future<Either<Failure, DailyAttendanceEntity>> markOnLeave(
      String employeeId, DateTime date);

  /// Mark employee as absent for a specific date (admin function)
  Future<Either<Failure, DailyAttendanceEntity>> markAbsent(
      String employeeId, DateTime date);

  /// Get attendance statistics for an employee for a date range
  Future<Either<Failure, Map<String, int>>> getAttendanceStats(
      String employeeId, DateTime startDate, DateTime endDate);
}
