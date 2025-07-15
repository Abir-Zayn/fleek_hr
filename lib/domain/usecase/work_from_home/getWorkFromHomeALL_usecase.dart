import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/entities/work_from_home/work_from_home_entity.dart';
import 'package:fleekhr/domain/repository/work_from_home/work_from_home_repo.dart';

class GetworkfromhomeallUsecase
    implements Usecase<Either<Failure, List<WorkFromHomeEntity>>, String> {
  final WorkFromHomeRepository repository;
  GetworkfromhomeallUsecase(this.repository);

  @override
  Future<Either<Failure, List<WorkFromHomeEntity>>> call(
      {required String params}) async {
    return await repository.getAllWFHRequest(params);
  }
}
