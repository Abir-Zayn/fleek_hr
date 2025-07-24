part of 'attendance_checker_imports.dart';

/// Attendance Screen will have following features:
/// 1. Check In place holder
///    - It will have a button to check in/check out.
///    - When check in is pressed, it will show a dialog with the following:
///    - If its not pressed earlier, it will show a snackbar of "Checked In"
///    - If its already pressed, it will show a snackbar of "Checked Out"
///
///
/// 2. History place holder
///     - On history tab, it will show the history of current month where on a table
///     - following data will be shown
///     - a horizontal scrollable table heading with current month name, current year
///     - in the table it will have two columns
///     - on first column , row data are (Working Days, On Time, Late, Left Timely, Left Early, On Leave, Absent)
///     - on second column, row data are (number of days in each category)
///     - Below the table, there will be a text of "Daily Reports"
///     - every day on month with following data [ Row( Column{Days, Date}, Column{IN Time, Out Time},Status{Late,On time}) ]
///

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize tab controller for Check In and History tabs
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        title: 'Attendance',
        backgroundColor: Theme.of(context).primaryColor,
        bottom: TabBar(
          unselectedLabelColor: Colors.white70,
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          labelColor: Colors.white,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          controller: _tabController,
          tabs: [
            Tab(
              text: 'Check In',
            ),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: PageBackground(
        child: TabBarView(
          controller: _tabController,
          children: [
            CheckInTab(),
            HistoryTab(),
          ],
        ),
      ),
    );
  }
}
