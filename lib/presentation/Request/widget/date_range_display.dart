import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Displays selected date range and total days
class DateRangeDisplay extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final int totalDays;

  const DateRangeDisplay({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _DateDisplay(
            label: "Starting From",
            date: startDate,
            icon: CupertinoIcons.calendar_badge_plus,
          ),
          _TotalDaysCounter(
            totalDays: totalDays.toString(),
            color: primaryColor,
          ),
          _DateDisplay(
            label: "Ending At",
            date: endDate,
            icon: CupertinoIcons.calendar_badge_minus,
          ),
        ],
      ),
    );
  }
}

/// Displays a single date with label and icon
class _DateDisplay extends StatelessWidget {
  final String label;
  final DateTime date;
  final IconData icon;

  const _DateDisplay({
    required this.label,
    required this.date,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(width: 6.w),
            Text(
              "${date.day}/${date.month}/${date.year}",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Displays total days counter
class _TotalDaysCounter extends StatelessWidget {
  final String totalDays;
  final Color color;

  const _TotalDaysCounter({
    required this.totalDays,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Total Days",
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            totalDays,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}