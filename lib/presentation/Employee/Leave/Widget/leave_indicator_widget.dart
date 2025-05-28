import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveIndicatorWidget extends StatelessWidget {
  final String title;

  final String used;
  final Color color;

  const LeaveIndicatorWidget({
    super.key,
    required this.title,
    required this.used,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Circle background
            Container(
              width: 70.w,
              height: 70.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.1),
              ),
            ),
            // Inner circle with data
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: color, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    used,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  AppTextstyle(
                    text: "days",
                    style: appStyle(
                      size: 12.sp,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        AppTextstyle(
          text: title,
          style: appStyle(
            size: 14.sp,
            fontWeight: FontWeight.w500,
            color:
                Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
          ),
        ),
       
      ],
    );
  }
}
