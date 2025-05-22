import 'package:fleekhr/common/widgets/app_bar.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendenceScreen extends StatefulWidget {
  const AttendenceScreen({super.key});

  @override
  State<AttendenceScreen> createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isCheckedIn = false;
  TimeOfDay? checkInTime;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: FleekAppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: 'Attendance',
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              //Tab bar
              TabBar(
                controller: _tabController,
                indicatorColor: Theme.of(context).primaryColor,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'Check In',
                  ),
                  Tab(
                    text: 'History',
                  ),
                ],
              ),

              // Tab bar view
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildCheckInTab(),
                    Center(
                      child: AppTextstyle(
                        text: "History Tab",
                        style: appStyle(
                            size: 22,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color ??
                                    Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckInTab() {
    //Todo
    // the page starts with a Good morning/Afternoon/evening message.
    // based on the current time
    //
    // Also displaying the current time
    // current date, and day of the week
    // Implement the circular button Check In tab UI
    // successfully clicked on the button will throw a snackbar
    // with the message "Check In Successfully"
    //
    // below the button, show the Check in time, Check out time, and total hours worked
    //

    // variables specific to the build method for formatting
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _greetingSection(),
          const SizedBox(height: 24),
          _buildCheckInButton(),
          const SizedBox(height: 24),
          _buildCheckInInfoCard(),
        ],
      ),
    );
  }

  Widget _greetingSection() {
    final now = DateTime.now();
    final hour = now.hour;
    String greeting;

    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

    final formattedTime = DateFormat('hh:mm a').format(now);
    final formattedDate = DateFormat('EEE, MMM d, y').format(now);

    return Column(
      children: [
        AppTextstyle(
          text: "$greeting! ",
          style: appStyle(
              size: 22,
              color:
                  Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        AppTextstyle(
          text: formattedTime,
          style: appStyle(
              size: 18,
              color:
                  Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        Text(value, style: TextStyle(color: Colors.black87)),
      ],
    );
  }

  Widget _buildCheckInInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInfoRow("Check In Time",
                checkInTime != null ? checkInTime!.format(context) : "--"),
            const SizedBox(height: 8),
            buildInfoRow("Check Out Time", "--"), // to be implemented later
            const SizedBox(height: 8),
            buildInfoRow(
                "Total Hours Worked", "--"), // can be calculated after checkout
          ],
        ),
      ),
    );
  }

  Widget _buildCheckInButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(40),
          backgroundColor: isCheckedIn ? Colors.grey : Colors.green,
        ),
        onPressed: isCheckedIn
            ? null
            : () {
                setState(() {
                  isCheckedIn = true;
                  checkInTime = TimeOfDay.now();
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Check In Successfully")),
                );
              },
        child: const Icon(Icons.login, size: 40, color: Colors.white),
      ),
    );
  }
}
