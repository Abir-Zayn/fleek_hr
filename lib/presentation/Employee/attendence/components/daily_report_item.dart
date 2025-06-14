import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyReportItem extends StatelessWidget {
  final Map<String, dynamic> report;
  final bool isLast;

  const DailyReportItem({
    super.key,
    required this.report,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: !isLast
            ? const Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 0.5,
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          // Date Section
          Column(
            children: [
              AppTextstyle(
                text: report['day'],
                style: appStyle(
                  color: Colors.black45,
                  size: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              AppTextstyle(
                text: DateFormat('dd').format(report['date']),
                style: appStyle(
                  color: Colors.black,
                  size: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(width: 24),

          // Time Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppTextstyle(
                      text: 'IN',
                      style: appStyle(
                        color: Colors.black,
                        size: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: report['isAbsent']
                            ? Colors.grey[600]
                            : Colors.green,
                      ),
                      child: AppTextstyle(
                        text: report['isAbsent'] ? 'Absent' : report['inTime'],
                        style: appStyle(
                          color: Colors.white,
                          size: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    AppTextstyle(
                      text: 'OUT',
                      style: appStyle(
                        color: Colors.black,
                        size: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                          color: report['isAbsent']
                              ? Colors.grey[600]
                              : Colors.green),
                      child: AppTextstyle(
                        text: report['isAbsent'] ? 'Absent' : report['outTime'],
                        style: appStyle(
                          color: Colors.white,
                          size: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
