import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/repository/dailyActivites/daily_activities_repo.dart';


class DeleteActivityUsecase implements Usecase<Either<Failure, void>, String> {
  final DailyActivitiesRepository repository;

  DeleteActivityUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call({required String params}) async {
    return await repository.deleteDailyActivity(params);
  }
}