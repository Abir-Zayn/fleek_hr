import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'daily_report_item.dart';

class DailyReportsSection extends StatelessWidget {
  final List<Map<String, dynamic>> dailyReports;

  const DailyReportsSection({
    super.key,
    required this.dailyReports,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Daily Report Header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: AppTextstyle(
              text: 'Daily Report',
              style: appStyle(
                size: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Daily Reports List
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: dailyReports.asMap().entries.map((entry) {
              final index = entry.key;
              final report = entry.value;
              final isLast = index == dailyReports.length - 1;

              return DailyReportItem(
                report: report,
                isLast: isLast,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
