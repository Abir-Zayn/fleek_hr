import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/data/service/wfh_req/wfh_api_service.dart';
import 'package:fleekhr/domain/entities/work_from_home/work_from_home_entity.dart';
import 'package:fleekhr/domain/repository/work_from_home/work_from_home_repo.dart';

class WorkFromHomeRepoImpl implements WorkFromHomeRepository {
  @override
  Future<Either<Failure, List<WorkFromHomeEntity>>> getAllWFHRequest(
      String employeeId) async {
    return await sl<WorkFromHomeAPIService>().getAllWFHRequest(employeeId);
  }

  @override
  Future<Either<Failure, WorkFromHomeEntity>> getWFHRequestById(
      String id) async {
    return await sl<WorkFromHomeAPIService>().getWFHRequestById(id);
  }

  @override
  Future<Either<Failure, WorkFromHomeEntity>> createWFHRequest(
      WorkFromHomeEntity workFromHomeRequest) async {
    return await sl<WorkFromHomeAPIService>()
        .createWFHRequest(workFromHomeRequest);
  }

  @override
  Future<Either<Failure, WorkFromHomeEntity>> updateWFHRequest(
      WorkFromHomeEntity workFromHomeRequest) async {
    return await sl<WorkFromHomeAPIService>()
        .updateWFHRequest(workFromHomeRequest);
  }

  @override
  Future<Either<Failure, void>> deleteWFHRequest(String id) async {
    return await sl<WorkFromHomeAPIService>().deleteWFHRequest(id);
  }
}
