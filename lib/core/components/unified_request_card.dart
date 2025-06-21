import 'dart:ui';

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
            color: Colors.blueGrey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
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
    Color cardBg = Theme.of(context).cardColor;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(1, 3),
          ),
        ],
      ),
      child: content,
    );
  }

  // Returns gradient colors based on request type as only one color shade will be used
  // for the card background

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
        Container(
          margin: EdgeInsets.only(right: 8.w),
          padding: EdgeInsets.only(left: 16.w, top: 3.h, bottom: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with employee name
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                headerContent(context),
                statusState(status),
              ]),
              SizedBox(height: 5.h),
              // Request-specific content
              requestSpecificContent(context),
              // Status positioned at bottom right for all card types
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

  Widget statusState(String status) {
    Color getStatusColor() {
      switch (status.toLowerCase()) {
        case 'approved':
          return Colors.lightGreen;
        case 'pending':
          return Colors.orange;
        case 'rejected':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: getStatusColor(),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 14,
                        color: getStatusColor(),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
