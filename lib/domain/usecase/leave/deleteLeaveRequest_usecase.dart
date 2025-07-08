import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/repository/leave/leave_request_repository.dart';

class DeleteLeaveRequestUseCase implements Usecase<Either<dynamic, void>, int> {
  final LeaveRequestRepository repository;

  DeleteLeaveRequestUseCase(this.repository);

  @override
  Future<Either<dynamic, void>> call({required int params}) async {
    return await repository.deleteLeaveRequest(params);
  }
}