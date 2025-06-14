import 'package:intl/intl.dart';

class ReportDataGenerator {
  static const Map<String, Map<String, int>> monthlyData = {
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

  static List<Map<String, dynamic>> generateDailyReports(DateTime month) {
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
}
