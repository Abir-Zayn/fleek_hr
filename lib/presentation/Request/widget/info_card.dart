import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Displays information about the WFH request process
class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      margin: EdgeInsets.only(bottom: 24.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      elevation: 1,
      color: Colors.blue.shade50,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Icon(
              CupertinoIcons.info_circle,
              color: primaryColor,
              size: 24.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                "Please select your WFH dates and provide a reason. Your manager will be notified for approval.",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.blue.shade900,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
