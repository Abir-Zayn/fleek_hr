import 'package:dartz/dartz.dart';
import 'package:fleekhr/data/models/auth/user_login.dart';
import 'package:fleekhr/data/models/auth/user_model.dart';
import 'package:fleekhr/domain/entities/auth/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthService {
  Future<Either> login(UserLogin userLogin);
  Future<Either> getUser();
  Future<Either> logout();
}

class AuthServiceImplementation implements AuthService {
  final SupabaseClient _supabaseClient;

  // Accept SupabaseClient as a parameter instead of directly accessing Supabase.instance
  AuthServiceImplementation(this._supabaseClient);

  //login
  @override
  Future<Either> login(UserLogin userLogin) async {
    try {
      await _supabaseClient.auth.signInWithPassword(
        email: userLogin.email,
        password: userLogin.password,
      );
      return Right('Signin successful');
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Get user profile data
  @override
  Future<Either> getUser() async {
    try {
      final user = _supabaseClient.auth.currentUser;
      if (user != null) {
        UserModel userModel = UserModel.fromJson(user.toJson());
        UserEntity userEntity = userModel.toEntity();
        return Right(userEntity);
      } else {
        return Left('No user is currently logged in');
      }
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  // Logout
  @override
  Future<Either> logout() async {
    try {
      await _supabaseClient.auth.signOut();
      return Right('Logout successful');
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }
}
