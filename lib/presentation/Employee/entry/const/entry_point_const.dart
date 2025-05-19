//const values for entry point styling or bottom navigation bar styling
import 'package:flutter/material.dart';

class NavBarStyles {
  // Private constructor to prevent instantiation
  NavBarStyles._();

  // Navigation bar layout
  static const double navBarHeight = 100.0;
  static const double navBarElevation = 4.0;

  // Icon and label styling
  static const double iconSize = 28.0;
  static const double labelFontSize = 12.0;

  // Animation settings
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Curve animationCurve = Curves.easeInOutCubic;
}
