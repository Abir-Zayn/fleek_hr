import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/data/models/auth/user_login.dart';
import 'package:fleekhr/data/models/auth/employee_model.dart';
import 'package:fleekhr/domain/entities/auth/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthService {
  Future<Either<Failure, String>> login(UserLogin userLogin);
  Future<Either<Failure, EmployeeEntity>> getUser();
  Future<Either<Failure, String>> logout();
  Future<Either<Failure, EmployeeEntity>> updateProfile(
      EmployeeEntity employee);
}

class AuthServiceImplementation implements AuthService {
  final SupabaseClient _supabaseClient;

  AuthServiceImplementation(this._supabaseClient);
// Login

  @override
  Future<Either<Failure, String>> login(UserLogin userLogin) async {
    try {
      if (userLogin.email.isEmpty || userLogin.password.isEmpty) {
        return Left(InvalidInputFailure('Email and password cannot be empty'));
      }

      final response = await _supabaseClient.auth.signInWithPassword(
        email: userLogin.email,
        password: userLogin.password,
      );

      if (response.user != null) {
        return Right('Login successful');
      } else {
        return Left(UnauthorizedFailure('Invalid credentials'));
      }
    } on AuthException catch (e) {
      if (e.statusCode == '400') {
        return Left(InvalidInputFailure(e.message));
      } else if (e.statusCode == '401') {
        return Left(UnauthorizedFailure(e.message));
      } else {
        return Left(ServerFailure(e.message));
      }
    } catch (e) {
      return Left(UnknownFailure('Login error: ${e.toString()}'));
    }
  }

  // Get user profile data
  @override
  Future<Either<Failure, EmployeeEntity>> getUser() async {
    try {
      final user = _supabaseClient.auth.currentUser;
      if (user != null) {
        try {
          // Fetch the employee data from the database
          final response = await _supabaseClient
              .from('employee')
              .select()
              .eq('id', user.id)
              .single();

          EmployeeModel userModel = EmployeeModel.fromJson(response);
          EmployeeEntity userEntity = userModel.toEntity();
          return Right(userEntity);
        } catch (e) {
          return Left(NotFoundFailure('User profile not found'));
        }
      } else {
        return Left(UnauthorizedFailure('No user is currently logged in'));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to get user: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, EmployeeEntity>> updateProfile(
      EmployeeEntity employee) async {
    try {
      final user = _supabaseClient.auth.currentUser;
      if (user != null) {
        // convert entitiy to model
        final employeeModel = EmployeeModel.fromEntity(employee);

        // Update the employee data in the database
        final response = await _supabaseClient
            .from('employee')
            .update(employeeModel.toJson())
            .eq('id', user.id)
            .select()
            .single();

        // convert the updated data back to entity
        final updatedemployeeModel =
            EmployeeModel.fromJson(response).toEntity();
        return Right(updatedemployeeModel);
      } else {
        return Left(UnauthorizedFailure('No user is currently logged in'));
      }
    } catch (e) {
      if (e is AuthException) {
        return Left(UnauthorizedFailure('Update failed: ${e.message}'));
      } else if (e is PostgrestException) {
        return Left(ServerFailure('Database error: ${e.message}'));
      } else {
        return Left(UnknownFailure('Update error: ${e.toString()}'));
      }
    }
  }

  // Logout
  @override
  Future<Either<Failure, String>> logout() async {
    try {
      await _supabaseClient.auth.signOut();
      return Right('Logout successful');
    } catch (e) {
      return Left(ServerFailure('Logout failed: ${e.toString()}'));
    }
  }
}
