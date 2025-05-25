import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/data/models/auth/user_login.dart';
import 'package:fleekhr/domain/repository/auth/auth_repository.dart';

class LoginUsecase implements Usecase<Either, UserLogin> {
  @override
  Future<Either> call({UserLogin? params}) async {
    return await sl<AuthRepository>().login(params!);
  }
}
