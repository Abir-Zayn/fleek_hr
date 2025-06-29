part of 'leave_details_imports.dart';
class LeaveDetailScreen extends StatelessWidget {
  final LeaveDataCard leave;
  final bool isAdmin;

  const LeaveDetailScreen({
    super.key,
    required this.leave,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: "Leave Details",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card with leave type and employee name
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextstyle(
                    text: leave.leaveType,
                    style: appStyle(
                      size: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  AppTextstyle(
                    text: 'Submitted By: ${leave.employeeName}',
                    style: appStyle(
                      size: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Status badge with colored indicator
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor(leave.status),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: AppTextstyle(
                      text: leave.status,
                      style: appStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Main details card containing all leave information
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextstyle(
                    text: 'Leave Information',
                    style: appStyle(
                      size: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  detailRow('Leave ID', leave.id),
                  detailRow('Employee ID', leave.employeeId),
                  detailRow('Employee Name', leave.employeeName),
                  detailRow('Leave Type', leave.leaveType),
                  detailRow('Category', leave.leaveCategory),
                  detailRow('Duration',
                      '${leave.totalDays} day${leave.totalDays != 1 ? 's' : ''}'),
                  detailRow('Start Date', formatDate(leave.startDate)),
                  detailRow('End Date', formatDate(leave.endDate)),
                  detailRow('Status', leave.status),
                  detailRow(
                      'Reason',
                      leave.reason.isEmpty
                          ? 'No reason provided'
                          : leave.reason),
                ],
              ),
            ),

            // Action buttons for edit/delete or approve/reject based on user role
            if (isAdmin || leave.status.toLowerCase() == 'pending')
              Container(
                margin: EdgeInsets.only(top: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (!isAdmin) ...[
                      // Edit button for regular users
                      // Delete button with confirmation dialog
                      // Reject button for admin users
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            context.push('/add-leave', extra: leave);
                          },
                          child: Text("Edit"),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: Colors.red.shade600,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            // Show confirmation dialog before deletion
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Delete Leave Request"),
                                content: Text(
                                    "Are you sure you want to delete this leave request?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      context.pop();
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.red,
                                    ),
                                    child: Text("Delete"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text("Delete"),
                        ),
                      ),
                    ] else ...[
                      // Approve button for admin users
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Leave request approved")),
                            );
                            context.pop();
                          },
                          child: Text("Approve"),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: Colors.red.shade600,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Leave request rejected")),
                            );
                            context.pop();
                          },
                          child: Text("Reject"),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Creates a formatted detail row with label and value
  Widget detailRow(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: AppTextstyle(
              text: '$label:',
              style: appStyle(
                fontWeight: FontWeight.w600,
                size: 14,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: AppTextstyle(
              text: value,
              style: appStyle(
                size: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Formats DateTime to dd/mm/yyyy format
  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  /// Returns appropriate color based on leave status
  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
