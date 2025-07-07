import 'package:dartz/dartz.dart';
import 'package:fleekhr/data/models/auth/user_login.dart';
import 'package:fleekhr/domain/entities/auth/user_entity.dart';


abstract class AuthRepository {
  Future<Either>login(UserLogin userLogin);
  Future<Either> getUser();
  Future<void> logout();
  Future<Either> updateProfile(EmployeeEntity employeeEntity);
}
