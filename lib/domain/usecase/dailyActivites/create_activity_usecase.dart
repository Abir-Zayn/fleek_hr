
import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/entities/dailyActivities/daily_activities_entity.dart';
import 'package:fleekhr/domain/repository/dailyActivites/daily_activities_repo.dart';

class CreateActivityUsecase implements Usecase<Either<Failure,DailyActivitiesEntity>,DailyActivitiesEntity>{
  final DailyActivitiesRepository repository;

  CreateActivityUsecase(this.repository);

  @override
  Future<Either<Failure, DailyActivitiesEntity>> call({required DailyActivitiesEntity params}) {
    return repository.createDailyActivity(params);
  }
}