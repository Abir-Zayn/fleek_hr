import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/data/service/attendance/attendance_service.dart';
import 'package:fleekhr/domain/entities/attendance/daily_attendance_entity.dart';
import 'package:fleekhr/domain/entities/attendance/monthly_attendance_entity.dart';
import 'package:fleekhr/domain/repository/attendance/attendance_repository.dart';

class AttendanceRepoImpl extends AttendanceRepository {
  @override
  Future<Either<Failure, void>> refreshMonthlyAttendance() async {
    return await sl<AttendanceService>().refreshMonthlyAttendance();
  }

  @override
  Future<Either<Failure, DailyAttendanceEntity>> checkIn(String employeeId) async {
    return await sl<AttendanceService>().checkIn(employeeId);
  }

  @override
  Future<Either<Failure, DailyAttendanceEntity>> checkOut(String employeeId) async {
    return await sl<AttendanceService>().checkOut(employeeId);
  }

  @override
  Future<Either<Failure, List<DailyAttendanceEntity>>> getDailyAttendanceByMonth(
      String employeeId, String yearMonth) async {
    return await sl<AttendanceService>().getDailyAttendanceByMonth(employeeId, yearMonth);
  }

  @override
  Future<Either<Failure, MonthlyAttendanceEntity?>> getMonthlyAttendance(
      String employeeId, String yearMonth) async {
    return await sl<AttendanceService>().getMonthlyAttendance(employeeId, yearMonth);
  }

  @override
  Future<Either<Failure, DailyAttendanceEntity?>> getTodayAttendance(
      String employeeId) async {
    return await sl<AttendanceService>().getTodayAttendance(employeeId);
  }

  @override
  Future<Either<Failure, List<DailyAttendanceEntity>>> getAttendanceHistory(
      String employeeId, {int limit = 30}) async {
    return await sl<AttendanceService>().getAttendanceHistory(employeeId, limit: limit);
  }

  @override
  Future<Either<Failure, DailyAttendanceEntity>> markOnLeave(
      String employeeId, DateTime date) async {
    return await sl<AttendanceService>().markOnLeave(employeeId, date);
  }

  @override
  Future<Either<Failure, DailyAttendanceEntity>> markAbsent(
      String employeeId, DateTime date) async {
    return await sl<AttendanceService>().markAbsent(employeeId, date);
  }

  @override
  Future<Either<Failure, Map<String, int>>> getAttendanceStats(
      String employeeId, DateTime startDate, DateTime endDate) async {
    try {
      // Get daily attendance records for the date range
      final startYearMonth = '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}';
      final endYearMonth = '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}';
      
      // For now, get records for start month (this would need to be enhanced for multi-month ranges)
      final attendanceResult = await sl<AttendanceService>()
          .getDailyAttendanceByMonth(employeeId, startYearMonth);
      
      return attendanceResult.fold(
        (failure) => Left(failure),
        (attendanceList) {
          // Filter records within date range and calculate stats
          final filteredRecords = attendanceList.where((record) =>
              record.workDay.isAfter(startDate.subtract(const Duration(days: 1))) &&
              record.workDay.isBefore(endDate.add(const Duration(days: 1))));
          
          final stats = <String, int>{
            'working_days': 0,
            'on_time': 0,
            'late': 0,
            'left_timely': 0,
            'left_early': 0,
            'on_leave': 0,
            'absent': 0,
          };
          
          for (final record in filteredRecords) {
            switch (record.status) {
              case 'present':
                stats['working_days'] = (stats['working_days'] ?? 0) + 1;
                stats['on_time'] = (stats['on_time'] ?? 0) + 1;
                break;
              case 'late':
                stats['working_days'] = (stats['working_days'] ?? 0) + 1;
                stats['late'] = (stats['late'] ?? 0) + 1;
                break;
              case 'left_timely':
                stats['left_timely'] = (stats['left_timely'] ?? 0) + 1;
                break;
              case 'left_early':
                stats['left_early'] = (stats['left_early'] ?? 0) + 1;
                break;
              case 'on_leave':
                stats['on_leave'] = (stats['on_leave'] ?? 0) + 1;
                break;
              case 'absent':
                stats['absent'] = (stats['absent'] ?? 0) + 1;
                break;
            }
          }
          
          return Right(stats);
        },
      );
    } catch (e) {
      return Left(UnknownFailure('Error getting attendance stats: ${e.toString()}'));
    }
  }
}
