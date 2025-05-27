import 'package:fleekhr/common/widgets/app_action_btn.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A card widget to display daily activity/task information, including progress,
/// assignment details, status, and admin action buttons.
///
/// Displays a progress indicator, task name, assignee, completion date, and
/// status. If `isAdmin` is true, shows Accept/Reject buttons when appropriate.

class DailyActivitiesCard extends StatelessWidget {
  /// The name/title of the task
  /// The user to whom the task is assigned
  /// The date the task is to be completed by
  /// The progress of the task (0.0 to 1.0)
  /// The color of the progress bar
  ///  Whether the current user is an admin (controls visibility of action buttons)
  /// Admin action callbacks for accepting or rejecting the task

  final String? status; // 'pending', 'accepted', 'rejected'
  final String taskName;
  final String assignedTo;
  final String completionDate;
  final double progress;
  final bool isAdmin;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const DailyActivitiesCard({
    super.key,
    required this.taskName,
    required this.assignedTo,
    required this.completionDate,
    required this.progress,
    this.isAdmin = false, // Default to false (non-admin)
    this.onAccept,
    this.onReject,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(1, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                // Status indicator
                if (status != null)
                  Container(
                    margin: EdgeInsets.only(right: 8.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: getStatusColor(status!).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      status!.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: getStatusColor(status!),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextstyle(
                        text: taskName,
                        style: appStyle(
                          size: 15.sp,
                          color:
                              Theme.of(context).textTheme.bodyMedium?.color ??
                                  Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      AppTextstyle(
                        text: assignedTo,
                        style: appStyle(
                          size: 13.sp,
                          color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color
                                  ?.withOpacity(0.7) ??
                              Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      AppTextstyle(
                        text: completionDate,
                        style: appStyle(
                          size: 12.sp,
                          color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color
                                  ?.withOpacity(0.5) ??
                              Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Admin action buttons - only visible when isAdmin is true
            if (isAdmin && (status == null || status == 'pending'))
              Padding(
                padding: EdgeInsets.only(top: 12.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Reject and Accept buttons
                    AppActionBtn(
                      label: '',
                      onPressed: onReject,
                      backgroundColor: Colors.white,
                      textColor: Colors.red,
                      icon: Icons.close,
                      borderColor: Colors.red,
                    ),
                    SizedBox(width: 8.0.w),
                    AppActionBtn(
                      label: '',
                      onPressed: onAccept,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      icon: Icons.check,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Returns a color based on the status string.
  /// Used for status indicator chip background and text color.
  Color getStatusColor(String status) {
    switch (status) {
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
