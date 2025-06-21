import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final Color primaryColor = const Color(0xFFff6b35);
final Color secondaryColor = const Color(0xFFF1E4F3);
final Color lightBackground = const Color(0xFFF4F6F8);
final Color darkBackground = const Color(0xFF1E1B18);
final Color lightText = const Color(0xFF1E1E1E);
final Color darkText = const Color(0xFFFFFFFF);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: lightBackground,
  canvasColor: secondaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: lightBackground,
    iconTheme: IconThemeData(color: lightText),
    titleTextStyle: appStyle(
      size: 20.sp,
      color: lightText, // Use lightText for light theme
      fontWeight: FontWeight.w600,
    ),
  ),
  cardColor: Colors.white,
  cardTheme: CardTheme(
    color: Colors.white,
    shadowColor: Colors.black.withOpacity(0.1),
    elevation: 4,
  ),
  textTheme: TextTheme(
    bodyLarge:
        appStyle(size: 16.sp, color: lightText, fontWeight: FontWeight.normal),
    bodyMedium:
        appStyle(size: 14.sp, color: lightText, fontWeight: FontWeight.normal),
    headlineLarge:
        appStyle(size: 24.sp, color: lightText, fontWeight: FontWeight.bold),
    // Add more text styles as needed
  ),
  //button Color
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: darkBackground,
  canvasColor: secondaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: darkBackground,
    iconTheme: IconThemeData(color: darkText),
    titleTextStyle: appStyle(
      size: 20.sp,
      color: darkText, // Use darkText for dark theme
      fontWeight: FontWeight.w600,
    ),
  ),
  cardColor: secondaryColor.withOpacity(0.5),
  cardTheme: CardTheme(
    color: darkBackground.withOpacity(0.5),
    shadowColor: Colors.white.withOpacity(0.1),
    elevation: 4,
  ),
  textTheme: TextTheme(
    bodyLarge:
        appStyle(size: 16.sp, color: darkText, fontWeight: FontWeight.normal),
    bodyMedium:
        appStyle(size: 14.sp, color: darkText, fontWeight: FontWeight.normal),
    headlineLarge:
        appStyle(size: 24.sp, color: darkText, fontWeight: FontWeight.bold),
    // Add more text styles as needed
  ),
);
