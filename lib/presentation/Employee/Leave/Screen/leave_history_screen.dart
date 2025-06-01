part of 'leave_history_screen_imports.dart';

class LeaveHistoryScreen extends StatefulWidget {
  const LeaveHistoryScreen({super.key});

  @override
  State<LeaveHistoryScreen> createState() => _LeaveHistoryScreenState();
}

class _LeaveHistoryScreenState extends State<LeaveHistoryScreen> {
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: "Leave History",
        actionButton: const Icon(Icons.filter_list, color: Colors.white),
        onActionButtonPressed: () {
          // Show filter options in a dialog instead of using PopupMenuButton
          _showFilterDialog(context);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextstyle(
                      text: 'Leave History',
                      style: appStyle(
                        size: 18.sp,
                        color: Theme.of(context).textTheme.bodyLarge?.color ??
                            Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (selectedFilter != 'All')
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: AppTextstyle(
                          text: 'Filter: $selectedFilter',
                          style: appStyle(
                            size: 12.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 16.h),
                _buildLeavesList(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        heroTag: 'Add Leave',
        onPressed: () {
          context.push('/add-leave');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLeavesList() {
    final filteredLeaves = LeaveDataCardSrc.leaveDemoData
        .where((leave) =>
            selectedFilter == 'All' ||
            leave.status.toLowerCase() == selectedFilter.toLowerCase())
        .toList();

    if (filteredLeaves.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40.h),
            Icon(
              Icons.event_busy,
              size: 48.sp,
              color: Colors.grey,
            ),
            SizedBox(height: 16.h),
            AppTextstyle(
              text: 'No leave requests found',
              style: appStyle(
                size: 16.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredLeaves.length,
      itemBuilder: (context, index) {
        final leave = filteredLeaves[index];
        return LeaveRequestCard(
          leave: leave,
          isAdmin: true,
          onStatusChange: (isApproved) {
            debugPrint(
                'Leave ${leave.id} status changed to ${isApproved ? 'Approved' : 'Rejected'}');
          },
        );
      },
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter Leaves'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterOption('All'),
            _buildFilterOption('Pending'),
            _buildFilterOption('Approved'),
            _buildFilterOption('Rejected'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption(String filter) {
    return ListTile(
      title: Text(filter),
      leading: Radio<String>(
        value: filter,
        groupValue: selectedFilter,
        onChanged: (value) {
          setState(() {
            selectedFilter = value!;
          });
          Navigator.pop(context);
          debugPrint('Selected filter: $selectedFilter');
        },
      ),
      onTap: () {
        setState(() {
          selectedFilter = filter;
        });
        Navigator.pop(context);
        debugPrint('Selected filter: $selectedFilter');
      },
    );
  }
}
