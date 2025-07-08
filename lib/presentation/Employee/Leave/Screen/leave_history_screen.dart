part of 'leave_history_screen_imports.dart';

class LeaveHistoryScreen extends StatefulWidget {
  const LeaveHistoryScreen({super.key});

  @override
  State<LeaveHistoryScreen> createState() => _LeaveHistoryScreenState();
}

class _LeaveHistoryScreenState extends State<LeaveHistoryScreen> {
  String selectedFilter = 'All';

  // Replace this with actual employeeId from your auth/user state
  late final String employeeId;

  @override
  void initState() {
    super.initState();
    context.read<LeaveCubit>().getAllLeaveRequestForCurrentUser();
  }

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
          title: "Filter Leave Requests",
          filteringOpt: ["All", "Pending", "Approved", "Rejected"],
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: "Leave History",
        actionButton: const Icon(Icons.filter_list, color: Colors.white),
        onActionButtonPressed: showcasingFilteringOptions,
      ),
      body: SafeArea(
        child: BlocBuilder<LeaveCubit, LeaveState>(
          builder: (context, state) {
            if (state is LeaveLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            } else if (state is LeaveLoaded) {
              final filteredLeaves = state.leaveRequests
                  .where((leave) =>
                      selectedFilter == 'All' ||
                      leave.status.value.toLowerCase() ==
                          selectedFilter.toLowerCase())
                  .toList();

              if (filteredLeaves.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      Icon(Icons.celebration, size: 48, color: Colors.green),
                      SizedBox(height: 16),
                      AppTextstyle(
                        text: 'Congratulations! You have not taken any leave.',
                        style: appStyle(
                          size: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<LeaveCubit>().getAllLeaveRequests(employeeId);
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: filteredLeaves.length,
                  itemBuilder: (context, index) {
                    final leave = filteredLeaves[index];
                    return UnifiedRequestCard.leave(
                      id: leave.id.toString(),
                      employeeName: leave
                          .employeeId, // Replace with actual name if available
                      status: leave.status.value,
                      leaveType: leave.leaveType.value,
                      startDate: leave.startDate,
                      endDate: leave.endDate,
                    );
                  },
                ),
              );
            } else if (state is LeaveError) {
              return Center(
                child: AppTextstyle(
                  text: state.message,
                  style: appStyle(
                      size: 13, color: Colors.red, fontWeight: FontWeight.w500),
                ),
              );
            }
            // Initial or unknown state
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/add-leave');
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Leave'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
