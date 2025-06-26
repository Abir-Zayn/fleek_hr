part of 'app_router_imports.dart';

final GlobalKey<NavigatorState> appRouterKey = GlobalKey<NavigatorState>();
final GoRouter _router = GoRouter(
    navigatorKey: appRouterKey,
    initialLocation: '/',
    errorBuilder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Page Not Found')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('Page not found: ${state.uri}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  child: const Text('Go Home'),
                ),
              ],
            ),
          ),
        ),
    routes: [
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
        path: '/daily-activities-details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final activity = DailyActivitesCardSrc.dailyActivitiesDemoData
              .firstWhere((e) => e.id == id);
          return DailyactivitiesDetailedPage(model: activity);
        },
      ),

      GoRoute(
        path: '/workfromhome',
        builder: (context, state) => const WorkFromHomeScreen(),
      ),

      GoRoute(
        path: '/work-from-home-request-form',
        builder: (context, state) => const AddWorkFromHomeScreen(),
      ),
      GoRoute(
          path: '/attendance', builder: (context, state) => AttendanceScreen()),

      GoRoute(
        path: '/add-leave',
        builder: (context, state) => const LeaveRequestScreen(),
      ),

      // Update the empty leave-details route
      GoRoute(
        path: '/leave-details/:id',
        builder: (context, state) {
          final leaveId = state.pathParameters['id'] ?? '';
          final isAdmin = state.uri.queryParameters['isAdmin'] == 'true';

          // Find the leave by ID
          final leave = LeaveDataCardSrc.leaveDemoData.firstWhere(
            (leave) => leave.id == leaveId,
            orElse: () => LeaveDataCardSrc.leaveDemoData.first, // Fallback
          );

          return LeaveDetailScreen(
            leave: leave,
            isAdmin: isAdmin,
          );
        },
      ),

      GoRoute(
        path: '/leave-history',
        builder: (context, state) => const LeaveHistoryScreen(),
      ),

      GoRoute(
        path: '/salary-overview',
        builder: (context, state) => const SalaryOverviewScreen(),
      ),
      GoRoute(
          path: '/salary-details',
          builder: (context, state) => const SalaryDetailsPage()),

      GoRoute(
        path: '/expense',
        builder: (context, state) => const ExpenseScreen(),
      ),
      GoRoute(
        path: '/add-expense',
        builder: (context, state) => const AddExpenseScreen(),
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
