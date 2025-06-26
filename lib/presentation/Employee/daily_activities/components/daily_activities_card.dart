import 'dart:ui';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';

/// A simplified card widget to display daily activity/task information.
/// Displays task name, assignee, completion date, and status.

class DailyActivitiesCard extends StatelessWidget {
  final String? id;
  final String? status; // 'pending', 'accepted', 'rejected'
  final String taskName;
  final String assignedTo;
  final String completionDate;
  final VoidCallback? onTap;
  final String startedAt;

  const DailyActivitiesCard({
    super.key,
    required this.taskName,
    required this.assignedTo,
    required this.completionDate,
    this.status,
    this.onTap,
    required this.startedAt,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: dataCard(
        context,
        Container(
          padding: EdgeInsets.only(left: 16, top: 3, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with task name and status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  headerContent(context),
                  statusState(status ?? 'pending'),
                ],
              ),
              SizedBox(height: 5),
              // Task details
              taskDetailsContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget dataCard(BuildContext context, Widget content) {
    Color cardBg = Theme.of(context).cardColor;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: content,
    );
  }

  Widget headerContent(BuildContext context) {
    return AppTextstyle(
      text: taskName,
      style: appStyle(
        size: 13,
        fontWeight: FontWeight.w700,
        color: Colors.grey.shade800,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
    );
  }

  Widget taskDetailsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Assigned to
        Row(
          children: [
            Icon(
              Icons.person,
              size: 16,
              color: Colors.grey.shade700,
            ),
            SizedBox(width: 8),
            AppTextstyle(
              text: 'Assigned to: $assignedTo',
              style: appStyle(
                size: 14,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        // Completion date
        Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 16,
              color: Colors.grey.shade700,
            ),
            SizedBox(width: 8),
            AppTextstyle(
              text: 'started at: $startedAt',
              style: appStyle(
                size: 14,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.calendar_today,
              size: 16,
              color: Colors.grey.shade700,
            ),
            SizedBox(width: 8),
            AppTextstyle(
              text: 'completed at: $completionDate',
              style: appStyle(
                size: 14,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget statusState(String status) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
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
                    color: getStatusColor(status),
                  ),
                  const SizedBox(width: 6),
                  AppTextstyle(
                    text: status,
                    style: appStyle(
                      size: 14,
                      color: getStatusColor(status),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Returns a color based on the status string.
  /// Used for status indicator chip background and text color.
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'in progress':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }
}
