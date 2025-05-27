import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/presentation/Employee/Leave/Widget/leave_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveSummaryCard extends StatelessWidget {
  final String year;
  final List<LeaveIndicatorData> leaveIndicators;
  final String title;

  const LeaveSummaryCard({
    super.key,
    required this.year,
    required this.leaveIndicators,
    this.title = "Available Leave",
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextstyle(
                  text: title,
                  style: appStyle(
                    size: 18.sp,
                    color: Theme.of(context).textTheme.titleLarge?.color ??
                        Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppTextstyle(
                  text: year,
                  style: appStyle(
                    size: 14.sp,
                    color: Theme.of(context).textTheme.bodyMedium?.color ??
                        Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // Leave balance indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: leaveIndicators
                  .map(
                    (indicator) => LeaveIndicatorWidget(
                      title: indicator.title,
                      total: indicator.total,
                      used: indicator.used,
                      color: indicator.color,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaveIndicatorData {
  final String title;
  final String total;
  final String used;
  final Color color;

  LeaveIndicatorData({
    required this.title,
    required this.total,
    required this.used,
    required this.color,
  });
}