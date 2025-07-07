import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/entities/auth/user_entity.dart';
import 'package:fleekhr/domain/repository/auth/auth_repository.dart';

class UpdateProfileUseCase implements Usecase<Either,EmployeeEntity> {
  @override
  Future<Either>call({EmployeeEntity? params}) async {
    return await sl<AuthRepository>().updateProfile(params!);
  }
}