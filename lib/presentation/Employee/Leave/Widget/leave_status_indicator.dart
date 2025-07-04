import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';

class LeaveStatusIndicator extends StatelessWidget {
  final String status;
  const LeaveStatusIndicator({super.key, required this.status});

  /// Returns the color associated with each leave status.
  /// If the status is not recognized, it returns grey [Which is very much unlikely to happen].
  /// This widget represent the status of a leave request which are [Pending, Approved, Rejected].

  Color _getStatusColor() {
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

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: statusColor,
          width: 1,
        ),
      ),
      child: AppTextstyle(
        text: "Status: $status",
        style: appStyle(
          color: statusColor,
          fontWeight: FontWeight.w600,
          size: 14,
        ),
      ),
    );
  }
}
