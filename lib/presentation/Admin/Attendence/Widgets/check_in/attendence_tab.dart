import 'package:fleekhr/presentation/Admin/Attendence/Screen/history_screen_imports.dart';
import 'package:fleekhr/presentation/Admin/Attendence/Widgets/check_in/check_in_tab.dart';
import 'package:flutter/material.dart';

/// Top tap for attendence toggle between check in and history
class AttendenceTab extends StatelessWidget {
  final TabController tabController;
  const AttendenceTab({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          //Tab bar
          TabBar(
            controller: tabController,
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.black,
            tabs: const [
              Tab(
                text: 'Check In',
              ),
              Tab(
                text: 'History',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [CheckInTab(), HistoryScreen()],
            ),
          ),
        ],
      ),
    );
  }
}
