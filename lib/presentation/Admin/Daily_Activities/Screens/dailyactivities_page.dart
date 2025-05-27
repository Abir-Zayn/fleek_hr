part of 'dailyactivities_page_imports.dart';

class DailyactivitiesPage extends StatefulWidget {
  final bool isAdmin;

  const DailyactivitiesPage({super.key, required this.isAdmin});

  @override
  State<DailyactivitiesPage> createState() => _DailyactivitiesPageState();
}

class _DailyactivitiesPageState extends State<DailyactivitiesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Map<String, dynamic>> activities;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    activities = DailyActivitiesStorage.activities ?? [];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Activities',
            style: appStyle(
                size: 20.sp, color: Colors.black, fontWeight: FontWeight.w500)),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Accepted'),
            Tab(text: 'All'),
          ],
          labelStyle: appStyle(
              size: 14.sp, color: Colors.black, fontWeight: FontWeight.w500),
          unselectedLabelStyle: appStyle(
              size: 14.sp, color: Colors.grey, fontWeight: FontWeight.w400),
          indicatorColor: Theme.of(context).primaryColor,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActivitiesList('pending'),
          _buildActivitiesList('accepted'),
          _buildActivitiesList('all'),
        ],
      ),
    );
  }

  Widget _buildActivitiesList(String filter) {
    List<Map<String, dynamic>> filteredActivities =
        activities.where((activity) {
      if (filter == 'all') return true;
      if (filter == 'pending')
        return activity['status'] == null || activity['status'] == 'pending';
      return activity['status'] == filter;
    }).toList();

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: filteredActivities.length,
      itemBuilder: (context, index) {
        final activity = filteredActivities[index];
        return DailyActivitiesCard(
          taskName: activity['taskName'],
          assignedTo: activity['assignedTo'],
          completionDate: activity['completionDate'],
          progress: activity['progress'],
          status: activity['status'],
          isAdmin: widget.isAdmin,
          onAccept: () {
            _updateActivityStatus(index, 'accepted', filter);
          },
          onReject: () {
            _updateActivityStatus(index, 'rejected', filter);
          },
        );
      },
    );
  }

  void _updateActivityStatus(int index, String status, String currentFilter) {
    setState(() {
      // Get the specific activity from the filtered list
      var filteredActivities = _getFilteredActivities(currentFilter);

      if (index < filteredActivities.length) {
        // Find the corresponding activity in the full list
        int originalIndex = activities.indexWhere(
            (a) => a['taskName'] == filteredActivities[index]['taskName']);

        if (originalIndex != -1) {
          activities[originalIndex]['status'] = status;
        }
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Activity $status successfully!'),
        backgroundColor: status == 'accepted' ? Colors.green : Colors.orange,
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredActivities(String filter) {
    return activities.where((activity) {
      if (filter == 'all') return true;
      if (filter == 'pending')
        return activity['status'] == null || activity['status'] == 'pending';
      return activity['status'] == filter;
    }).toList();
  }
}
