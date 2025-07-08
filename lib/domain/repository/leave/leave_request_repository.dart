import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/domain/entities/leave/leave_request.dart';


abstract class LeaveRequestRepository {
  Future<Either<Failure, List<LeaveRequestEntity>>> getAllLeaveRequests(
      String employeeId);

  /// Fetches a single leave request by its unique ID.
  Future<Either<Failure, LeaveRequestEntity>> getLeaveRequestById(int id);

  /// Creates a new leave request.
  Future<Either<Failure, LeaveRequestEntity>> createLeaveRequest(
      LeaveRequestEntity leaveRequest);

  /// Updates the status or details of an existing leave request.
  Future<Either<Failure, LeaveRequestEntity>> updateLeaveRequest(
      LeaveRequestEntity leaveRequest);

  /// Cancels/deletes a leave request.
  Future<Either<Failure, void>> deleteLeaveRequest(int id);
}
