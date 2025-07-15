import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/usecase/usecase.dart';

import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/domain/entities/work_from_home/work_from_home_entity.dart';
import 'package:fleekhr/domain/repository/work_from_home/work_from_home_repo.dart';

class GetworkfromhomerequestIdUsecase implements
    Usecase<Either<Failure, WorkFromHomeEntity>, String> {
  final WorkFromHomeRepository repository;

  GetworkfromhomerequestIdUsecase(this.repository);

  @override
  Future<Either<Failure, WorkFromHomeEntity>> call({required String params}) async {
    return await repository.getWFHRequestById(params);
  }
}
