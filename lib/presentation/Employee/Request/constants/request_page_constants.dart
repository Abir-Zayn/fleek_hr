import 'package:flutter/material.dart';
import '../widget/request_dashboard_widget.dart';

/// Constants and configuration for request page
/// Contains all static data and configuration used across request components
class RequestPageConstants {
  /// Private constructor to prevent instantiation
  RequestPageConstants._();

  /// Spacing constants
  static const double defaultPadding = 20.0;
  static const double cardSpacing = 16.0;
  static const double headerSpacing = 24.0;
  static const double sectionSpacing = 32.0;
  static const double bottomPadding = 40.0;

  /// Grid configuration
  static const int gridCrossAxisCount = 2;
  static const double gridAspectRatio = 1.1;

  /// Animation durations
  static const Duration containerAnimationDuration =
      Duration(milliseconds: 300);
  static const Duration staggerAnimationBase = Duration(milliseconds: 300);
  static const int staggerAnimationIncrement = 100;

  /// Typography configuration
  static const double titleFontSize = 22.0;
  static const double subtitleFontSize = 14.0;
  static const FontWeight titleFontWeight = FontWeight.w700;
  static const FontWeight subtitleFontWeight = FontWeight.w500;
  static const double titleLetterSpacing = -0.5;
  static const double subtitleLineHeight = 1.3;

  /// Dialog configuration
  static const double dialogBorderRadius = 16.0;
  static const double dialogIconSize = 24.0;
  static const double dialogTitleFontSize = 18.0;
  static const double dialogContentFontSize = 14.0;
  static const double dialogContentLineHeight = 1.4;

  /// Request categories data
  static const List<RequestCategoryData> requestCategories = [
    RequestCategoryData(
      icon: Icons.laptop_mac,
      text: "Work From Home",
      color: Colors.blue,
      description: 'Remote work request',
      route: '/workfromhome',
    ),
    RequestCategoryData(
      icon: Icons.event_busy_rounded,
      text: "Leave Request",
      color: Colors.pink,
      description: 'Apply for time off',
      route: '/leave-history',
    ),
    RequestCategoryData(
      icon: Icons.receipt_long_outlined,
      text: "Expense Claim",
      color: Colors.teal,
      description: 'Submit expenses',
      route: '/expense',
    ),
    RequestCategoryData(
      icon: Icons.assignment_outlined,
      text: "Task Request",
      color: Colors.orange,
      description: 'Request assignments',
      route: '/dailyactivities',
    ),
    RequestCategoryData(
      icon: Icons.headset_mic_outlined,
      text: 'IT Support',
      color: Colors.purple,
      description: 'Get tech support',
      route: null,
    ),
    RequestCategoryData(
      icon: Icons.access_time_filled,
      text: "Attendance",
      color: Colors.green,
      description: 'View attendance',
      route: '/attendance',
    ),
    RequestCategoryData(
      icon: Icons.account_balance_wallet_outlined,
      text: "Salary Request",
      color: Colors.amber,
      description: 'Salary inquiries',
      route: '/salary-overview',
    ),
    RequestCategoryData(
      icon: Icons.group_outlined,
      text: "Manage Employees",
      color: Colors.cyan,
      description: 'HR management',
      route: '/manage-employees',
    ),
  ];

  /// Text constants
  static const String pageTitle = "What would you like to request?";
  static const String pageSubtitle = "Select a category to submit your request";
  static const String comingSoonTitle = "Coming Soon";
  static const String comingSoonContentTemplate =
      "\$feature is currently under development and will be available in future updates.";
  static const String dialogButtonText = "Got it";
  static const String retryButtonText = "Retry";
  static const String navigationErrorTemplate =
      "Failed to open \$feature. Please try again.";

  /// Color opacity values
  static const double backgroundGradientOpacity = 0.05;
}
