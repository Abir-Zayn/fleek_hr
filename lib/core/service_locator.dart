import 'package:fleekhr/data/repositories/auth/auth_repo_impl.dart';
import 'package:fleekhr/data/service/auth/auth_service.dart';
import 'package:fleekhr/domain/repository/auth/auth_repository.dart';
import 'package:fleekhr/domain/usecase/auth/login_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initalizeDependencies() async {
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  // [Core] Internet connection check
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker.createInstance());

  //auth
  sl.registerSingleton<AuthService>(
      AuthServiceImplementation(sl<SupabaseClient>()));
  sl.registerSingleton<AuthRepository>(AuthRepoImpl());

  sl.registerSingleton<LoginUsecase>(LoginUsecase());
  //data src

  //repository

  //Registering services
  //Expense Service

  // sl.registerSingleton<GetExpenseUseCase>(GetExpenseUseCase(
  //   sl<ExpenseRepository>()));
}
