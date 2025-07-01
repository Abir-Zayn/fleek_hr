part of 'work_from_home_details_imports.dart';

class WorkFromHomeDetails extends StatelessWidget {
  final WfhModel workFromHome;
  const WorkFromHomeDetails({super.key, required this.workFromHome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: "Work From Home Details",
      ),

      // Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextstyle(
                    text: workFromHome.reason,
                    style: appStyle(
                      size: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppTextstyle(
                    text: 'Submitted By: ${workFromHome.employeeName}',
                    style: appStyle(
                      size: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Status badge
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: getStatusColor(workFromHome.status),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: AppTextstyle(
                      text: workFromHome.status,
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

            // Details section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextstyle(
                    text: 'Request Information',
                    style: appStyle(
                      size: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  detailRow('Request ID', workFromHome.id),
                  detailRow('Employee ID', workFromHome.employeeId),
                  detailRow('Employee Name', workFromHome.employeeName),
                  detailRow('Start Date', formatDate(workFromHome.startDate)),
                  detailRow('End Date', formatDate(workFromHome.endDate)),
                  detailRow('Duration', '${workFromHome.totalDays} day(s)'),
                  detailRow('Status', workFromHome.status),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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

  String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  Color getStatusColor(String status) {
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
