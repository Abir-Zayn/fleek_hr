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
  return GoogleFonts.nunitoSans(
    // ✅ Use ScreenUtil's responsive sizing
    fontSize: size.sp, // This ensures consistent scaling
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

// ✅ Alternative: Create a fallback style function
TextStyle appStyleSafe({
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
  try {
    return GoogleFonts.nunitoSans(
      fontSize: size.sp,
      color: color,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  } catch (e) {
    // Fallback to default TextStyle if GoogleFonts fails
    return TextStyle(
      fontSize: size.sp,
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
}
