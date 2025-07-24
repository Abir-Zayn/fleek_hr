import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/data/models/attendance/daily_attendance.dart';
import 'package:fleekhr/data/models/attendance/monthly_attendance.dart';
import 'package:fleekhr/domain/entities/attendance/daily_attendance_entity.dart';
import 'package:fleekhr/domain/entities/attendance/monthly_attendance_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AttendanceService {
  Future<Either<Failure, void>> refreshMonthlyAttendance();
  Future<Either<Failure, DailyAttendanceEntity>> checkIn(String employeeId);
  Future<Either<Failure, DailyAttendanceEntity>> checkOut(String employeeId);
  Future<Either<Failure, List<DailyAttendanceEntity>>> getDailyAttendanceByMonth(
      String employeeId, String yearMonth);
  Future<Either<Failure, MonthlyAttendanceEntity?>> getMonthlyAttendance(
      String employeeId, String yearMonth);
  Future<Either<Failure, DailyAttendanceEntity?>> getTodayAttendance(
      String employeeId);
  Future<Either<Failure, List<DailyAttendanceEntity>>> getAttendanceHistory(
      String employeeId, {int limit = 30});
  Future<Either<Failure, DailyAttendanceEntity>> markOnLeave(
      String employeeId, DateTime date);
  Future<Either<Failure, DailyAttendanceEntity>> markAbsent(
      String employeeId, DateTime date);
}

class AttendanceServiceImplementation implements AttendanceService {
  final SupabaseClient _supabaseClient;

  AttendanceServiceImplementation(this._supabaseClient);

  @override
  Future<Either<Failure, void>> refreshMonthlyAttendance() async {
    try {
      // Call the PostgreSQL function for nightly refresh
      await _supabaseClient.rpc('refresh_monthly_attendance');
      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(ServerFailure('Database error during refresh: ${e.message}'));
    } catch (e) {
      return Left(UnknownFailure('Refresh error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, DailyAttendanceEntity>> checkIn(String employeeId) async {
    try {
      final today = DateTime.now();
      final todayString = today.toIso8601String().split('T')[0];

      // Check if already checked in today
      final existingResponse = await _supabaseClient
          .from('daily_attendance')
          .select()
          .eq('employee_id', employeeId)
          .eq('work_day', todayString)
          .maybeSingle();

      if (existingResponse != null) {
        // Update existing record with check-in time
        final currentTime = DateTime.now();
        final timeString = '${currentTime.hour.toString().padLeft(2, '0')}:'
            '${currentTime.minute.toString().padLeft(2, '0')}:'
            '${currentTime.second.toString().padLeft(2, '0')}';

        // Determine status based on check-in time (9:00 AM cutoff)
        final lateThreshold = DateTime(today.year, today.month, today.day, 9, 0);
        final status = currentTime.isAfter(lateThreshold) ? 'late' : 'present';

        final updateResponse = await _supabaseClient
            .from('daily_attendance')
            .update({
              'check_in': timeString,
              'status': status,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('employee_id', employeeId)
            .eq('work_day', todayString)
            .select()
            .single();

        final model = DailyAttendanceModel.fromJson(updateResponse);
        return Right(model.toEntity());
      } else {
        // Create new attendance record
        final currentTime = DateTime.now();
        final timeString = '${currentTime.hour.toString().padLeft(2, '0')}:'
            '${currentTime.minute.toString().padLeft(2, '0')}:'
            '${currentTime.second.toString().padLeft(2, '0')}';

        // Determine status based on check-in time
        final lateThreshold = DateTime(today.year, today.month, today.day, 9, 0);
        final status = currentTime.isAfter(lateThreshold) ? 'late' : 'present';

        // Check if today is weekend for this employee
        final employeeResponse = await _supabaseClient
            .from('employees')
            .select('weekend')
            .eq('id', employeeId)
            .single();

        final employeeWeekend = employeeResponse['weekend'] as String? ?? 'Friday';
        final isWeekend = _isWeekend(today, employeeWeekend);

        final insertResponse = await _supabaseClient
            .from('daily_attendance')
            .insert({
              'employee_id': employeeId,
              'work_day': todayString,
              'check_in': timeString,
              'status': isWeekend ? 'weekend' : status,
              'is_weekend': isWeekend,
              'is_leave': false,
              'created_at': DateTime.now().toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
            })
            .select()
            .single();

        final model = DailyAttendanceModel.fromJson(insertResponse);
        return Right(model.toEntity());
      }
    } on PostgrestException catch (e) {
      return Left(ServerFailure('Database error during check-in: ${e.message}'));
    } catch (e) {
      return Left(UnknownFailure('Check-in error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, DailyAttendanceEntity>> checkOut(String employeeId) async {
    try {
      final today = DateTime.now();
      final todayString = today.toIso8601String().split('T')[0];

      // Find today's attendance record
      final existingResponse = await _supabaseClient
          .from('daily_attendance')
          .select()
          .eq('employee_id', employeeId)
          .eq('work_day', todayString)
          .single();

      final currentTime = DateTime.now();
      final timeString = '${currentTime.hour.toString().padLeft(2, '0')}:'
          '${currentTime.minute.toString().padLeft(2, '0')}:'
          '${currentTime.second.toString().padLeft(2, '0')}';

      // Determine checkout status (4:50 PM cutoff for timely departure)
      final timelyThreshold = DateTime(today.year, today.month, today.day, 16, 50);
      final currentStatus = existingResponse['status'] as String;
      
      String newStatus;
      if (currentStatus == 'weekend' || currentStatus == 'on_leave') {
        newStatus = currentStatus; // Keep weekend/leave status
      } else if (currentTime.isBefore(timelyThreshold)) {
        newStatus = 'left_early';
      } else {
        newStatus = 'left_timely';
      }

      final updateResponse = await _supabaseClient
          .from('daily_attendance')
          .update({
            'check_out': timeString,
            'status': newStatus,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('employee_id', employeeId)
          .eq('work_day', todayString)
          .select()
          .single();

      final model = DailyAttendanceModel.fromJson(updateResponse);
      return Right(model.toEntity());
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        return Left(NotFoundFailure('No check-in record found for today'));
      }
      return Left(ServerFailure('Database error during check-out: ${e.message}'));
    } catch (e) {
      return Left(UnknownFailure('Check-out error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<DailyAttendanceEntity>>> getDailyAttendanceByMonth(
      String employeeId, String yearMonth) async {
    try {
      final response = await _supabaseClient
          .from('daily_attendance')
          .select()
          .eq('employee_id', employeeId)
          .gte('work_day', '$yearMonth-01')
          .lt('work_day', _getNextMonth(yearMonth))
          .order('work_day', ascending: true);

      final models = (response as List)
          .map((json) => DailyAttendanceModel.fromJson(json))
          .toList();

      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on PostgrestException catch (e) {
      return Left(ServerFailure('Database error: ${e.message}'));
    } catch (e) {
      return Left(UnknownFailure('Error fetching daily attendance: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, MonthlyAttendanceEntity?>> getMonthlyAttendance(
      String employeeId, String yearMonth) async {
    try {
      final response = await _supabaseClient
          .from('monthly_attendance')
          .select()
          .eq('employee_id', employeeId)
          .eq('year_month', yearMonth)
          .maybeSingle();

      if (response == null) {
        return const Right(null);
      }

      final model = MonthlyAttendanceModel.fromJson(response);
      return Right(model.toEntity());
    } on PostgrestException catch (e) {
      return Left(ServerFailure('Database error: ${e.message}'));
    } catch (e) {
      return Left(UnknownFailure('Error fetching monthly attendance: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, DailyAttendanceEntity?>> getTodayAttendance(
      String employeeId) async {
    try {
      final today = DateTime.now().toIso8601String().split('T')[0];
      
      final response = await _supabaseClient
          .from('daily_attendance')
          .select()
          .eq('employee_id', employeeId)
          .eq('work_day', today)
          .maybeSingle();

      if (response == null) {
        return const Right(null);
      }

      final model = DailyAttendanceModel.fromJson(response);
      return Right(model.toEntity());
    } on PostgrestException catch (e) {
      return Left(ServerFailure('Database error: ${e.message}'));
    } catch (e) {
      return Left(UnknownFailure('Error fetching today\'s attendance: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<DailyAttendanceEntity>>> getAttendanceHistory(
      String employeeId, {int limit = 30}) async {
    try {
      final response = await _supabaseClient
          .from('daily_attendance')
          .select()
          .eq('employee_id', employeeId)
          .order('work_day', ascending: false)
          .limit(limit);

      final models = (response as List)
          .map((json) => DailyAttendanceModel.fromJson(json))
          .toList();

      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on PostgrestException catch (e) {
      return Left(ServerFailure('Database error: ${e.message}'));
    } catch (e) {
      return Left(UnknownFailure('Error fetching attendance history: ${e.toString()}'));
    }
  }

  // Helper methods
  bool _isWeekend(DateTime date, String employeeWeekend) {
    // Convert string day to weekday number
    final weekdays = {
      'Monday': 1,
      'Tuesday': 2,
      'Wednesday': 3,
      'Thursday': 4,
      'Friday': 5,
      'Saturday': 6,
      'Sunday': 7,
    };
    
    final weekendDay = weekdays[employeeWeekend] ?? 5; // Default to Friday
    return date.weekday == weekendDay;
  }

  @override
  Future<Either<Failure, DailyAttendanceEntity>> markOnLeave(
      String employeeId, DateTime date) async {
    try {
      final dateString = date.toIso8601String().split('T')[0];

      // Check if record exists for this date
      final existingResponse = await _supabaseClient
          .from('daily_attendance')
          .select()
          .eq('employee_id', employeeId)
          .eq('work_day', dateString)
          .maybeSingle();

      if (existingResponse != null) {
        // Update existing record
        final updateResponse = await _supabaseClient
            .from('daily_attendance')
            .update({
              'status': 'on_leave',
              'is_leave': true,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('employee_id', employeeId)
            .eq('work_day', dateString)
            .select()
            .single();

        final model = DailyAttendanceModel.fromJson(updateResponse);
        return Right(model.toEntity());
      } else {
        // Create new record for leave
        final insertResponse = await _supabaseClient
            .from('daily_attendance')
            .insert({
              'employee_id': employeeId,
              'work_day': dateString,
              'status': 'on_leave',
              'is_leave': true,
              'is_weekend': _isWeekend(date, 'Friday'), // Default weekend check
              'created_at': DateTime.now().toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
            })
            .select()
            .single();

        final model = DailyAttendanceModel.fromJson(insertResponse);
        return Right(model.toEntity());
      }
    } on PostgrestException catch (e) {
      return Left(ServerFailure('Database error marking leave: ${e.message}'));
    } catch (e) {
      return Left(UnknownFailure('Error marking on leave: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, DailyAttendanceEntity>> markAbsent(
      String employeeId, DateTime date) async {
    try {
      final dateString = date.toIso8601String().split('T')[0];

      // Check if record exists for this date
      final existingResponse = await _supabaseClient
          .from('daily_attendance')
          .select()
          .eq('employee_id', employeeId)
          .eq('work_day', dateString)
          .maybeSingle();

      if (existingResponse != null) {
        // Update existing record
        final updateResponse = await _supabaseClient
            .from('daily_attendance')
            .update({
              'status': 'absent',
              'is_leave': false,
              'check_in': null,
              'check_out': null,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('employee_id', employeeId)
            .eq('work_day', dateString)
            .select()
            .single();

        final model = DailyAttendanceModel.fromJson(updateResponse);
        return Right(model.toEntity());
      } else {
        // Create new record for absent
        final insertResponse = await _supabaseClient
            .from('daily_attendance')
            .insert({
              'employee_id': employeeId,
              'work_day': dateString,
              'status': 'absent',
              'is_leave': false,
              'is_weekend': _isWeekend(date, 'Friday'), // Default weekend check
              'created_at': DateTime.now().toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
            })
            .select()
            .single();

        final model = DailyAttendanceModel.fromJson(insertResponse);
        return Right(model.toEntity());
      }
    } on PostgrestException catch (e) {
      return Left(ServerFailure('Database error marking absent: ${e.message}'));
    } catch (e) {
      return Left(UnknownFailure('Error marking absent: ${e.toString()}'));
    }
  }

  String _getNextMonth(String yearMonth) {
    final parts = yearMonth.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    
    int nextYear = year;
    int nextMonth = month + 1;
    if (nextMonth == 13) {
      nextYear += 1;
      nextMonth = 1;
    }
    
    // Return as yyyy-MM-dd string for the first day of the next month
    return '${nextYear.toString().padLeft(4, '0')}-${nextMonth.toString().padLeft(2, '0')}-01';
  }
}
