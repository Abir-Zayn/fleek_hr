import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/entities/leave/leave_request.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/domain/repository/leave/leave_request_repository.dart';

class CreateLeaveRequestUseCase implements Usecase<Either<Failure, LeaveRequestEntity>, LeaveRequestEntity> {
  final LeaveRequestRepository repository;

  CreateLeaveRequestUseCase(this.repository);

  @override
  Future<Either<Failure, LeaveRequestEntity>> call({required LeaveRequestEntity params}) async {
    return await repository.createLeaveRequest(params);
  }
}