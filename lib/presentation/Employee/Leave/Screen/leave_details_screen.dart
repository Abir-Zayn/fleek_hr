part of 'leave_details_imports.dart';

class LeaveDetailScreen extends StatelessWidget {
  final LeaveDataCard leave;
  final bool isAdmin;

  const LeaveDetailScreen({
    super.key,
    required this.leave,
    this.isAdmin = false,
  });

  /// Formats a DateTime object into a readable string format (MMM dd, yyyy)
  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: "Leave Details",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status indicator widget
              LeaveStatusIndicator(status: leave.status),

              const Divider(),

              // Employee information section
              LeaveDetailsInfo(
                title: "Employee Information",
                children: [
                  LeaveDetailsInfoRow(label: "Name", value: leave.employeeName),
                  LeaveDetailsInfoRow(
                      label: "Employee ID", value: leave.employeeId),
                ],
              ),

              const Divider(),

              // Leave details section
              LeaveDetailsInfo(
                title: "Leave Details",
                children: [
                  LeaveDetailsInfoRow(
                      label: "Leave Type", value: leave.leaveType),
                  LeaveDetailsInfoRow(
                    label: "Duration",
                    value:
                        "${leave.totalDays} day${leave.totalDays != 1 ? 's' : ''}",
                  ),
                  LeaveDetailsInfoRow(
                      label: "Category", value: leave.leaveCategory),
                  LeaveDetailsInfoRow(
                      label: "Start Date", value: _formatDate(leave.startDate)),
                  LeaveDetailsInfoRow(
                      label: "End Date", value: _formatDate(leave.endDate)),
                ],
              ),

              const Divider(),

              // Reason section
              LeaveDetailsInfo(
                title: "Reason",
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      leave.reason.isEmpty
                          ? "No reason provided"
                          : leave.reason,
                      style: TextStyle(
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Action buttons based on role
              ActionButtons(
                leave: leave,
                isAdmin: isAdmin,
                onEdit: () => context.push('/add-leave', extra: leave),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
