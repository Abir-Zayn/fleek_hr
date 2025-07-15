import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/domain/entities/work_from_home/work_from_home_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class WorkFromHomeAPIService {
  Future<Either<Failure, List<WorkFromHomeEntity>>> getAllWFHRequest(
      String employeeId);
  Future<Either<Failure, WorkFromHomeEntity>> getWFHRequestById(String id);
  Future<Either<Failure, WorkFromHomeEntity>> createWFHRequest(
      WorkFromHomeEntity workFromHomeRequest);
  Future<Either<Failure, WorkFromHomeEntity>> updateWFHRequest(
      WorkFromHomeEntity workFromHomeRequest);
  Future<Either<Failure, void>> deleteWFHRequest(String id);
}

class WorkFromHomeServiceImpl implements WorkFromHomeAPIService {
  final SupabaseClient _supabaseClient;

  WorkFromHomeServiceImpl(this._supabaseClient);

  @override
  Future<Either<Failure, List<WorkFromHomeEntity>>> getAllWFHRequest(
      String employeeId) async {
    try {
      // Query the work_from_home_with_employee view to get data with employee names
      final response = await _supabaseClient
          .from('work_from_home_with_employee')
          .select()
          .eq('employee_id', employeeId)
          .order('created_at', ascending: false);

      final List<WorkFromHomeEntity> workFromHomeList = response
          .map<WorkFromHomeEntity>((json) => WorkFromHomeEntity.fromJson(json))
          .toList();

      return Right(workFromHomeList);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WorkFromHomeEntity>> getWFHRequestById(
      String id) async {
    try {
      final response = await _supabaseClient
          .from('work_from_home_with_employee')
          .select()
          .eq('id', id)
          .single();

      final workFromHome = WorkFromHomeEntity.fromJson(response);
      return Right(workFromHome);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WorkFromHomeEntity>> createWFHRequest(
      WorkFromHomeEntity workFromHomeRequest) async {
    try {
      // Prepare data for insertion with all necessary fields
      final Map<String, dynamic> requestData = {
        'start_date': workFromHomeRequest.startDate.toIso8601String(),
        'end_date': workFromHomeRequest.endDate.toIso8601String(),
        'reason': workFromHomeRequest.reason,
        'employee_id': workFromHomeRequest.employeeId,
        'status': workFromHomeRequest.status.toString().split('.').last,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      // Get the current authenticated user
      final currentUser = _supabaseClient.auth.currentUser;

      if (currentUser == null) {
        return Left(ServerFailure('User not authenticated'));
      }

      // Ensure the user is only creating requests for themselves
      if (currentUser.id != workFromHomeRequest.employeeId) {
        return Left(ServerFailure('You can only create requests for yourself'));
      }

      // Insert the data and return the created record
      final response = await _supabaseClient
          .from('work_from_home')
          .insert(requestData)
          .select('*, employee:employee_id(name)')
          .single();

      // Transform the response to include employee_name
      final Map<String, dynamic> transformedResponse = {
        ...response,
        'employee_name': response['employee']['name'],
      };

      final createdRequest = WorkFromHomeEntity.fromJson(transformedResponse);
      return Right(createdRequest);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WorkFromHomeEntity>> updateWFHRequest(
      WorkFromHomeEntity workFromHomeRequest) async {
    try {
      // Prepare data for update
      final Map<String, dynamic> requestData = {
        'start_date': workFromHomeRequest.startDate.toIso8601String(),
        'end_date': workFromHomeRequest.endDate.toIso8601String(),
        'reason': workFromHomeRequest.reason,
        'status': workFromHomeRequest.status.toString().split('.').last,
      };

      // Update the record and return the updated data
      final response = await _supabaseClient
          .from('work_from_home')
          .update(requestData)
          .eq('id', workFromHomeRequest.id)
          .select('*, employee(name)')
          .single();

      // Transform the response to include employee_name
      final Map<String, dynamic> transformedResponse = {
        ...response,
        'employee_name': response['employee']['name'],
      };

      final updatedRequest = WorkFromHomeEntity.fromJson(transformedResponse);
      return Right(updatedRequest);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteWFHRequest(String id) async {
    try {
      await _supabaseClient.from('work_from_home').delete().eq('id', id);
      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
