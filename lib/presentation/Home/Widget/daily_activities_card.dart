import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TaskStatus {
  completed,
  onProgress,
  notStarted,
  suspended,
  cancelled,
}

class DailyActivitiesCard extends StatelessWidget {
  final String taskTitle;
  final String completionPercentage;
  final String taskDate;
  final TaskStatus status;

  const DailyActivitiesCard({
    super.key,
    required this.taskTitle,
    required this.completionPercentage,
    required this.taskDate,
    required this.status,
  });

  Color _getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.completed:
        return Colors.green.withOpacity(0.5);
      case TaskStatus.onProgress:
        return Colors.yellow.withOpacity(0.5);
      case TaskStatus.notStarted:
        return Colors.red.withOpacity(0.5);
      case TaskStatus.suspended:
        return Colors.purple.withOpacity(0.5);
      case TaskStatus.cancelled:
        return Colors.black.withOpacity(0.5);
      }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 14,
              decoration: BoxDecoration(
                color: _getStatusColor(status),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextstyle(
                      text: taskTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      completionPercentage,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: AppTextstyle(
                text: taskDate,
                style: appStyle(
                  size: 15.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
