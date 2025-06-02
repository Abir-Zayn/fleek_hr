import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:fleekhr/data/models/leave_request/leave_data_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// A widget that displays action buttons based on user role and leave status
class ActionButtons extends StatelessWidget {
  final LeaveDataCard leave;
  final bool isAdmin;
  final VoidCallback onEdit;

  const ActionButtons({
    super.key,
    required this.leave,
    required this.isAdmin,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    // Only show buttons for pending requests
    if (leave.status.toLowerCase() != 'pending') {
      return statusMessage(leave.status.toLowerCase());
    }

    return isAdmin ? adminFeaturesBtn(context) : employeeFeaturesBtn(context);
  }

  /// Builds admin action buttons (Approve/Reject)
  Widget adminFeaturesBtn(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade100,
              foregroundColor: Colors.red,
            ),
            onPressed: () => confirmationDialog(
              context,
              "Reject Leave Request",
              "Are you sure you want to reject this leave request?",
              false,
            ),
            child: const Text("Reject"),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade100,
              foregroundColor: Colors.green,
            ),
            onPressed: () => confirmationDialog(
              context,
              "Approve Leave Request",
              "Are you sure you want to approve this leave request?",
              true,
            ),
            child: const Text("Approve"),
          ),
        ),
      ],
    );
  }

  ///  employee action buttons (Edit/Delete)
  Widget employeeFeaturesBtn(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade100,
              foregroundColor: Colors.red,
            ),
            onPressed: () => confirmationDialog(
              context,
              "Delete Leave Request",
              "Are you sure you want to delete this leave request?",
              false,
            ),
            child: const Text("Delete"),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).primaryColor,
            ),
            onPressed: onEdit,
            child: AppTextstyle(
              text: "Edit",
              style: appStyle(
                size: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Shows a message when leave is not pending
  Widget statusMessage(String status) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        "This request has already been $status",
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  /// Shows a confirmation dialog for actions
  void confirmationDialog(
    BuildContext context,
    String title,
    String message,
    bool isApprove,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              snackBarAction(context, isApprove);
            },
            child: AppTextstyle(
              text: isAdmin
                  ? (isApprove ? 'Approve' : 'Reject')
                  : (isApprove ? 'Edit' : 'Delete'),
              style: appStyle(
                color: isApprove ? Colors.green : Colors.red,
                size: 15.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Handles the action after confirmation
  void snackBarAction(BuildContext context, bool isApprove) {
    if (isAdmin) {
      // Admin approval/rejection logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isApprove
              ? "Leave request approved successfully"
              : "Leave request rejected"),
          backgroundColor: isApprove ? Colors.green : Colors.red,
        ),
      );
      context.pop();
    } else {
      if (isApprove) {
        onEdit();
      } else {
        // Delete operation
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Leave request deleted successfully"),
            backgroundColor: Colors.red,
          ),
        );
        context.pop();
      }
    }
  }
}
