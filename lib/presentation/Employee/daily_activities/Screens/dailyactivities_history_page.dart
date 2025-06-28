part of 'dailyactivities_history_page_imports.dart';

class DailyactivitiesPage extends StatefulWidget {
  final bool isAdmin;

  const DailyactivitiesPage({super.key, required this.isAdmin});

  @override
  State<DailyactivitiesPage> createState() => _DailyactivitiesPageState();
}

class _DailyactivitiesPageState extends State<DailyactivitiesPage> {
  String selectedFilter = 'All';

  void showcasingFilteringOptions() {
    try {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => FilteringBottomSheet(
          title: "Filter Daily Actitivities Requests",
          filteringOpt: ["All", "Pending", "Completed", "In Progress"],
          selectedFilter: selectedFilter,
          onFilterSelected: (filter) {
            setState(() {
              selectedFilter = filter;
            });
            debugPrint('Selected filter: $selectedFilter');
          },
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
        ),
      );
    } catch (e) {
      debugPrint("Error showing filter options: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error showing filter options: $e")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FleekAppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: "Daily Activities",
          actionButton: const Icon(Icons.filter_list, color: Colors.white),
          onActionButtonPressed: () {
            // Show filter options in a dialog instead of using PopupMenuButton
            showcasingFilteringOptions();
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppTextstyle(
                        text: 'Daily Activities History',
                        style: appStyle(
                          size: 18,
                          color: Theme.of(context).textTheme.bodyLarge?.color ??
                              Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (selectedFilter != 'All')
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: AppTextstyle(
                            text: 'Filter: $selectedFilter',
                            style: appStyle(
                              size: 12,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Add the task list widget here
                  taskList(),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            // Navigate to the add daily activity page
            context.push('/add-daily-activity');
          },
          child: const Icon(Icons.add),
        ));
  }

  Widget taskList() {
    final filteredLeaves = DailyActivitesCardSrc.dailyActivitiesDemoData
        .where((leave) =>
            selectedFilter == 'All' ||
            leave.status.toLowerCase() == selectedFilter.toLowerCase())
        .toList();

    if (filteredLeaves.isEmpty) {
      return Center(
        child: AppTextstyle(
          text: 'No Daily Activities found',
          style: appStyle(
            size: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    //show the list of leaves
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredLeaves.length,
      itemBuilder: (context, index) {
        final tasks = filteredLeaves[index];
        return DailyActivitiesCard(
          taskName: tasks.taskTitle,
          assignedTo: tasks.employeeName,
          status: tasks.status,
          startedAt: tasks.startTime.toString(),
          completionDate: tasks.endTime.toString(),
          onTap: () {
            context.push('/daily-activities-details/${tasks.id}');
          },
        );
      },
    );
  }
}
