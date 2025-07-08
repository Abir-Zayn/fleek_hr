import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/data/service/leave_req/leave_request_service_impl.dart';
import 'package:fleekhr/domain/entities/leave/leave_request.dart';
import 'package:fleekhr/domain/repository/leave/leave_request_repository.dart';

class LeaveRequestRepoImpl extends LeaveRequestRepository {
  // Constructor to initialize the repository
  // This repository will use the service locator to get the LeaveRequestService
  // This is a repository implementation for managing leave requests.
  // It interacts with the data layer to perform CRUD operations on leave requests.
  // It extends the LeaveRequestRepository interface.
  // 1. Get all leave requests
  // 2. Get leave request by ID
  // 3. Create leave request
  // 4. Update leave request
  // 5. Delete leave request

  LeaveRequestRepoImpl();
  @override
  Future<Either<Failure, List<LeaveRequestEntity>>> getAllLeaveRequests(
      String employeeId) async {
    return await sl<LeaveRequestService>().getAllLeaveRequests(employeeId);
  }

  @override
  Future<Either<Failure, LeaveRequestEntity>> getLeaveRequestById(int id) {
    return sl<LeaveRequestService>().getLeaveRequestById(id);
  }

  @override
  Future<Either<Failure, LeaveRequestEntity>> createLeaveRequest(
      LeaveRequestEntity leaveRequest) async {
    return await sl<LeaveRequestService>().createLeaveRequest(leaveRequest);
  }

  @override
  Future<Either<Failure, LeaveRequestEntity>> updateLeaveRequest(
      LeaveRequestEntity leaveRequest) async {
    return await sl<LeaveRequestService>().updateLeaveRequest(leaveRequest);
  }

  @override
  Future<Either<Failure, void>> deleteLeaveRequest(int id) async {
    return await sl<LeaveRequestService>().deleteLeaveRequest(id);
  }
}
