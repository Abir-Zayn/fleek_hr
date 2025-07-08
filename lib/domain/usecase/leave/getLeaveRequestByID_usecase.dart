import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/usecase/usecase.dart';

import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/domain/entities/leave/leave_request.dart';
import 'package:fleekhr/domain/repository/leave/leave_request_repository.dart';

class GetLeaveRequestByIdUseCase implements Usecase<Either<Failure, LeaveRequestEntity>, int> {
  final LeaveRequestRepository repository;

  GetLeaveRequestByIdUseCase(this.repository);

  @override
  Future<Either<Failure, LeaveRequestEntity>> call({required int params}) async {
    return await repository.getLeaveRequestById(params);
  }
}