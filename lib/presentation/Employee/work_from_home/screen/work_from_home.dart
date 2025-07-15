part of 'work_from_home_imports.dart';

class WorkFromHomeScreen extends StatefulWidget {
  const WorkFromHomeScreen({super.key});

  @override
  State<WorkFromHomeScreen> createState() => _WorkFromHomeScreenState();
}

class _WorkFromHomeScreenState extends State<WorkFromHomeScreen> {
  String selectedFilter = 'All';
  late final WorkFromHomeCubit _workFromHomeCubit;
  late final GetUserUseCase _getUserUseCase;

  @override
  void initState() {
    super.initState();
    _workFromHomeCubit = sl<WorkFromHomeCubit>();
    _getUserUseCase = sl<GetUserUseCase>();
    _loadWorkFromHomeRequests();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check if we're coming back from details page
    final currentState = _workFromHomeCubit.state;
    if (currentState is WorkFromHomeDetailSuccess) {
      // If we have details with a list, we should force a refresh of the list view
      // without making a new API call
      _restoreListFromDetailState(currentState.workFromHomeList);
    }
  }

  // Helper method to restore list without making API calls
  void _restoreListFromDetailState(List<WorkFromHomeEntity> list) {
    // Create a special method in cubit to handle this
    _workFromHomeCubit.restoreListState(list);
  }

  void _loadWorkFromHomeRequests() async {
    try {
      // Check if we already have a loading state to prevent duplicate calls
      if (_workFromHomeCubit.state is WorkFromHomeLoading) {
        return; // Skip if already loading
      }

      // Create a timeout to ensure we don't get stuck in loading
      bool isComplete = false;
      Future.delayed(Duration(seconds: 10), () {
        if (!isComplete &&
            mounted &&
            _workFromHomeCubit.state is WorkFromHomeLoading) {
          // If still loading after 10 seconds, force exit loading state
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AppTextstyle(
                text: 'Loading taking longer than expected, please try again',
                style: appStyle(
                  size: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              backgroundColor: Colors.orange,
            ),
          );

          // Restore previous state if available
          final cachedList = _workFromHomeCubit.cachedWorkFromHomeList;
          if (cachedList != null && cachedList.isNotEmpty) {
            _workFromHomeCubit.restoreListState(cachedList);
          } else {
            // If no cached data, show an error instead
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: AppTextstyle(
                  text: 'Could not load data, please try again',
                  style: appStyle(
                    size: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      });

      // Get current user through the UseCase
      final userResult = await _getUserUseCase.call();

      userResult.fold(
        (failure) {
          isComplete = true;
          // Handle failure
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AppTextstyle(
                text: 'Failed to get user: ${failure.message}',
                style: appStyle(
                  size: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              backgroundColor: Colors.red,
            ),
          );
        },
        (user) {
          isComplete = true; // Mark operation as complete
          // User is available, load WFH requests
          if (user is EmployeeEntity) {
            _workFromHomeCubit.getAllWorkFromHomeRequests(user.id);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: AppTextstyle(
                  text: 'User data format error',
                  style: appStyle(
                    size: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppTextstyle(
            text: 'Error loading data: ${e.toString()}',
            style: appStyle(
              size: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
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
        SnackBar(
          content: AppTextstyle(
            text: "Error showing filter options: $e",
            style: appStyle(
              size: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
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
          showcasingFilteringOptions();
        },
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _loadWorkFromHomeRequests();
          },
          child: BlocBuilder<WorkFromHomeCubit, WorkFromHomeState>(
            bloc: _workFromHomeCubit,
            builder: (context, state) {
              // Check if we're loading but have previous data
              if (state is WorkFromHomeLoading) {
                // If we have cached data, show it with a loading indicator overlay
                final cachedList = _workFromHomeCubit.cachedWorkFromHomeList;
                if (cachedList != null && cachedList.isNotEmpty) {
                  // Use cached data but show loading indicator
                  return Stack(
                    children: [
                      // Show the previous list
                      _buildWorkFromHomeList(cachedList),
                      // Show loading indicator overlay
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.1),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                // No cached data, show regular loading
                return Center(child: CircularProgressIndicator());
              } else if (state is WorkFromHomeError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 48, color: Colors.red),
                      SizedBox(height: 16),
                      AppTextstyle(
                        text: 'Error: ${state.message}',
                        style: appStyle(
                          size: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadWorkFromHomeRequests,
                        child: AppTextstyle(
                          text: 'Retry',
                          style: appStyle(
                            size: 14,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is WorkFromHomeListSuccess) {
                final wfhRequests = state.workFromHomeList;
                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildWorkFromHomeList(wfhRequests),
                      ],
                    ),
                  ),
                );
              } else if (state is WorkFromHomeDetailSuccess) {
                // We can also display the list from a DetailSuccess state
                final wfhRequests = state.workFromHomeList;
                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildWorkFromHomeList(wfhRequests),
                      ],
                    ),
                  ),
                );
              }

              // Initial or unknown state
              return Center(
                child: AppTextstyle(
                  text: 'No Work From Home requests found.',
                  style: appStyle(
                    size: 16,
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        heroTag: 'WFH Request',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tooltip: 'Request Work From Home',
        onPressed: () async {
          try {
            // Get current user through the UseCase
            final userResult = await _getUserUseCase.call();

            userResult.fold(
              (failure) {
                // Handle failure
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: AppTextstyle(
                      text: 'Failed to get user: ${failure.message}',
                      style: appStyle(
                        size: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              (user) {
                // User is available, navigate to add WFH screen
                if (user is EmployeeEntity) {
                  if (!mounted) return;

                  context.push('/work-from-home-request-form', extra: {
                    'employeeId': user.id,
                    'employeeName': user.name,
                  }).then((result) {
                    // Check if we received a true value back, indicating we need to refresh
                    if (result == true) {
                      // Only reload if we're not already in a loading state
                      if (_workFromHomeCubit.state is! WorkFromHomeLoading) {
                        _loadWorkFromHomeRequests();
                      }
                    }
                  });
                } else {
                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: AppTextstyle(
                        text: 'User data format error',
                        style: appStyle(
                          size: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            );
          } catch (e) {
            if (!mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: AppTextstyle(
                  text: 'Error: ${e.toString()}',
                  style: appStyle(
                    size: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildWorkFromHomeList(List<WorkFromHomeEntity> allRequests) {
    // Handle the case when the list is initially empty
    if (allRequests.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.home_work_outlined,
                size: 64,
                color: Colors.grey.shade400,
              ),
              SizedBox(height: 16),
              AppTextstyle(
                text: 'No Work From Home requests found.',
                style: appStyle(
                  size: 16,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => _loadWorkFromHomeRequests(),
                icon: Icon(Icons.refresh),
                label: AppTextstyle(
                  text: 'Refresh',
                  style: appStyle(
                    size: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Filter requests based on selected filter
    final filteredRequests = allRequests.where((request) {
      if (selectedFilter == 'All') return true;

      // Convert enum to string for comparison
      final requestStatus = request.status.toString().split('.').last;
      return requestStatus.toLowerCase() == selectedFilter.toLowerCase();
    }).toList();

    if (filteredRequests.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.home_work_outlined,
                size: 64,
                color: Colors.grey.shade400,
              ),
              SizedBox(height: 16),
              AppTextstyle(
                text: selectedFilter == 'All'
                    ? 'No Work From Home requests found.'
                    : 'No $selectedFilter Work From Home requests found.',
                style: appStyle(
                  size: 16,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredRequests.length,
      separatorBuilder: (context, index) => SizedBox(height: 8),
      itemBuilder: (context, index) {
        final request = filteredRequests[index];

        // Convert enum to string for display
        String statusString = request.status.toString().split('.').last;
        // Capitalize first letter
        statusString =
            statusString[0].toUpperCase() + statusString.substring(1);

        return UnifiedRequestCard.workFromHome(
            id: request.id,
            employeeName: request.employeeName,
            status: statusString,
            startDate: request.startDate,
            endDate: request.endDate,
            reason: request.reason,
            onTap: () {
              context.push(
                '/work-from-home-details/${request.id}',
                extra: {
                  'employeeId': request.employeeId,
                  'employeeName': request.employeeName,
                },
              );
            });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
