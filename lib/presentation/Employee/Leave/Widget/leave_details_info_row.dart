import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A widget that displays detailed information about a leave request.
class LeaveDetailsInfoRow extends StatelessWidget {
  final String label;
  final String value;
  const LeaveDetailsInfoRow(
      {super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextstyle(
            text: label,
            style: appStyle(
              size: 16.sp,
              color: Theme.of(context).textTheme.bodyLarge?.color ??
                  Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: AppTextstyle(
              text: value,
              textAlign: TextAlign.end,
              style: appStyle(
                size: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700]!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
