import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/repository/work_from_home/work_from_home_repo.dart';

class DeleteworkfromhomerequestUsecase
    implements Usecase<Either<dynamic, void>, String> {
  final WorkFromHomeRepository repository;

  DeleteworkfromhomerequestUsecase(this.repository);

  @override
  Future<Either<dynamic, void>> call({required String params}) async {
    return await repository.deleteWFHRequest(params);
  }
}
