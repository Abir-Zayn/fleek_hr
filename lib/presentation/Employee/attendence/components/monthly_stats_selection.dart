import 'package:fleekhr/presentation/Employee/attendence/components/monthlyStats.dart';
import 'package:flutter/material.dart';

class MonthlyStatsSection extends StatelessWidget {
  final Map<String, int> monthlyStats;

  const MonthlyStatsSection({
    super.key,
    required this.monthlyStats,
  });

  Map<String, dynamic> getStatusStyle(String status) {
    switch (status) {
      case 'Working Days':
        return {'icon': Icons.work, 'color': Colors.blueAccent};
      case 'On Time':
        return {'icon': Icons.check_circle, 'color': Colors.green};
      case 'Late':
        return {'icon': Icons.schedule, 'color': Colors.orange};
      case 'Left Timely':
        return {'icon': Icons.exit_to_app, 'color': Colors.green};
      case 'Left Early':
        return {'icon': Icons.logout, 'color': Colors.red};
      case 'On Leave':
        return {'icon': Icons.beach_access, 'color': Colors.teal};
      case 'Absent':
        return {'icon': Icons.person_off, 'color': Colors.grey};
      default:
        return {'icon': Icons.info, 'color': Colors.grey};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: monthlyStats.entries.map((entry) {
          final style = getStatusStyle(entry.key);
          return Monthlystats(
            title: entry.key,
            value: entry.value,
            color: style['color'],
          );
        }).toList(),
      ),
    );
  }
}
