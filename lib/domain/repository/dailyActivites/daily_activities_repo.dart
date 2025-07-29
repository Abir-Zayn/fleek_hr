
import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/domain/entities/dailyActivities/daily_activities_entity.dart';

abstract class DailyActivitiesRepository {
  Future<Either<Failure, List<DailyActivitiesEntity>>> getAllDailyActivities(String employeeId);
  Future<Either<Failure, DailyActivitiesEntity>> getDailyActivityById(String id);
  Future<Either<Failure, DailyActivitiesEntity>> createDailyActivity(DailyActivitiesEntity dailyActivity);
  Future<Either<Failure, DailyActivitiesEntity>> updateDailyActivity(DailyActivitiesEntity dailyActivity);
  Future<Either<Failure, void>> deleteDailyActivity(String id);
}