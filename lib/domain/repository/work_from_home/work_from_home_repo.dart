import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/domain/entities/work_from_home/work_from_home_entity.dart';

abstract class WorkFromHomeRepository {
  Future<Either<Failure, List<WorkFromHomeEntity>>> getAllWFHRequest(
      String employeeId);

  Future<Either<Failure, WorkFromHomeEntity>> getWFHRequestById(String id);

  Future<Either<Failure, WorkFromHomeEntity>> createWFHRequest(
      WorkFromHomeEntity workFromHomeRequest);

  Future<Either<Failure, WorkFromHomeEntity>> updateWFHRequest(
      WorkFromHomeEntity workFromHomeRequest);

  Future<Either<Failure, void>> deleteWFHRequest(String id);
}
