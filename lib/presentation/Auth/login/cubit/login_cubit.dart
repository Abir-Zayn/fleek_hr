import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/data/models/auth/user_login.dart';
import 'package:fleekhr/domain/usecase/auth/getuser_usecase.dart';
import 'package:fleekhr/domain/usecase/auth/login_usecase.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUsecase = sl<LoginUsecase>();
  final GetUserUseCase getUserUseCase = sl<GetUserUseCase>();

  LoginCubit() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    if (email.isEmpty || password.isEmpty) {
      emit(LoginError(
          failure: InvalidInputFailure('Email and password cannot be empty')));
      return;
    }

    final result = await loginUsecase.call(
      params: UserLogin(
        email: email,
        password: password,
      ),
    );

    result.fold(
      (failure) => emit(LoginError(failure: failure)),
      (success) => emit(LoginSuccess(message: success)),
    );
  }

  // Future<void> getUser() async {
  //   emit(LoginLoading());
  //   final result = await getUserUseCase.call();

  //   result.fold(
  //     (failure) => emit(LoginError(failure: failure)),
  //     (user) => emit(GetUserSuccess(user: user)),
  //   );
  // }

  void logout() {
    // Implementation for logout
    emit(LoginInitial());
  }
}
