import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/entities/dailyActivities/daily_activities_entity.dart';
import 'package:fleekhr/domain/repository/dailyActivites/daily_activities_repo.dart';

class GetAllActivitiesUsecase
    implements Usecase<Either<Failure, List<DailyActivitiesEntity>>, String> {
  final DailyActivitiesRepository repository;

  GetAllActivitiesUsecase(this.repository);

  @override
  Future<Either<Failure, List<DailyActivitiesEntity>>> call(
      {required String params}) async {
    return await repository.getAllDailyActivities(params);
  }
}
