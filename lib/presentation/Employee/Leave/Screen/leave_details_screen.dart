part of 'leave_details_imports.dart';

class LeaveDetailScreen extends StatelessWidget {
  final LeaveDataCard leave;
  final bool isAdmin;

  const LeaveDetailScreen({
    super.key,
    required this.leave,
    this.isAdmin = false,
  });

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  Color _getStatusColor() {
    switch (leave.status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
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
              // Status indicator
              Container(
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _getStatusColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(
                    color: _getStatusColor(),
                    width: 1,
                  ),
                ),
                child: Text(
                  "Status: ${leave.status}",
                  style: TextStyle(
                    color: _getStatusColor(),
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),

              Divider(),

              // Employee info section
              _buildSection(
                "Employee Information",
                [
                  _buildInfoRow("Name", leave.employeeName),
                  _buildInfoRow("Employee ID", leave.employeeId),
                ],
              ),

              Divider(),

              // Leave details section
              _buildSection(
                "Leave Details",
                [
                  _buildInfoRow("Leave Type", leave.leaveType),
                  _buildInfoRow("Duration",
                      "${leave.totalDays} day${leave.totalDays != 1 ? 's' : ''}"),
                  _buildInfoRow("Category", leave.leaveCategory),
                  _buildInfoRow("Start Date", _formatDate(leave.startDate)),
                  _buildInfoRow("End Date", _formatDate(leave.endDate)),
                ],
              ),

              Divider(),

              // Reason section
              _buildSection(
                "Reason",
                [
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
              isAdmin
                  ? _buildAdminActions(context)
                  : _buildEmployeeActions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        ...children,
        SizedBox(height: 8.h),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminActions(BuildContext context) {
    // Only show approve/reject for pending requests
    if (leave.status.toLowerCase() != 'pending') {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Text(
          "This request has already been ${leave.status.toLowerCase()}",
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade100,
              foregroundColor: Colors.red,
            ),
            onPressed: () {
              _showConfirmationDialog(
                context,
                "Reject Leave Request",
                "Are you sure you want to reject this leave request?",
                false,
              );
            },
            child: Text("Reject"),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade100,
              foregroundColor: Colors.green,
            ),
            onPressed: () {
              _showConfirmationDialog(
                context,
                "Approve Leave Request",
                "Are you sure you want to approve this leave request?",
                true,
              );
            },
            child: Text("Approve"),
          ),
        ),
      ],
    );
  }

  Widget _buildEmployeeActions(BuildContext context) {
    // Only show edit/delete for pending requests
    if (leave.status.toLowerCase() != 'pending') {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Text(
          "This request has already been ${leave.status.toLowerCase()}",
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade100,
              foregroundColor: Colors.red,
            ),
            onPressed: () {
              _showConfirmationDialog(
                context,
                "Delete Leave Request",
                "Are you sure you want to delete this leave request?",
                false,
              );
            },
            child: Text("Delete"),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              foregroundColor: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              // Navigate to edit screen
              context.push('/add-leave', extra: leave);
            },
            child: Text("Edit"),
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
    String title,
    String message,
    bool isApprove,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog

              if (isAdmin) {
                // Admin approval/rejection logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isApprove
                        ? "Leave request approved successfully"
                        : "Leave request rejected"),
                    backgroundColor: isApprove ? Colors.green : Colors.red,
                  ),
                );

                // Navigate back to list using go_router
                context.pop();
              } else {
                // Employee edit/delete logic
                if (isApprove) {
                  // Navigate to edit screen
                  context.push('/add-leave', extra: leave);
                } else {
                  // Delete operation and show message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Leave request deleted successfully"),
                      backgroundColor: Colors.red,
                    ),
                  );

                  // Navigate back to list using go_router
                  context.pop();
                }
              }
            },
            child: Text(
              isAdmin
                  ? (isApprove ? 'Approve' : 'Reject')
                  : (isApprove ? 'Edit' : 'Delete'),
              style: TextStyle(
                color: isApprove ? Colors.green : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
