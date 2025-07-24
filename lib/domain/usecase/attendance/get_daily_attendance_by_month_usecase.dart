import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/entities/attendance/daily_attendance_entity.dart';
import 'package:fleekhr/domain/repository/attendance/attendance_repository.dart';

class GetDailyAttendanceByMonthParams {
  final String employeeId;
  final String yearMonth;

  GetDailyAttendanceByMonthParams({
    required this.employeeId,
    required this.yearMonth,
  });
}

class GetDailyAttendanceByMonthUseCase 
    implements Usecase<Either<Failure, List<DailyAttendanceEntity>>, GetDailyAttendanceByMonthParams> {
  
  @override
  Future<Either<Failure, List<DailyAttendanceEntity>>> call({GetDailyAttendanceByMonthParams? params}) async {
    if (params == null) {
      return Left(InvalidInputFailure('Parameters cannot be null'));
    }
    
    if (params.employeeId.isEmpty) {
      return Left(InvalidInputFailure('Employee ID cannot be empty'));
    }
    
    if (params.yearMonth.isEmpty || !_isValidYearMonth(params.yearMonth)) {
      return Left(InvalidInputFailure('Invalid year-month format. Expected: YYYY-MM'));
    }
    
    return await sl<AttendanceRepository>().getDailyAttendanceByMonth(params.employeeId, params.yearMonth);
  }
  
  bool _isValidYearMonth(String yearMonth) {
    final regex = RegExp(r'^\d{4}-\d{2}$');
    if (!regex.hasMatch(yearMonth)) return false;
    
    final parts = yearMonth.split('-');
    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    
    return year != null && 
           month != null && 
           year >= 2000 && 
           year <= 2100 && 
           month >= 1 && 
           month <= 12;
  }
}
