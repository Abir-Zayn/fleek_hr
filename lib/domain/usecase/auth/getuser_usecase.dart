import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/repository/auth/auth_repository.dart';

class GetUserUseCase implements Usecase<Either,dynamic> {

  @override
  Future<Either> call({void params}) async {
    return await sl<AuthRepository>().getUser();
  }
}