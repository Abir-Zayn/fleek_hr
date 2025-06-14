import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});


  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  PageController monthController = PageController();
  DateTime selectedMonth = DateTime.now();

  // Sample data for different months
  final Map<String, Map<String, int>> monthlyData = {
    '2025-06': {
      'Working Days': 22,
      'On Time': 18,
      'Late': 4,
      'Left Timely': 20,
      'Left Early': 2,
      'On Leave': 1,
      'Absent': 0,
    },
    '2025-05': {
      'Working Days': 20,
      'On Time': 15,
      'Late': 3,
      'Left Timely': 18,
      'Left Early': 1,
      'On Leave': 2,
      'Absent': 1,
    },
  };

  // Generate daily reports dynamically based on selected month
  List<Map<String, dynamic>> generateDailyReports(DateTime month) {
    List<Map<String, dynamic>> reports = [];
    DateTime now = DateTime.now();

    // Get the number of days in the selected month
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;

    // If it's current month, only show days up to today
    int maxDay = (month.year == now.year && month.month == now.month)
        ? now.day
        : daysInMonth;

    // Generate reports for each day (in reverse order - latest first)
    for (int day = maxDay; day >= 1; day--) {
      DateTime date = DateTime(month.year, month.month, day);

      // Sample logic for different statuses (you can customize this)
      String status;
      bool isAbsent = false;
      String inTime = '05:28 AM';
      String outTime = '01:28 PM';

      // Sample status generation (customize based on your logic)
      if (day % 7 == 0) {
        // Every 7th day is absent
        status = 'Absent';
        isAbsent = true;
        inTime = '';
        outTime = '';
      } else if (day % 5 == 0) {
        // Every 5th day is late
        status = 'Late';
        inTime = '09:15 AM';
        outTime = '05:30 PM';
      } else if (day % 3 == 0) {
        // Every 3rd day left early
        status = 'Left Early';
        inTime = '05:28 AM';
        outTime = '12:00 PM';
      } else {
        // Default is on time
        status = 'On Time';
        inTime = '05:28 AM';
        outTime = '01:28 PM';
      }

      reports.add({
        'date': date,
        'day': DateFormat('EEEE').format(date),
        'inTime': inTime,
        'outTime': outTime,
        'status': status,
        'isAbsent': isAbsent,
      });
    }

    return reports;
  }

  // Get icon and color for each status
  Map<String, dynamic> getStatusStyle(String status) {
    switch (status) {
      case 'Working Days':
        return {'icon': Icons.work, 'color': Colors.blue};
      case 'On Time':
        return {'icon': Icons.check_circle, 'color': Colors.green};
      case 'Late':
        return {'icon': Icons.schedule, 'color': Colors.orange};
      case 'Left Timely':
        return {'icon': Icons.exit_to_app, 'color': Colors.green};
      case 'Left Early':
        return {'icon': Icons.logout, 'color': Colors.orange};
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
    String monthKey = DateFormat('yyyy-MM').format(selectedMonth);
    Map<String, int> currentMonthStats =
        monthlyData[monthKey] ?? monthlyData['2025-06']!;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Month Selector
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedMonth = DateTime(
                            selectedMonth.year, selectedMonth.month - 1);
                      });
                    },
                    icon: const Icon(Icons.chevron_left),
                  ),
                  Text(
                    DateFormat('MMMM yyyy').format(selectedMonth),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedMonth = DateTime(
                            selectedMonth.year, selectedMonth.month + 1);
                      });
                    },
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),

            // Monthly Stats Cards
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: currentMonthStats.entries.map((entry) {
                  final style = getStatusStyle(entry.key);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: style['color'].withOpacity(0.6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            entry.key,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          entry.value == 1
                              ? '${entry.value} day'
                              : '${entry.value} days',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Daily Report Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Daily Report',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Daily Reports
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: generateDailyReports(selectedMonth)
                    .asMap()
                    .entries
                    .map((entry) {
                  final index = entry.key;
                  final report = entry.value;
                  final isLast =
                      index == generateDailyReports(selectedMonth).length - 1;

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
                            Text(
                              report['day'],
                              style: const TextStyle(
                                color: Colors.black45,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat('dd').format(report['date']),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
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
                                  const Text(
                                    'IN',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
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
                                          : Colors.green.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      report['isAbsent']
                                          ? 'Absent'
                                          : report['inTime'],
                                      style: TextStyle(
                                        color: report['isAbsent']
                                            ? Colors.white70
                                            : Colors.green[300],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Text(
                                    'OUT',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
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
                                          : Colors.orange.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      report['isAbsent']
                                          ? 'Absent'
                                          : report['outTime'],
                                      style: TextStyle(
                                        color: report['isAbsent']
                                            ? Colors.white70
                                            : Colors.orange[300],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
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
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
