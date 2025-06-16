part of 'leave_history_screen_imports.dart';

class LeaveHistoryScreen extends StatefulWidget {
  const LeaveHistoryScreen({super.key});

  @override
  State<LeaveHistoryScreen> createState() => _LeaveHistoryScreenState();
}

class _LeaveHistoryScreenState extends State<LeaveHistoryScreen> {
  String selectedFilter = 'All';

  void showcasingFilteringOptions() {
    try {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        builder: (context) => FilteringBottomSheet(
          title: "Filter WFH Requests",
          filteringOpt: ["All", "Pending", "Approved", "Rejected"],
          selectedFilter: selectedFilter,
          onFilterSelected: (filter) {
            setState(() {
              selectedFilter = filter;
            });
            debugPrint('Selected filter: $selectedFilter');
          },
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 20.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: "Leave History",
        actionButton: const Icon(Icons.filter_list, color: Colors.white),
        onActionButtonPressed: () {
          // Show filter options in a dialog instead of using PopupMenuButton
          showcasingFilteringOptions();
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
                leaveList(),
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

  Widget leaveList() {
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

    //show the list of leaves
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredLeaves.length,
      itemBuilder: (context, index) {
        final leave = filteredLeaves[index];
        return UnifiedRequestCard.leave(
            id: leave.id,
            employeeName: leave.employeeName,
            status: leave.status,
            leaveType: leave.leaveType,
            startDate: leave.startDate,
            endDate: leave.endDate);
      },
    );
  }
}
