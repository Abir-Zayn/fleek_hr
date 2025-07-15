part of 'work_from_home_cubit.dart';

abstract class WorkFromHomeState extends Equatable {
  const WorkFromHomeState();

  @override
  List<Object> get props => [];
}

class WorkFromHomeInitial extends WorkFromHomeState {}

class WorkFromHomeLoading extends WorkFromHomeState {}

class WorkFromHomeSuccess extends WorkFromHomeState {
  final WorkFromHomeEntity workFromHome;

  const WorkFromHomeSuccess(this.workFromHome);

  @override
  List<Object> get props => [workFromHome];
}

class WorkFromHomeListSuccess extends WorkFromHomeState {
  final List<WorkFromHomeEntity> workFromHomeList;

  const WorkFromHomeListSuccess(this.workFromHomeList);

  @override
  List<Object> get props => [workFromHomeList];
}

class WorkFromHomeDetailSuccess extends WorkFromHomeState {
  final WorkFromHomeEntity workFromHome;
  final List<WorkFromHomeEntity> workFromHomeList;

  const WorkFromHomeDetailSuccess({
    required this.workFromHome,
    required this.workFromHomeList,
  });

  @override
  List<Object> get props => [workFromHome, workFromHomeList];
}

class WorkFromHomeError extends WorkFromHomeState {
  final String message;

  const WorkFromHomeError(this.message);

  @override
  List<Object> get props => [message];
}
