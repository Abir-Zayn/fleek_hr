import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Dialog displaying help information for WFH request process
class HelpDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "WFH Request Help",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HelpItem(
                text: "Select the date range you need to work from home",
                icon: Icons.calendar_today,
              ),
              SizedBox(height: 12.h),
              _HelpItem(
                text: "Provide a valid reason for your request",
                icon: CupertinoIcons.text_quote,
              ),
              SizedBox(height: 12.h),
              _HelpItem(
                text: "Submit your request for manager approval",
                icon: Icons.send,
              ),
              SizedBox(height: 12.h),
              _HelpItem(
                text: "You'll be notified once your request is processed",
                icon: CupertinoIcons.bell,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Close",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Individual help item with icon and text
class _HelpItem extends StatelessWidget {
  final String text;
  final IconData icon;

  const _HelpItem({
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18.sp,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
