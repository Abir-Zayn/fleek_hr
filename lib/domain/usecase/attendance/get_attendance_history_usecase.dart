import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/entities/attendance/daily_attendance_entity.dart';
import 'package:fleekhr/domain/repository/attendance/attendance_repository.dart';

class GetAttendanceHistoryParams {
  final String employeeId;
  final int limit;

  GetAttendanceHistoryParams({
    required this.employeeId,
    this.limit = 30,
  });
}

class GetAttendanceHistoryUseCase 
    implements Usecase<Either<Failure, List<DailyAttendanceEntity>>, GetAttendanceHistoryParams> {
  
  @override
  Future<Either<Failure, List<DailyAttendanceEntity>>> call({GetAttendanceHistoryParams? params}) async {
    if (params == null) {
      return Left(InvalidInputFailure('Parameters cannot be null'));
    }
    
    if (params.employeeId.isEmpty) {
      return Left(InvalidInputFailure('Employee ID cannot be empty'));
    }
    
    if (params.limit <= 0) {
      return Left(InvalidInputFailure('Limit must be greater than 0'));
    }
    
    return await sl<AttendanceRepository>().getAttendanceHistory(params.employeeId, limit: params.limit);
  }
}
