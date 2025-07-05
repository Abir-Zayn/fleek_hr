import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/data/models/auth/user_login.dart';
import 'package:fleekhr/data/service/auth/auth_service.dart';

import 'package:fleekhr/domain/repository/auth/auth_repository.dart';

class AuthRepoImpl extends AuthRepository {
  @override
  Future<Either> login(UserLogin userLogin) async {
    final result = await sl<AuthService>().login(userLogin);
    return result;
  }

  @override
  Future<Either> getUser() async {
    return await sl<AuthService>().getUser();
  }

  @override
  Future<void> logout() async {
    await sl<AuthService>().logout();
  }
}
