import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF6200EE).withOpacity(0.8),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF6200EE).withOpacity(0.8),
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF6200EE).withOpacity(0.8),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF6200EE).withOpacity(0.8),
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
