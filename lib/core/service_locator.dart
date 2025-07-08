import 'package:fleekhr/data/repositories/leave/leave_request_repo_impl.dart';
import 'package:fleekhr/data/service/leave_req/leave_request_service_impl.dart';
import 'package:fleekhr/domain/repository/leave/leave_request_repository.dart';
import 'package:fleekhr/domain/usecase/auth/login_usecase.dart';
import 'package:fleekhr/domain/usecase/auth/updateprofile_usecase.dart';
import 'package:fleekhr/domain/usecase/leave/createLeaveRequest_usecase.dart';
import 'package:fleekhr/domain/usecase/leave/deleteLeaveRequest_usecase.dart';
import 'package:fleekhr/domain/usecase/leave/getLeaveRequestByID_usecase.dart';
import 'package:fleekhr/domain/usecase/leave/getLeaveRequest_usecase.dart';
import 'package:fleekhr/domain/usecase/leave/updateLeaveRequest_usecase.dart';
import 'package:fleekhr/presentation/Auth/login/cubit/login_cubit.dart';
import 'package:fleekhr/presentation/Employee/Leave/cubit/leave_cubit.dart';
import 'package:fleekhr/presentation/Employee/Profile/cubit/profile_cubit.dart';
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
  sl.registerLazySingleton<LeaveRequestService>(
    () => LeaveRequestServiceImpl(sl<SupabaseClient>()),
  );

  // 3. Register AuthRepository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepoImpl());
  sl.registerLazySingleton<LeaveRequestRepository>(
    () => LeaveRequestRepoImpl(),
  );
  // 4. Register UseCases
  sl.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase());
  sl.registerLazySingleton<UpdateProfileUseCase>(() => UpdateProfileUseCase());
  sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase());

  sl.registerLazySingleton<CreateLeaveRequestUseCase>(
    () => CreateLeaveRequestUseCase(sl<LeaveRequestRepository>()),
  );
  sl.registerLazySingleton<getAllLeaveRequestsUseCase>(
    () => getAllLeaveRequestsUseCase(sl<LeaveRequestRepository>()),
  );
  sl.registerLazySingleton<UpdateLeaveRequestUseCase>(
    () => UpdateLeaveRequestUseCase(sl<LeaveRequestRepository>()),
  );
  sl.registerLazySingleton<GetLeaveRequestByIdUseCase>(
    () => GetLeaveRequestByIdUseCase(sl<LeaveRequestRepository>()),
  );


  sl.registerLazySingleton<DeleteLeaveRequestUseCase>(
    () => DeleteLeaveRequestUseCase(sl<LeaveRequestRepository>()),
  );

  // 5. Register Blocs
  sl.registerLazySingleton<LoginCubit>(() => LoginCubit());
  sl.registerLazySingleton<ProfileCubit>(() => ProfileCubit());
  sl.registerLazySingleton<LeaveCubit>(() => LeaveCubit());
  // Will be implemented later
}
