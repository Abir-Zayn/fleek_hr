part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final EmployeeEntity user;

  const ProfileLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

final class ProfileError extends ProfileState {
  final Failure failure;

  const ProfileError({required this.failure});

  @override
  List<Object> get props => [failure];
}
