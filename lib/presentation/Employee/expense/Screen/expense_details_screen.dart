part of 'expense_details_imports.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  final ExpenseCardData expense;

  const ExpenseDetailsScreen({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: "Expense Details",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
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
                    text: expense.purpose,
                    style: appStyle(
                      size: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  AppTextstyle(
                    text: 'Submitted By: ${expense.employeeName}',
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
              margin: EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor(expense.status),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: AppTextstyle(
                      text: expense.status,
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
                    text: 'Expense Information',
                    style: appStyle(
                      size: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  detailRow('Expense ID', expense.id),
                  detailRow('Employee ID', expense.employeeId),
                  detailRow('Employee Name', expense.employeeName),
                  detailRow('Purpose', expense.purpose),
                  detailRow('Amount', '\$${expense.amount.toStringAsFixed(2)}'),
                  detailRow('Date', formatDate(expense.date)),
                  detailRow('Status', expense.status),
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

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

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
