import 'package:fleekhr/common/bloc/theme_cubit.dart';
import 'package:fleekhr/core/config/appconfig.dart';
import 'package:fleekhr/core/navigation/app_router_imports.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/presentation/Auth/login/cubit/login_cubit.dart';
import 'package:fleekhr/presentation/Employee/Leave/cubit/leave_cubit.dart';
import 'package:fleekhr/presentation/Employee/Profile/cubit/profile_cubit.dart';
import 'package:fleekhr/presentation/Employee/work_from_home/cubit/work_from_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  applyTheme();

  await Supabase.initialize(
    url: Appconfig.supabaseURL,
    anonKey: Appconfig.anonKey,
  );
  // Initialize service locator
  await initializeDependencies();
  runApp(const Main());
}

void applyTheme() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => sl<LoginCubit>()),
        BlocProvider(create: (_) => sl<ProfileCubit>()),
        BlocProvider(create: (_) => sl<LeaveCubit>()),
        BlocProvider(create: (_) => sl<WorkFromHomeCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: theme,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
