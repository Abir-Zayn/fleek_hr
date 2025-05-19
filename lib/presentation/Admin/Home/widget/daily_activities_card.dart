import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyActivitiesCard extends StatelessWidget {
  final String taskName;
  final String assignedTo; // e.g., "Completed by John Doe"
  final String completionDate;
  final double progress; // Value between 0.0 and 1.0

  final Color progressColor;
  const DailyActivitiesCard(
      {super.key,
      required this.taskName,
      required this.assignedTo,
      required this.completionDate,
      required this.progress,
      required this.progressColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 1.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(children: <Widget>[
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 5,
                  backgroundColor: theme.colorScheme.onSurface.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                ),
                Icon(
                  progress == 1.0 ? Icons.check_circle : Icons.hourglass_empty,
                  color: progress == 1.0
                      ? progressColor
                      : theme.iconTheme.color?.withOpacity(0.5),
                  size: 20,
                )
              ],
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
                  color: Theme.of(context).textTheme.bodyMedium?.color ??
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
          ))
        ]),
      ),
    );
  }
}
