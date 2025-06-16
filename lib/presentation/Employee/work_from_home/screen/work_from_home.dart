part of 'work_from_home_imports.dart';

class WorkFromHomeScreen extends StatefulWidget {
  const WorkFromHomeScreen({super.key});

  @override
  State<WorkFromHomeScreen> createState() => _WorkFromHomeScreenState();
}

class _WorkFromHomeScreenState extends State<WorkFromHomeScreen> {
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
        title: "Work From Home",
        actionButton: const Icon(Icons.filter_list, color: Colors.white),
        onActionButtonPressed: () {
          // Show filter options in a dialog instead of using PopupMenuButton
          showcasingFilteringOptions();
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [workFromHomeList()],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        heroTag: 'WFH Request',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        tooltip: 'Request Work From Home',
        onPressed: () {
          // Navigate to the Work From Home Request Form
          context.push('/work-from-home-request-form');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget workFromHomeList() {
    final wfhRequests = WorkFromHomeMockData.mockWfhRequests.where((request) {
      if (selectedFilter == 'All') return true;
      return request.status.toLowerCase() == selectedFilter.toLowerCase();
    }).toList();

    if (wfhRequests.isEmpty) {
      return Center(
        child: AppTextstyle(
          text: 'No Work From Home requests found.',
          style: appStyle(
            size: 16.sp,
            color:
                Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: wfhRequests.length,
      separatorBuilder: (context, index) => SizedBox(height: 8.h),
      itemBuilder: (context, index) {
        final request = wfhRequests[index];

        return UnifiedRequestCard.workFromHome(
            id: request.id,
            employeeName: request.employeeName,
            status: request.status,
            startDate: request.startDate,
            endDate: request.endDate,
            reason: request.reason);
      },
    );
  }
}
