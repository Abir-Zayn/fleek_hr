part of 'app_router_imports.dart';

final GlobalKey<NavigatorState> appRouterKey = GlobalKey<NavigatorState>();
final GoRouter _router =
    GoRouter(navigatorKey: appRouterKey, initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashscreenOne(),
  ),
  GoRoute(
    path: '/onboard',
    builder: (context, state) => const Onboard(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: '/dailyactivities',
    builder: (context, state) => DailyactivitiesPage(
      isAdmin: state.extra is bool ? state.extra as bool : false,
    ),
  ),
  GoRoute(
    path: '/entry',
    builder: (context, state) => const BottomNavigationPage(),
  ),
  GoRoute(
    path: '/workfromhome',
    builder: (context, state) => const WorkFromHomeScreen(),
  ),
  GoRoute(
    path: '/leavereq',
    builder: (context, state) => const AnnualleavePage(),
  ),
  GoRoute(
    path: '/add-leave',
    builder: (context, state) => const LeaveRequestScreen(),
  ),
  GoRoute(
    path: '/expense',
    builder: (context, state) => ExpenseScreen(
      repository:
          sl<ExpenseRepository>(), // Use service locator instead of state.extra
      expenseModel:
          state.extra is ExpenseModel ? state.extra as ExpenseModel : null,
    ),
  ),
  GoRoute(
    path: '/profileupdate',
    builder: (context, state) => const ProfileUpdate(),
  ),
  GoRoute(
    path: '/admin-dashboard',
    builder: (context, state) => const AdminHomeScreen(),
  ),
  GoRoute(
    path: '/admin-home',
    builder: (context, state) => const AdminNavigation(),
  ),
  GoRoute(
    path: '/manage-employees',
    builder: (context, state) => const ManageEmployee(),
  ),
  GoRoute(
      path: '/add-employee',
      builder: (context, state) {
        return const AddEmployee();
      }),
]);

GoRouter get appRouter => _router;
