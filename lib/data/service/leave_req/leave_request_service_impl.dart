import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/data/models/leave_request/enum/leaveDuration_enum.dart';
import 'package:fleekhr/data/models/leave_request/enum/leaveStatus_enum.dart';
import 'package:fleekhr/data/models/leave_request/enum/leaveType_enum.dart';
import 'package:fleekhr/domain/entities/leave/employee_leave_balance.dart';
import 'package:fleekhr/domain/entities/leave/leave_request.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LeaveRequestService {
  // add necessary methods for leave request service
  // 1. Get all leave requests
  // 2. Get leave request by ID
  // 3. Create leave request
  // 4. Update leave request
  // 5. Delete leave request

  Future<Either<Failure, List<LeaveRequestEntity>>> getAllLeaveRequests(
      String employeeId);
  Future<Either<Failure, LeaveRequestEntity>> getLeaveRequestById(int id);
  Future<Either<Failure, LeaveRequestEntity>> createLeaveRequest(
      LeaveRequestEntity entity);
  Future<Either<Failure, LeaveRequestEntity>> updateLeaveRequest(
      LeaveRequestEntity entity);
  Future<Either<Failure, void>> deleteLeaveRequest(int id);
  Future<Either<Failure, List<EmployeeLeaveBalanceEntity>>>
      getEmployeeLeaveBalance(String employeeId);
}

class LeaveRequestServiceImpl implements LeaveRequestService {
  final SupabaseClient _supabaseClient;

  LeaveRequestServiceImpl(this._supabaseClient);

  // Fetch all leave requests
  @override
  Future<Either<Failure, List<LeaveRequestEntity>>> getAllLeaveRequests(
      String employeeId) async {
    try {
      final response = await _supabaseClient
          .from('leaverequest')
          .select()
          .eq('employee_id', employeeId);

      final list = (response as List)
          .map((json) => LeaveRequestEntity(
                id: json['id'],
                employeeId: json['employee_id'],
                leaveType: LeaveType.fromString(json['leave_type']),
                startDate: DateTime.parse(json['start_date']),
                endDate: DateTime.parse(json['end_date']),
                reason: json['reason'],
                status: LeaveStatus.fromString(json['status']),
                requestedDays: json['requested_days'],
                proofImageUrl: json['proof_image_url'],
                durationType: DurationType.fromString(json['duration_type']),
                createdAt: DateTime.parse(json['created_at']),
                updatedAt: DateTime.parse(json['updated_at']),
              ))
          .toList();
      return Right(list);
    } catch (e) {
      return Left(
          ServerFailure('Failed to fetch leave requests: ${e.toString()}'));
    }
  }

  // Fetch a single leave request by ID
  @override
  Future<Either<Failure, LeaveRequestEntity>> getLeaveRequestById(
      int id) async {
    try {
      final response = await _supabaseClient
          .from('leaverequest')
          .select()
          .eq('id', id)
          .single();

      final leaveRequest = LeaveRequestEntity(
        id: response['id'],
        employeeId: response['employee_id'],
        leaveType: LeaveType.fromString(response['leave_type']),
        startDate: DateTime.parse(response['start_date']),
        endDate: DateTime.parse(response['end_date']),
        reason: response['reason'],
        status: LeaveStatus.fromString(response['status']),
        requestedDays: response['requested_days'],
        proofImageUrl: response['proof_image_url'],
        durationType: DurationType.fromString(response['duration_type']),
        createdAt: DateTime.parse(response['created_at']),
        updatedAt: DateTime.parse(response['updated_at']),
      );

      return Right(leaveRequest);
    } catch (e) {
      return Left(
          ServerFailure('Failed to fetch leave request: ${e.toString()}'));
    }
  }

  // Create a new leave request
  @override
  Future<Either<Failure, LeaveRequestEntity>> createLeaveRequest(
      LeaveRequestEntity entity) async {
    try {
      final response = await _supabaseClient
          .from('leaverequest')
          .insert({
            'employee_id': entity.employeeId,
            'leave_type': entity.leaveType.toJson(),
            'start_date': entity.startDate.toIso8601String(),
            'end_date': entity.endDate.toIso8601String(),
            'reason': entity.reason,
            'status': entity.status.toJson(),
            'requested_days': entity.requestedDays,
            'proof_image_url': entity.proofImageUrl,
            'duration_type': entity.durationType.toJson(),
          })
          .select()
          .single();

      final newLeaveRequest = LeaveRequestEntity(
        id: response['id'],
        employeeId: response['employee_id'],
        leaveType: LeaveType.fromString(response['leave_type']),
        startDate: DateTime.parse(response['start_date']),
        endDate: DateTime.parse(response['end_date']),
        reason: response['reason'],
        status: LeaveStatus.fromString(response['status']),
        requestedDays: response['requested_days'],
        proofImageUrl: response['proof_image_url'],
        durationType: DurationType.fromString(response['duration_type']),
        createdAt: DateTime.parse(response['created_at']),
        updatedAt: DateTime.parse(response['updated_at']),
      );

      return Right(newLeaveRequest);
    } catch (e) {
      return Left(
          ServerFailure('Failed to create leave request: ${e.toString()}'));
    }
  }

  // Update an existing leave request
  @override
  Future<Either<Failure, LeaveRequestEntity>> updateLeaveRequest(
      LeaveRequestEntity entity) async {
    try {
      final response = await _supabaseClient
          .from('leaverequest')
          .update({
            'employee_id': entity.employeeId,
            'leave_type': entity.leaveType.toJson(),
            'start_date': entity.startDate.toIso8601String(),
            'end_date': entity.endDate.toIso8601String(),
            'reason': entity.reason,
            'status': entity.status.toJson(),
            'requested_days': entity.requestedDays,
            'proof_image_url': entity.proofImageUrl,
            'duration_type': entity.durationType.toJson(),
          })
          .eq('id', entity.id)
          .select()
          .single();

      final updatedLeaveRequest = LeaveRequestEntity(
        id: response['id'],
        employeeId: response['employee_id'],
        leaveType: LeaveType.fromString(response['leave_type']),
        startDate: DateTime.parse(response['start_date']),
        endDate: DateTime.parse(response['end_date']),
        reason: response['reason'],
        status: LeaveStatus.fromString(response['status']),
        requestedDays: response['requested_days'],
        proofImageUrl: response['proof_image_url'],
        durationType: DurationType.fromString(response['duration_type']),
        createdAt: DateTime.parse(response['created_at']),
        updatedAt: DateTime.parse(response['updated_at']),
      );

      return Right(updatedLeaveRequest);
    } catch (e) {
      return Left(
          ServerFailure('Failed to update leave request: ${e.toString()}'));
    }
  }

  // Delete a leave request by ID
  @override
  Future<Either<Failure, void>> deleteLeaveRequest(int id) async {
    try {
      final response =
          await _supabaseClient.from('leaverequest').delete().eq('id', id);

      if (response.error != null) {
        return Left(ServerFailure(
            'Failed to delete leave request: ${response.error!.message}'));
      }

      return Right(null);
    } catch (e) {
      return Left(
          ServerFailure('Failed to delete leave request: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<EmployeeLeaveBalanceEntity>>>
      getEmployeeLeaveBalance(String employeeId) async {
    try {
      final response = await _supabaseClient
          .from('employee_leave_balance')
          .select()
          .eq('employee_id', employeeId)
          .eq('year', DateTime.now().year);

      // Handle empty response
      if ((response as List).isEmpty) {
        return Right([]); // Return empty list instead of error
      }

      final list = (response as List)
          .map((json) => EmployeeLeaveBalanceEntity(
                employeeId: json['employee_id'],
                leaveType: LeaveType.fromString(json['leave_type']),
                totalAllocated: json['total_allocated'],
                usedDays: json['used_days'],
                remainingDays: json['remaining_days'],
                year: json['year'],
              ))
          .toList();

      return Right(list);
    } catch (e) {
      return Left(
          ServerFailure('Failed to fetch leave balance: ${e.toString()}'));
    }
  }
}
