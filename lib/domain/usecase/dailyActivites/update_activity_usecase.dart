import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/entities/dailyActivities/daily_activities_entity.dart';
import 'package:fleekhr/domain/repository/dailyActivites/daily_activities_repo.dart';

class UpdateActivityUsecase
    implements
        Usecase<Either<Failure, DailyActivitiesEntity>, DailyActivitiesEntity> {
  final DailyActivitiesRepository repository;

  UpdateActivityUsecase(this.repository);

  @override
  Future<Either<Failure, DailyActivitiesEntity>> call(
      {required DailyActivitiesEntity params}) async {
    return await repository.updateDailyActivity(params);
  }
}
