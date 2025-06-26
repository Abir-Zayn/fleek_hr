import 'package:fleekhr/common/bloc/theme_cubit.dart';
import 'package:fleekhr/core/config/appconfig.dart';
import 'package:fleekhr/core/navigation/app_router_imports.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: Appconfig.supabaseURL,
    anonKey: Appconfig.anonKey,
  );
  // Initialize service locator
  await initalizeDependencies();
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
    Size screenSize = MediaQuery.of(context).size;

    return ScreenUtilInit(
      designSize: Size(screenSize.width, screenSize.height),
      minTextAdapt: true,
      ensureScreenSize: true,
      splitScreenMode: false,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ThemeCubit()),
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
      },
    );
  }
}
