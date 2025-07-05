import 'package:dartz/dartz.dart';
import 'package:fleekhr/data/models/auth/user_login.dart';


abstract class AuthRepository {
  Future<Either>login(UserLogin userLogin);
  Future<Either> getUser();
  Future<void> logout();
}
