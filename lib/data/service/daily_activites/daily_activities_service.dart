import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/data/models/daily_activities/daily_activities_model.dart';
import 'package:fleekhr/domain/entities/dailyActivities/daily_activities_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class DailyActivitiesAPIService {
  Future<Either<Failure, List<DailyActivitiesEntity>>> getAllActivities(
      String employeeId);
  Future<Either<Failure, DailyActivitiesEntity>> getActivityById(String id);
  Future<Either<Failure, DailyActivitiesEntity>> createActivity(
      DailyActivitiesEntity activity);
  Future<Either<Failure, DailyActivitiesEntity>> updateActivity(
      DailyActivitiesEntity activity);
  Future<Either<Failure, void>> deleteActivity(String id);
}

class DailyActivitiesServiceImpl implements DailyActivitiesAPIService {
  final SupabaseClient _supabaseClient;
  static const String _tableName = 'daily_activities';

  DailyActivitiesServiceImpl(this._supabaseClient);

  @override
  Future<Either<Failure, List<DailyActivitiesEntity>>> getAllActivities(
      String employeeId) async {
    try {
      final response = await _supabaseClient
          .from(_tableName)
          .select()
          .eq('employee_id', employeeId)
          .order('created_at', ascending: false);

      final List<DailyActivitiesEntity> activities = (response as List)
          .map((json) => DailyActivitiesModel.fromJson(json).toEntity())
          .toList();
      return Right(activities);
    } on PostgrestException catch (e) {
      return Left(ServerFailure('Database error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, DailyActivitiesEntity>> getActivityById(
      String id) async {
    try {
      final response = await _supabaseClient
          .from(_tableName)
          .select('*')
          .eq('id', id)
          .single();

      final activity = DailyActivitiesModel.fromJson(response).toEntity();
      return Right(activity);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        return Left(NotFoundFailure('Activity not found'));
      }
      return Left(ServerFailure('Database error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, DailyActivitiesEntity>> createActivity(
      DailyActivitiesEntity activity) async {
    try {
      final activityModel = DailyActivitiesModel.fromEntity(activity);
      final data = activityModel.toJson();

      // Remove id for insertion as it should be auto-generated
      data.remove('id');

      final response =
          await _supabaseClient.from(_tableName).insert(data).select().single();

      final createdActivity =
          DailyActivitiesModel.fromJson(response).toEntity();
      return Right(createdActivity);
    } on PostgrestException catch (e) {
      return Left(ServerFailure('Database error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteActivity(String id) async {
    try {
      // First check if activity exists
      final checkResponse =
          await _supabaseClient.from(_tableName).select().eq('id', id).single();

      // ignore: unnecessary_null_comparison
      if (checkResponse == null) {
        return Left(NotFoundFailure('Activity not found'));
      }
      await _supabaseClient.from(_tableName).delete().eq('id', id);

      return const Right(null);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        return Left(NotFoundFailure('Activity not found'));
      }
      return Left(ServerFailure('Database error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, DailyActivitiesEntity>> updateActivity(
      DailyActivitiesEntity activity) async {
    try {
      final activityModel = DailyActivitiesModel.fromEntity(activity);
      final data = activityModel.toJson();

      // Ensure the ID is present for the update
      if (data['id'] == null) {
        return Left(InvalidInputFailure('Activity ID is required for update'));
      }

      final response = await _supabaseClient
          .from(_tableName)
          .update(data)
          .eq('id', data['id'])
          .select()
          .single();

      final updatedActivity =
          DailyActivitiesModel.fromJson(response).toEntity();
      return Right(updatedActivity);
    } on PostgrestException catch (e) {
      return Left(ServerFailure('Database error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
