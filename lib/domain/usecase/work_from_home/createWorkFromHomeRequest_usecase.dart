import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/entities/work_from_home/work_from_home_entity.dart';
import 'package:fleekhr/domain/repository/work_from_home/work_from_home_repo.dart';

class CreateworkfromhomerequestUsecase
    implements
        Usecase<Either<Failure, WorkFromHomeEntity>, WorkFromHomeEntity> {
  final WorkFromHomeRepository repository;
  CreateworkfromhomerequestUsecase(this.repository);

  @override
  Future<Either<Failure, WorkFromHomeEntity>> call(
      {required WorkFromHomeEntity params}) async {
    return await repository.createWFHRequest(params);
  }
}
