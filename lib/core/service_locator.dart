import 'package:fleekhr/data/repositories/expense/expense_repo_impl.dart';
import 'package:fleekhr/data/repositories/leave/leave_request_repo_impl.dart';
import 'package:fleekhr/data/repositories/work_from_home/work_from_home_repo_impl.dart';
import 'package:fleekhr/data/repositories/attendance/attendance_repo_impl.dart';
import 'package:fleekhr/data/service/expense/expense_service.dart';
import 'package:fleekhr/data/service/leave_req/leave_request_service_impl.dart';
import 'package:fleekhr/data/service/wfh_req/wfh_api_service.dart';
import 'package:fleekhr/data/service/attendance/attendance_service.dart';
import 'package:fleekhr/domain/repository/expense/expense_repo.dart';
import 'package:fleekhr/domain/repository/leave/leave_request_repository.dart';
import 'package:fleekhr/domain/repository/work_from_home/work_from_home_repo.dart';
import 'package:fleekhr/domain/repository/attendance/attendance_repository.dart';
import 'package:fleekhr/domain/usecase/auth/login_usecase.dart';
import 'package:fleekhr/domain/usecase/auth/updateprofile_usecase.dart';
import 'package:fleekhr/domain/usecase/expense/create_expense_usecase.dart';
import 'package:fleekhr/domain/usecase/expense/delete_expense_usecase.dart';
import 'package:fleekhr/domain/usecase/expense/get_all_expense_usecase.dart';
import 'package:fleekhr/domain/usecase/expense/get_expense_by_id_usecase.dart';
import 'package:fleekhr/domain/usecase/leave/createLeaveRequest_usecase.dart';
import 'package:fleekhr/domain/usecase/leave/deleteLeaveRequest_usecase.dart';
import 'package:fleekhr/domain/usecase/leave/getLeaveBalance_usecase.dart';
import 'package:fleekhr/domain/usecase/leave/getLeaveRequestByID_usecase.dart';
import 'package:fleekhr/domain/usecase/leave/getLeaveRequest_usecase.dart';
import 'package:fleekhr/domain/usecase/leave/updateLeaveRequest_usecase.dart';
import 'package:fleekhr/domain/usecase/work_from_home/createWorkFromHomeRequest_usecase.dart';
import 'package:fleekhr/domain/usecase/work_from_home/deleteWorkFromHomeRequest_usecase.dart';
import 'package:fleekhr/domain/usecase/work_from_home/getWorkFromHomeALL_usecase.dart';
import 'package:fleekhr/domain/usecase/work_from_home/getWorkFromHomeRequest_ID_usecase.dart';
import 'package:fleekhr/domain/usecase/attendance/checkin_usecase.dart';
import 'package:fleekhr/domain/usecase/attendance/checkout_usecase.dart';
import 'package:fleekhr/domain/usecase/attendance/get_today_attendance_usecase.dart';
import 'package:fleekhr/domain/usecase/attendance/get_attendance_history_usecase.dart';
import 'package:fleekhr/domain/usecase/attendance/get_monthly_attendance_usecase.dart';
import 'package:fleekhr/domain/usecase/attendance/get_daily_attendance_by_month_usecase.dart';
import 'package:fleekhr/presentation/Auth/login/cubit/login_cubit.dart';
import 'package:fleekhr/presentation/Employee/Leave/cubit/leave_cubit.dart';
import 'package:fleekhr/presentation/Employee/Profile/cubit/profile_cubit.dart';
import 'package:fleekhr/presentation/Employee/expense/cubit/expense_cubit.dart';
import 'package:fleekhr/presentation/Employee/work_from_home/cubit/work_from_home_cubit.dart';
import 'package:fleekhr/presentation/Employee/attendence/cubit/attendance_cubit.dart';
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

  // 2. Register Services
  sl.registerLazySingleton<AuthService>(
      () => AuthServiceImplementation(sl<SupabaseClient>()));
  sl.registerLazySingleton<LeaveRequestService>(
    () => LeaveRequestServiceImpl(sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<WorkFromHomeAPIService>(
    () => WorkFromHomeServiceImpl(sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<ExpenseAPIService>(
    () => ExpenseServiceImpl(sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<AttendanceService>(
    () => AttendanceServiceImplementation(sl<SupabaseClient>()),
  );

  // 3. Register Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepoImpl());
  sl.registerLazySingleton<LeaveRequestRepository>(
    () => LeaveRequestRepoImpl(),
  );
  sl.registerLazySingleton<WorkFromHomeRepository>(
    () => WorkFromHomeRepoImpl(),
  );
  sl.registerLazySingleton<ExpenseRepository>(() => ExpenseRepoImpl());
  sl.registerLazySingleton<AttendanceRepository>(() => AttendanceRepoImpl());

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
  // Register Leave Balance Use Case (using existing LeaveRequestRepository)
  sl.registerLazySingleton<GetEmployeeLeaveBalanceUseCase>(
    () => GetEmployeeLeaveBalanceUseCase(sl<LeaveRequestRepository>()),
  );

  sl.registerLazySingleton<DeleteLeaveRequestUseCase>(
    () => DeleteLeaveRequestUseCase(sl<LeaveRequestRepository>()),
  );

  // Work From Home UseCases
  sl.registerLazySingleton<CreateworkfromhomerequestUsecase>(
    () => CreateworkfromhomerequestUsecase(sl<WorkFromHomeRepository>()),
  );
  sl.registerLazySingleton<GetworkfromhomeallUsecase>(
    () => GetworkfromhomeallUsecase(sl<WorkFromHomeRepository>()),
  );
  sl.registerLazySingleton<GetworkfromhomerequestIdUsecase>(
    () => GetworkfromhomerequestIdUsecase(sl<WorkFromHomeRepository>()),
  );
  sl.registerLazySingleton<DeleteworkfromhomerequestUsecase>(
    () => DeleteworkfromhomerequestUsecase(sl<WorkFromHomeRepository>()),
  );

  // Expense Usecases
  sl.registerLazySingleton<CreateExpenseUsecase>(
    () => CreateExpenseUsecase(sl<ExpenseRepository>()),
  );
  sl.registerLazySingleton<GetAllExpenseUsecase>(
    () => GetAllExpenseUsecase(sl<ExpenseRepository>()),
  );
  sl.registerLazySingleton<GetExpenseByIdUsecase>(
    () => GetExpenseByIdUsecase(sl<ExpenseRepository>()),
  );
  sl.registerLazySingleton<DeleteExpenseUsecase>(
    () => DeleteExpenseUsecase(sl<ExpenseRepository>()),
  );

  // Attendance UseCases
  sl.registerLazySingleton<CheckInUseCase>(() => CheckInUseCase());
  sl.registerLazySingleton<CheckOutUseCase>(() => CheckOutUseCase());
  sl.registerLazySingleton<GetTodayAttendanceUseCase>(() => GetTodayAttendanceUseCase());
  sl.registerLazySingleton<GetAttendanceHistoryUseCase>(() => GetAttendanceHistoryUseCase());
  sl.registerLazySingleton<GetMonthlyAttendanceUseCase>(() => GetMonthlyAttendanceUseCase());
  sl.registerLazySingleton<GetDailyAttendanceByMonthUseCase>(() => GetDailyAttendanceByMonthUseCase());

  // 5. Register Blocs
  sl.registerLazySingleton<LoginCubit>(() => LoginCubit());
  sl.registerLazySingleton<ProfileCubit>(() => ProfileCubit());
  sl.registerLazySingleton<LeaveCubit>(() => LeaveCubit());
  sl.registerLazySingleton<WorkFromHomeCubit>(() => WorkFromHomeCubit());
  sl.registerLazySingleton<ExpenseCubit>(() => ExpenseCubit());
  sl.registerLazySingleton<AttendanceCubit>(() => AttendanceCubit());

  // Will be implemented later
}
