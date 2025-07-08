import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/entities/leave/leave_request.dart';

import 'package:fleekhr/domain/repository/leave/leave_request_repository.dart';

class getAllLeaveRequestsUseCase
    implements Usecase<Either<Failure, List<LeaveRequestEntity>>, String> {
  final LeaveRequestRepository repository;

  getAllLeaveRequestsUseCase(this.repository);

  @override
  Future<Either<Failure, List<LeaveRequestEntity>>> call(
      {required String params}) async {
    return await repository.getAllLeaveRequests(params);
  }
}
