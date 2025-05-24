part of 'history_screen_imports.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String selectedMonth = 'January';

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  //Demo Data
  final List<Map<String, dynamic>> attendanceData = [
    {
      'name': 'John Doe',
      'workingDays': 25,
      'present': 22,
      'absent': 1,
      'leave': 2,
      'hours': '176'
    },
    {
      'name': 'Jane Smith',
      'workingDays': 25,
      'present': 20,
      'absent': 3,
      'leave': 2,
      'hours': '160'
    },
    {
      'name': 'Alice Johnson',
      'workingDays': 25,
      'present': 23,
      'absent': 1,
      'leave': 1,
      'hours': '170'
    },
    {
      'name': 'Bob Brown',
      'workingDays': 25,
      'present': 24,
      'absent': 0,
      'leave': 1,
      'hours': '180'
    },
  ];

  void previousMonth() {
    int currentIndex = months.indexOf(selectedMonth);
    if (currentIndex > 0) {
      setState(() {
        selectedMonth = months[currentIndex - 1];
      });
    }
  }

  void nextMonth() {
    int currentIndex = months.indexOf(selectedMonth);
    if (currentIndex < months.length - 1) {
      setState(() {
        selectedMonth = months[currentIndex + 1];
      });
    }
  }

  String get formattedMonth {
    final monthIndex = months.indexOf(selectedMonth);
    return DateFormat('MMMM').format(DateTime(0, monthIndex + 1));
  }

  List<SummaryItem> get summaryItems {
    // Get data for current month
    final monthData = attendanceData.firstWhere(
      (data) => data['month'] == selectedMonth,
      orElse: () => attendanceData.first,
    );

    return [
      SummaryItem(
        label: 'Working Days',
        value: '${monthData['workingDays']} days',
        color: Colors.blue.shade200,
      ),
      SummaryItem(
        label: 'On Time',
        value: '${monthData['present']} days',
        color: Colors.green.shade400,
      ),
      SummaryItem(
        label: 'Late',
        value: '${monthData['leave']} days',
        color: Colors.red.shade400,
      ),
      SummaryItem(
        label: 'Left Timely',
        value: '${monthData['leftTimely']} days',
        color: Colors.green.shade400,
      ),
      SummaryItem(
        label: 'Left Early',
        value: '${monthData['leftEarly']} days',
        color: Colors.orange.shade400,
      ),
      SummaryItem(
        label: 'On Leave',
        value: '${monthData['onLeave']} days',
        color: Colors.purple.shade300,
      ),
      SummaryItem(
        label: 'Absent',
        value: '${monthData['absent']} days',
        color: Colors.red.shade400,
      ),
      SummaryItem(
        label: 'Left Later',
        value: '${monthData['leftLater']} days',
        color: Colors.blue.shade400,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          // Month Selector
          MonthSelector(
            currentMonth: formattedMonth,
            onPrevious: previousMonth,
            onNext: nextMonth,
          ),

          //Summary Card
          SizedBox(height: 2.h),
          SummaryCard(items: summaryItems),

          SizedBox(height: 12.h),
          attendenceTable(),
        ],
      ),
    );
  }

  Widget attendenceTable() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            //Table Header
            tableHeader(),
            //table rows
            ...attendanceData.map((data) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: tableRow(data),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget tableHeader() {
    return Row(
      children: [
        //header cell
        tableHeaderCell('SL', 2),
        tableHeaderCell('Employee Name', 3),
        tableHeaderCell('Work Day', 2),
        tableHeaderCell('Present', 2),
        tableHeaderCell('Absent', 2),
        tableHeaderCell('Leave', 2),
        tableHeaderCell('Hours', 2),
      ],
    );
  }

  Widget tableHeaderCell(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
          ),
        ),
        child: AppTextstyle(
          text: text,
          style: appStyle(
            size: 10.sp,
            color:
                Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
        ),
      ),
    );
  }

  //table row
  Widget tableRow(Map<String, dynamic> data) {
    return Row(
      children: [
        //table cell
        tableCell('${attendanceData.indexOf(data) + 1}', 1),
        tableCell(data['name'], 2),
        tableCell(data['workingDays'].toString(), 1),
        tableCell(data['present'].toString(), 1),
        tableCell(data['absent'].toString(), 1),
        tableCell(data['leave'].toString(), 1),
        tableCell(data['hours'], 1),
      ],
    );
  }

  Widget tableCell(String text, int flex) {
    return Expanded(
      child: AppTextstyle(
        text: text,
        style: appStyle(
          size: 13.sp,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        maxLines: 3,
      ),
    );
  }
}
