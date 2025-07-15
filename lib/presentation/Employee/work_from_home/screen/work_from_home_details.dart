part of 'work_from_home_details_imports.dart';

class WorkFromHomeDetails extends StatefulWidget {
  final String id;

  const WorkFromHomeDetails({super.key, required this.id});

  @override
  State<WorkFromHomeDetails> createState() => _WorkFromHomeDetailsState();
}

class _WorkFromHomeDetailsState extends State<WorkFromHomeDetails> {
  late final WorkFromHomeCubit _workFromHomeCubit;

  @override
  void initState() {
    super.initState();
    _workFromHomeCubit = sl<WorkFromHomeCubit>();
    _loadWorkFromHomeDetails();
  }

  void _loadWorkFromHomeDetails() {
    _workFromHomeCubit.getWorkFromHomeRequestById(widget.id);
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // When popping back, ensure we restore the list state
        final currentState = _workFromHomeCubit.state;
        if (currentState is WorkFromHomeDetailSuccess) {
          _workFromHomeCubit.restoreListState(currentState.workFromHomeList);
        }
        return true;
      },
      child: Scaffold(
        appBar: FleekAppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: "Work From Home Details",
          onBackButtonPressed: () {
            // Handle back button press
            final currentState = _workFromHomeCubit.state;
            if (currentState is WorkFromHomeDetailSuccess) {
              _workFromHomeCubit
                  .restoreListState(currentState.workFromHomeList);
            }
            context.pop();
          },
        ),
        body: BlocBuilder<WorkFromHomeCubit, WorkFromHomeState>(
          bloc: _workFromHomeCubit,
          builder: (context, state) {
            if (state is WorkFromHomeLoading) {
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
                      onPressed: _loadWorkFromHomeDetails,
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
            } else if (state is WorkFromHomeSuccess ||
                state is WorkFromHomeDetailSuccess) {
              // Handle both types of success states
              final WorkFromHomeEntity wfh = state is WorkFromHomeSuccess
                  ? state.workFromHome
                  : (state as WorkFromHomeDetailSuccess).workFromHome;
              return _buildDetailsContent(wfh);
            }

            return Center(
              child: AppTextstyle(
                text: 'Loading details...',
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
    );
  }

  Widget _buildDetailsContent(WorkFromHomeEntity wfh) {
    String statusString = wfh.status.toString().split('.').last;
    statusString = statusString[0].toUpperCase() + statusString.substring(1);

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusCard(statusString),
          SizedBox(height: 24),
          _buildInfoCard(wfh),
          SizedBox(height: 24),
          _buildReasonCard(wfh.reason),
          SizedBox(height: 24),
          _buildActionsCard(wfh),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String status) {
    Color statusColor;
    IconData statusIcon;

    switch (status.toLowerCase()) {
      case 'approved':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'rejected':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      case 'pending':
      default:
        statusColor = Colors.orange;
        statusIcon = Icons.hourglass_empty;
        break;
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Icon(
            statusIcon,
            color: statusColor,
            size: 32,
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextstyle(
                text: 'Status',
                style: appStyle(
                  size: 14,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              AppTextstyle(
                text: status,
                style: appStyle(
                  size: 18,
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(WorkFromHomeEntity wfh) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextstyle(
              text: 'Work From Home Details',
              style: appStyle(
                size: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            _buildInfoRow('Employee', wfh.employeeName),
            Divider(),
            _buildInfoRow('Start Date', _formatDate(wfh.startDate)),
            Divider(),
            _buildInfoRow('End Date', _formatDate(wfh.endDate)),
            Divider(),
            _buildInfoRow('Duration',
                '${wfh.endDate.difference(wfh.startDate).inDays + 1} day(s)'),
            Divider(),
            _buildInfoRow('Requested On', _formatDate(wfh.createdAt)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextstyle(
            text: label,
            style: appStyle(
              size: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          AppTextstyle(
            text: value,
            style: appStyle(
              size: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReasonCard(String reason) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextstyle(
              text: 'Reason',
              style: appStyle(
                size: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: AppTextstyle(
                text: reason,
                style: appStyle(
                  size: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: null,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsCard(WorkFromHomeEntity wfh) {
    // Show different actions based on status
    if (wfh.status == WorkFromHomeStatus.pending) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextstyle(
                text: 'Actions',
                style: appStyle(
                  size: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _showDeleteConfirmation(wfh.id),
                      icon: Icon(Icons.delete, color: Colors.white),
                      label: AppTextstyle(
                        text: 'Cancel Request',
                        style: appStyle(
                          size: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox.shrink(); // No actions for approved/rejected requests
  }

  void _showDeleteConfirmation(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: AppTextstyle(
          text: 'Cancel Request',
          style: appStyle(
            size: 18,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: AppTextstyle(
          text: 'Are you sure you want to cancel this work from home request?',
          style: appStyle(
            size: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: AppTextstyle(
              text: 'No',
              style: appStyle(
                size: 14,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.pop(); // Close dialog
              _deleteWorkFromHomeRequest(id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: AppTextstyle(
              text: 'Yes, Cancel',
              style: appStyle(
                size: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteWorkFromHomeRequest(String id) async {
    await _workFromHomeCubit.deleteWorkFromHomeRequest(id);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppTextstyle(
          text: 'Work from home request cancelled successfully',
          style: appStyle(
            size: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.green,
      ),
    );

    // Use go_router to navigate back
    context.pop();
  }
}
