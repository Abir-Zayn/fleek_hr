import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/domain/repository/attendance/attendance_repository.dart';

class RefreshAttendanceUseCase {
  Future<Either<Failure, void>> call() async {
    return await sl<AttendanceRepository>().refreshMonthlyAttendance();
  }
}
