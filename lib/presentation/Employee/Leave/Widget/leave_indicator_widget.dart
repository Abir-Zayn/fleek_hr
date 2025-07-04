import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';


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
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.1),
              ),
            ),
            // Inner circle with data
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: color, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextstyle(
                    text: used,
                    style: appStyle(
                      size: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  AppTextstyle(
                    text: "days",
                    style: appStyle(
                      size: 12,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        AppTextstyle(
          text: title,
          style: appStyle(
            size: 14,
            fontWeight: FontWeight.w500,
            color:
                Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
          ),
        ),
      ],
    );
  }
}
