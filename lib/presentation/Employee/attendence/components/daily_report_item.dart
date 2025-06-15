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
                  color: Colors.black12,
                  width: 0.5,
                ),
              )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Date Section
          SizedBox(
            width: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
          ),

          const SizedBox(width: 24),

          // Time Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // IN Time Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 35,
                      child: AppTextstyle(
                        text: 'IN',
                        style: appStyle(
                          color: Colors.black,
                          size: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: report['isAbsent']
                            ? Colors.grey[600]
                            : Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: AppTextstyle(
                        text: report['isAbsent'] ? 'Absent' : report['inTime'],
                        style: appStyle(
                          color: Colors.white,
                          size: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // OUT Time Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 35,
                      child: AppTextstyle(
                        text: 'OUT',
                        style: appStyle(
                          color: Colors.black,
                          size: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: report['isAbsent']
                            ? Colors.grey[600]
                            : Colors.green, // ✅ Reverted to green
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: AppTextstyle(
                        text: report['isAbsent'] ? 'Absent' : report['outTime'],
                        style: appStyle(
                          color: Colors.white, // ✅ White text
                          size: 12,
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
