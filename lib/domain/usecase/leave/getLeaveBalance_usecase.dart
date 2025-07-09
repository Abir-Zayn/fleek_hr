import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/entities/leave/employee_leave_balance.dart';
import 'package:fleekhr/domain/repository/leave/leave_request_repository.dart';

class GetEmployeeLeaveBalanceUseCase
    implements
        Usecase<Either<Failure, List<EmployeeLeaveBalanceEntity>>, String> {
  final LeaveRequestRepository repository;

  GetEmployeeLeaveBalanceUseCase(this.repository);

  @override
  Future<Either<Failure, List<EmployeeLeaveBalanceEntity>>> call(
      {required String params}) async {
    return await repository.getEmployeeLeaveBalance(params);
  }
}
