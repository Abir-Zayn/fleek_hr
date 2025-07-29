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
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 12,
              offset: const Offset(1, 4),
            ),
          ],
          border: Border.all(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with task name and status
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: headerContent(context),
                  ),
                  const SizedBox(width: 12),
                  statusBadge(status ?? 'pending'),
                ],
              ),
              const SizedBox(height: 16),
              // Task details
              taskDetailsContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextstyle(
          text: taskName,
          style: appStyle(
            size: 16,
            fontWeight: FontWeight.w700,
            color:
                Theme.of(context).textTheme.titleLarge?.color ?? Colors.black87,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Container(
          height: 3,
          width: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget taskDetailsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Assigned to row
        _buildDetailRow(
          icon: Icons.person_outline,
          label: 'Assigned to',
          value: assignedTo,
          color: Colors.blue,
        ),
        const SizedBox(height: 12),
        // Started at row
        _buildDetailRow(
          icon: Icons.play_circle_outline,
          label: 'Started at',
          value: startedAt,
          color: Colors.green,
        ),
        const SizedBox(height: 12),
        // Completed at row
        _buildDetailRow(
          icon: Icons.check_circle_outline,
          label: 'Completed at',
          value: completionDate,
          color: Colors.orange,
        ),
      ],
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            size: 16,
            color: color,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextstyle(
                text: label,
                style: appStyle(
                  size: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              AppTextstyle(
                text: value,
                style: appStyle(
                  size: 14,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget statusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: getStatusColor(status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: getStatusColor(status).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: getStatusColor(status),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          AppTextstyle(
            text: _formatStatus(status),
            style: appStyle(
              size: 12,
              color: getStatusColor(status),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatStatus(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'Completed';
      case 'in progress':
        return 'In Progress';
      case 'pending':
        return 'Pending';
      default:
        return status;
    }
  }

  /// Returns a color based on the status string.
  /// Used for status indicator chip background and text color.
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return const Color(0xFF10B981); // Modern green
      case 'in progress':
        return const Color(0xFFF59E0B); // Modern amber
      case 'pending':
        return const Color(0xFF6B7280); // Modern gray
      default:
        return const Color(0xFFEF4444); // Modern red
    }
  }
}
