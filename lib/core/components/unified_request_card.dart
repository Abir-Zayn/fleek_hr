import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/core/components/enum/request_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class UnifiedRequestCard extends StatelessWidget {
  final String id;
  final String employeeName;
  final String status;
  final RequestType requestType;
  final bool isAdmin;
  final VoidCallback? onTap;
  final Function(bool)? onStatusChange;

  // Leave-specific fields
  final String? leaveType;
  final DateTime? startDate;
  final DateTime? endDate;

  // Expense-specific fields
  final double? amount;
  final DateTime? expenseDate;

  // Work from home-specific fields
  final String? reason;

  const UnifiedRequestCard({
    super.key,
    required this.id,
    required this.employeeName,
    required this.status,
    required this.requestType,
    this.isAdmin = false,
    this.onTap,
    this.onStatusChange,
    // Leave fields
    this.leaveType,
    this.startDate,
    this.endDate,
    // Expense fields
    this.amount,
    this.expenseDate,
    // WFH fields
    this.reason,
  });

  // Factory constructor for leave request
  factory UnifiedRequestCard.leave({
    required String id,
    required String employeeName,
    required String status,
    required String leaveType,
    required DateTime startDate,
    required DateTime endDate,
    bool isAdmin = false,
    VoidCallback? onTap,
    Function(bool)? onStatusChange,
  }) {
    return UnifiedRequestCard(
      id: id,
      employeeName: employeeName,
      status: status,
      requestType: RequestType.leave,
      isAdmin: isAdmin,
      onTap: onTap,
      onStatusChange: onStatusChange,
      leaveType: leaveType,
      startDate: startDate,
      endDate: endDate,
    );
  }

  // Factory constructor for expense request
  factory UnifiedRequestCard.expense({
    required String id,
    required String employeeName,
    required String status,
    required double amount,
    required DateTime expenseDate,
    bool isAdmin = false,
    VoidCallback? onTap,
    Function(bool)? onStatusChange,
  }) {
    return UnifiedRequestCard(
      id: id,
      employeeName: employeeName,
      status: status,
      requestType: RequestType.expense,
      isAdmin: isAdmin,
      onTap: onTap,
      onStatusChange: onStatusChange,
      amount: amount,
      expenseDate: expenseDate,
    );
  }

  // Factory constructor for work from home request
  factory UnifiedRequestCard.workFromHome({
    required String id,
    required String employeeName,
    required String status,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
    bool isAdmin = false,
    VoidCallback? onTap,
    Function(bool)? onStatusChange,
  }) {
    return UnifiedRequestCard(
      id: id,
      employeeName: employeeName,
      status: status,
      requestType: RequestType.workFromHome,
      isAdmin: isAdmin,
      onTap: onTap,
      onStatusChange: onStatusChange,
      startDate: startDate,
      endDate: endDate,
      reason: reason,
    );
  }

  String formateDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  Color getStatusColor() {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String navigationRoute() {
    switch (requestType) {
      case RequestType.leave:
        return '/leave-details/$id';
      case RequestType.expense:
        return '/expense-details/$id';
      case RequestType.workFromHome:
        return '/wfh-details/$id';
    }
  }

  // It will return the specific content based on the request type
  Widget requestSpecificContent(BuildContext context) {
    switch (requestType) {
      case RequestType.leave:
        return leaveContent();
      case RequestType.expense:
        return expenseContent();
      case RequestType.workFromHome:
        return workFromHomeContent();
    }
  }

  // Leave Content
  Widget leaveContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Leave type with attractive styling
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(6.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          child: AppTextstyle(
            text: leaveType ?? '',
            style: appStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
              size: 12.sp,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        // Date information
        dateRow(startDate!, 'Starting'),
        SizedBox(height: 4.h),
        dateRow(endDate!, 'Ending'),
      ],
    );
  }

  Widget expenseContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.attach_money,
              size: 16.sp,
              color: Colors.grey.shade700,
            ),
            SizedBox(width: 4.w),
            AppTextstyle(
              text: 'Amount: \$${amount?.toStringAsFixed(2) ?? '0.00'}',
              style: appStyle(
                size: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 16.sp,
              color: Colors.grey.shade700,
            ),
            SizedBox(width: 4.w),
            AppTextstyle(
              text: 'Date: ${formateDate(expenseDate!)}',
              style: appStyle(
                size: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget workFromHomeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dateRow(startDate!, 'Starting'),
        SizedBox(height: 4.h),
        dateRow(endDate!, 'Ending'),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(
              Icons.description,
              size: 16.sp,
              color: Colors.grey.shade700,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: AppTextstyle(
                text: 'Reason: ${reason ?? ''}',
                style: appStyle(
                  size: 14.sp,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget dateRow(DateTime date, String label) {
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          size: 16.sp,
          color: Colors.grey.shade700,
        ),
        SizedBox(width: 8.w),
        AppTextstyle(
          text: '$label: ${formateDate(date)}',
          style: appStyle(
            size: 14.sp,
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget dataCard(BuildContext context, Widget content) {
    // Get gradient colors based on request type
    List<Color> gradientColors = getGradientColors();

    return Card(
      elevation: 4,
      color: Colors.white,
      shadowColor: Colors.black12,
      margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradientColors),
        ),
        child: content,
      ),
    );
  }

  // Returns gradient colors based on request type as only one color shade will be used
  // for the card background
  List<Color> getGradientColors() {
    return [
      Colors.deepOrange.shade100,
      Colors.deepOrange.shade200,
      Colors.deepOrange.shade300,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            if (requestType == RequestType.workFromHome) {
              // Use Navigator for WFH (keeping original navigation pattern)
              Navigator.pushNamed(
                context,
                navigationRoute(),
                arguments: {'isAdmin': isAdmin},
              );
            } else {
              // Use GoRouter for Leave and Expense
              context.push(
                navigationRoute(),
                extra: {'isAdmin': isAdmin},
              );
            }
          },
      child: dataCard(
        context,
        Padding(
          padding: EdgeInsets.only(left: 16.w, top: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with employee name
              headerContent(context),
              SizedBox(height: 10.h),
              // Request-specific content
              requestSpecificContent(context),
              // Status positioned at bottom right for all card types
              statusState(),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerContent(BuildContext context) {
    return AppTextstyle(
      text: employeeName,
      style: appStyle(
        size: 13.sp,
        fontWeight: FontWeight.w700,
        color: Colors.grey.shade800,
      ),
    );
  }

  Widget statusState() {
    return SizedBox(
      height: 33.h,
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 6.h,
            horizontal: 10.w,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
            ),
          ),
          child: AppTextstyle(
            text: status,
            style: appStyle(
              size: 15.sp,
              color: getStatusColor(),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
