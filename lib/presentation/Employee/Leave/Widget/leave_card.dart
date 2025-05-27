import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class LeaveRequestCard extends StatelessWidget {
  final String employeeName;
  final String leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final String leaveCategory; // Full or Half
  final int duration; // Number of days
  final String status; // Pending, Accepted, Rejected
  final VoidCallback? onTap; // Optional tap callback

  const LeaveRequestCard({
    super.key,
    required this.employeeName,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.leaveCategory,
    required this.duration,
    required this.status,
    this.onTap,
  });

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  // Get status color based on status
  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.amber;
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Employee Name and Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    employeeName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getStatusColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: _getStatusColor(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Leave Details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildDetailColumn(context, 'Leave Type', leaveType),
                  buildDetailColumn(context, 'Category', leaveCategory),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildDetailColumn(
                      context, 'Start Date', _formatDate(startDate)),
                  buildDetailColumn(context, 'End Date', _formatDate(endDate)),
                ],
              ),
              const SizedBox(height: 8),
              buildDetailColumn(context, 'Duration',
                  '$duration day${duration != 1 ? 's' : ''}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailColumn(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextstyle(
          text: label,
          style: appStyle(
              size: 15.sp,
              color:
                  Theme.of(context).textTheme.bodySmall?.color ?? Colors.black,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
