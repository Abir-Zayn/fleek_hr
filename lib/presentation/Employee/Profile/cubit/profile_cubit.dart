import 'package:equatable/equatable.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/domain/entities/auth/user_entity.dart';
import 'package:fleekhr/domain/usecase/auth/getuser_usecase.dart';
import 'package:fleekhr/domain/usecase/auth/updateprofile_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  // ( get user + update user profile ) use-case

  final GetUserUseCase getUserUseCase = sl<GetUserUseCase>();
  final UpdateProfileUseCase updateProfileUseCase = sl<UpdateProfileUseCase>();
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

    final result = await updateProfileUseCase.call(params: updatedUser);
    result.fold(
      (failure) => emit(ProfileError(failure: failure)),
      (userUpdate) => emit(ProfileLoaded(user: userUpdate)),
    );
  }

  void refreshProfile() {
    getUser();
  }
}
