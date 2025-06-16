import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appStyle({
  required double size,
  required Color color,
  required FontWeight fontWeight,
  double? height,
  double? letterSpacing,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
}) {
  //  Ensure minimum font size to prevent assertion errors
  final double safeFontSize = (size.sp).clamp(8.0, 100.0);

  return GoogleFonts.nunitoSans(
    fontSize: safeFontSize,
    color: color,
    fontWeight: fontWeight,
    height: height,
    letterSpacing: letterSpacing,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
  );
}

//  Add a safe text style function as backup
TextStyle safeTextStyle({
  required double size,
  required Color color,
  required FontWeight fontWeight,
  double? height,
  double? letterSpacing,
}) {
  return TextStyle(
    fontSize: size.clamp(8.0, 72.0), // No ScreenUtil here
    color: color,
    fontWeight: fontWeight,
    height: height,
    letterSpacing: letterSpacing,
  );
}
