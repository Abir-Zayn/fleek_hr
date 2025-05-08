import 'package:fleekhr/presentation/Auth/forget_pass.dart';
import 'package:fleekhr/presentation/Auth/login_page.dart';
import 'package:fleekhr/presentation/Auth/reg_page.dart';
import 'package:fleekhr/presentation/Home/entrypoint.dart';
import 'package:fleekhr/presentation/Leave/Screen/annualleave_page.dart';
import 'package:fleekhr/presentation/Request/screen/workform_homescreen.dart';
import 'package:fleekhr/presentation/expense/Screen/expense_screen.dart';
import 'package:fleekhr/presentation/splash/splashscreen_one.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> appRouterKey = GlobalKey<NavigatorState>();
final GoRouter _router =
    GoRouter(navigatorKey: appRouterKey, initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashscreenOne(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: '/reg',
    builder: (context, state) => const RegPage(),
  ),
  GoRoute(
    path: '/forget',
    builder: (context, state) => const ForgetPass(),
  ),
  GoRoute(
    path: '/entry',
    builder: (context, state) => const BottomNavigationPage(),
  ),
  GoRoute(
    path: '/workfromhome',
    builder: (context, state) => const WorkformHomescreen(),
  ),
  GoRoute(
    path: '/leavereq',
    builder: (context, state) => const AnnualleavePage(),
  ),
  GoRoute(
    path:'/expense',
    builder: (context, state) => const ExpenseScreen(),
  ),
]);

GoRouter get appRouter => _router;
