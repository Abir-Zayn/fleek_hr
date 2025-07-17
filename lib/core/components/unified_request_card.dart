import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/core/components/enum/request_type.dart';
import 'package:flutter/material.dart';
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

  String formatDate(DateTime date) {
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
            borderRadius: BorderRadius.circular(6),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: AppTextstyle(
            text: leaveType ?? '',
            style: appStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
              size: 12,
            ),
          ),
        ),
        SizedBox(height: 10),
        // Date information
        dateRow(startDate!, 'Starting'),
        SizedBox(height: 4),
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
              size: 16,
              color: Colors.grey.shade700,
            ),
            SizedBox(width: 4),
            AppTextstyle(
              text: 'Amount: \$${amount?.toStringAsFixed(2) ?? '0.00'}',
              style: appStyle(
                size: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 16,
              color: Colors.grey.shade700,
            ),
            SizedBox(width: 4),
            AppTextstyle(
              text: 'Date: ${formatDate(expenseDate!)}',
              style: appStyle(
                size: 14,
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
        SizedBox(height: 4),
        dateRow(endDate!, 'Ending'),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.description,
              size: 16,
              color: Colors.grey.shade700,
            ),
            SizedBox(width: 8),
            Expanded(
              child: AppTextstyle(
                text: 'Reason: ${reason ?? ''}',
                style: appStyle(
                  size: 14,
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
          size: 16,
          color: Colors.grey.shade700,
        ),
        SizedBox(width: 8),
        AppTextstyle(
          text: '$label: ${formatDate(date)}',
          style: appStyle(
            size: 14,
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Color getTypeColor() {
    switch (requestType) {
      case RequestType.leave:
        return Colors.blue;
      case RequestType.expense:
        return Colors.green;
      case RequestType.workFromHome:
        return Colors.purple;
    }
  }

  Icon getTypeIcon() {
    switch (requestType) {
      case RequestType.leave:
        return Icon(Icons.beach_access, color: getTypeColor(), size: 20);
      case RequestType.expense:
        return Icon(Icons.attach_money, color: getTypeColor(), size: 20);
      case RequestType.workFromHome:
        return Icon(Icons.home_work, color: getTypeColor(), size: 20);
    }
  }

  Widget dataCard(BuildContext context, Widget content) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: getTypeColor(), width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: content,
    );
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
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with icon, employee name, and status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      getTypeIcon(),
                      SizedBox(width: 8),
                      AppTextstyle(
                        text: employeeName,
                        style: appStyle(
                          size: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ],
                  ),
                  statusState(status),
                ],
              ),
              SizedBox(height: 12),
              // Request-specific content
              requestSpecificContent(context),
              // Admin controls if applicable
              if (isAdmin && status.toLowerCase() == 'pending') ...[
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => onStatusChange?.call(false),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      child: Text(
                        'Reject',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      onPressed: () => onStatusChange?.call(true),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.green,
                      ),
                      child: Text(
                        'Approve',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget statusState(String status) {
    Color getStatusColor() {
      switch (status.toLowerCase()) {
        case 'approved':
          return Colors.green;
        case 'pending':
          return Colors.orange;
        case 'rejected':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    Color color = getStatusColor();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, size: 8, color: color),
          SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
