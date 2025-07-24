import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/entities/attendance/daily_attendance_entity.dart';
import 'package:fleekhr/domain/repository/attendance/attendance_repository.dart';

class CheckInUseCase implements Usecase<Either<Failure, DailyAttendanceEntity>, String> {
  @override
  Future<Either<Failure, DailyAttendanceEntity>> call({String? params}) async {
    if (params == null || params.isEmpty) {
      return Left(InvalidInputFailure('Employee ID cannot be empty'));
    }
    
    return await sl<AttendanceRepository>().checkIn(params);
  }
}
