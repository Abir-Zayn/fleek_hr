import 'package:equatable/equatable.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/domain/entities/auth/user_entity.dart';
import 'package:fleekhr/domain/usecase/auth/getuser_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  // get user use-case
  final GetUserUseCase getUserUseCase = sl<GetUserUseCase>();
  ProfileCubit() : super(ProfileInitial());

  Future<void> getUser() async {
    emit(ProfileLoading());

    final result = await getUserUseCase.call();

    result.fold(
      (failure) => emit(ProfileError(failure: failure)),
      (user) => emit(ProfileLoaded(user: user)),
    );
  }

  Future<void> updateUserProfile(EmployeeEntity updatedUser) async {
    emit(ProfileLoading());

    // TODO: Implement update user profile use case
    // For now, we'll just emit the updated user
    emit(ProfileLoaded(user: updatedUser));
  }

  void refreshProfile() {
    getUser();
  }
}
