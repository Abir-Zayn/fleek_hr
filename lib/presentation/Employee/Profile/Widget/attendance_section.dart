import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/presentation/Employee/Profile/Widget/attendence_bar_chart.dart';
import 'package:flutter/material.dart';

class AttendanceSection extends StatelessWidget {
  final List<double> monthlyAttendance;

  const AttendanceSection({
    super.key,
    required this.monthlyAttendance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextstyle(
                  text: "Attendance",
                  style: appStyle(
                    size: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.titleLarge?.color ??
                        Colors.black,
                  ),
                ),
                AppTextstyle(
                  text: "2025",
                  style: appStyle(
                    size: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: AnimatedOpacity(
              opacity: monthlyAttendance.isNotEmpty ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastLinearToSlowEaseIn,
              child: AttendenceBarChart(
                monthlyAttendence: monthlyAttendance,
              ),
            ),
          ),
        ],
      ),
    );
  }
}