import 'package:equatable/equatable.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/domain/entities/leave/leave_request.dart';
import 'package:fleekhr/domain/usecase/leave/createLeaveRequest_usecase.dart';
import 'package:fleekhr/domain/usecase/leave/deleteLeaveRequest_usecase.dart';
import 'package:fleekhr/domain/usecase/leave/getLeaveRequestByID_usecase.dart';
import 'package:fleekhr/domain/usecase/leave/getLeaveRequest_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'leave_state.dart';

class LeaveCubit extends Cubit<LeaveState> {
  final getAllLeaveRequestsUseCase _getLeaveRequestsUseCase =
      sl<getAllLeaveRequestsUseCase>();
  final GetLeaveRequestByIdUseCase _getLeaveRequestByIdUseCase =
      sl<GetLeaveRequestByIdUseCase>();
  final CreateLeaveRequestUseCase _createLeaveRequestUseCase =
      sl<CreateLeaveRequestUseCase>();
  final DeleteLeaveRequestUseCase _deleteLeaveRequestUseCase =
      sl<DeleteLeaveRequestUseCase>();

  LeaveCubit() : super(LeaveInitial());

  void getAllLeaveRequestForCurrentUser() {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId != null && userId.isNotEmpty) {
      getAllLeaveRequests(userId);
    } else {
      emit(LeaveError('User not logged in'));
    }
  }

  //1. Get all leave requests
  Future<void> getAllLeaveRequests(String employeeId) async {
    emit(LeaveLoading());
    final result = await _getLeaveRequestsUseCase.call(params: employeeId);
    result.fold(
      (failure) => emit(LeaveError(failure.message)),
      (leaveRequests) => emit(LeaveLoaded(leaveRequests)),
    );
  }

  //2. Get leave request by ID
  Future<void> getLeaveRequestById(int id) async {
    emit(LeaveLoading());
    final result = await _getLeaveRequestByIdUseCase.call(params: id);
    result.fold(
      (failure) => emit(LeaveError(failure.message)),
      (leaveRequest) => emit(LeaveRequestLoaded(leaveRequest: leaveRequest)),
    );
  }

  //3. Create a new leave request
  Future<void> createLeaveRequest(LeaveRequestEntity leaveRequest) async {
    emit(LeaveLoading());
    final result = await _createLeaveRequestUseCase.call(params: leaveRequest);
    result.fold(
      (failure) => emit(LeaveError(failure.message)),
      (newLeaveRequest) =>
          emit(LeaveRequestCreated(leaveRequest: newLeaveRequest)),
    );
  }

  //4. Delete a leave request
  Future<void> deleteLeaveRequest(int id) async {
    emit(LeaveLoading());
    final result = await _deleteLeaveRequestUseCase.call(params: id);
    result.fold(
      (failure) => emit(LeaveError(failure.message)),
      (_) => emit(LeaveRequestDeleted()),
    );
  }

//5. Get leave requests for an employee
  Future<void> getLeaveRequestsForEmployee(String employeeId) async {
    emit(LeaveLoading());
    final result = await _getLeaveRequestsUseCase.call(params: employeeId);
    result.fold(
      (failure) => emit(LeaveError(failure.message)),
      (leaveRequests) => emit(LeaveLoaded(leaveRequests)),
    );
  }
}
