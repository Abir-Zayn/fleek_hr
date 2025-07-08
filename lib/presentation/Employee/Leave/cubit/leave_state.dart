part of 'leave_cubit.dart';

sealed class LeaveState extends Equatable {
  const LeaveState();

  @override
  List<Object> get props => [];
}

final class LeaveInitial extends LeaveState {}

final class LeaveLoading extends LeaveState {}

final class LeaveLoaded extends LeaveState {
  final List<LeaveRequestEntity> leaveRequests;

  const LeaveLoaded(this.leaveRequests);

  @override
  List<Object> get props => [leaveRequests];
}

final class LeaveRequestLoaded extends LeaveState {
  final LeaveRequestEntity leaveRequest;

  const LeaveRequestLoaded({required this.leaveRequest});

  @override
  List<Object> get props => [leaveRequest];
}

final class LeaveRequestCreated extends LeaveState {
  final LeaveRequestEntity leaveRequest;

  const LeaveRequestCreated({required this.leaveRequest});

  @override
  List<Object> get props => [leaveRequest];
}

final class LeaveRequestDeleted extends LeaveState {}

final class LeaveError extends LeaveState {
  final String message;

  const LeaveError(this.message);

  @override
  List<Object> get props => [message];
}

