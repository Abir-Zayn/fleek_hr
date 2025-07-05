import 'package:fleekhr/domain/usecase/auth/login_usecase.dart';
import 'package:fleekhr/presentation/Auth/login/cubit/login_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:fleekhr/data/service/auth/auth_service.dart';
import 'package:fleekhr/data/repositories/auth/auth_repo_impl.dart';
import 'package:fleekhr/domain/repository/auth/auth_repository.dart';
import 'package:fleekhr/domain/usecase/auth/getuser_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // 1. Register SupabaseServices
  final supabase = Supabase.instance.client;
  sl.registerLazySingleton<SupabaseClient>(() => supabase);

  // 2. Register AuthService
  sl.registerLazySingleton<AuthService>(
      () => AuthServiceImplementation(sl<SupabaseClient>()));

  // 3. Register AuthRepository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepoImpl());

  // 4. Register UseCases
  sl.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase());
  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase());

  // 5. Register Blocs
  sl.registerLazySingleton<LoginCubit>(() => LoginCubit());
  // Will be implemented later
}
