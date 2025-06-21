part of 'salary_details_imports.dart';

class SalaryDetailsPage extends StatelessWidget {
  const SalaryDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: "Salary Statement",
        actionButton: IconButton(
          icon: const Icon(
            Icons.download,
            color: Colors.white,
          ),
          onPressed: () {
            // Implement download functionality here
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Company Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              // decoration: BoxDecoration(
              //   color: Theme.of(context).cardColor,
              //   border: Border.all(
              //     color: Theme.of(context).dividerColor,
              //   ),
              //   borderRadius: BorderRadius.circular(8.0),
              // ),
              child: Column(
                children: [
                  AppTextstyle(
                    text: "SALARY STATEMENT",
                    style: appStyle(
                      size: 20,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppTextstyle(
                    text: "For the month of June 2025",
                    style: appStyle(
                      size: 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Salary Breakdown
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  emplopyeeDetailed("Employee Name", "Md. Yunus"),
                  emplopyeeDetailed("Employee ID", "EMP-001"),
                  emplopyeeDetailed("Department", "Engineering"),
                  SizedBox(height: 16),
                  AppTextstyle(
                    text: "Earnings",
                    style: appStyle(
                      size: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  salaryRow("Basic Salary", "2,000.00"),
                  salaryRow("House Rent Allowance", "500.00"),
                  salaryRow("Medical Allowance", "200.00"),
                  salaryRow("Transport Allowance", "100.00"),
                  const Divider(height: 24),
                  AppTextstyle(
                    text: "Deductions",
                    style: appStyle(
                      size: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  salaryRow("Tax", "200.00"),
                  salaryRow("Leave Deductions (2 Days)", "200.00"),
                  salaryRow("Loan Deduction", "100.00"),
                  const Divider(height: 24),
                  totalAmountRow("Gross Earnings", "2,800.00"),
                  totalAmountRow("Total Deductions", "500.00"),
                  const Divider(height: 24),
                  netPayRow("Net Pay", "2,300.00"),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Footer Note
            AppTextstyle(
              text:
                  "This has developed by Fleek Team. For any queries, contact us",
              style: appStyle(
                size: 13,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emplopyeeDetailed(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: AppTextstyle(
              text: label,
              style: appStyle(
                fontWeight: FontWeight.w500,
                size: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: AppTextstyle(
              text: value,
              style: appStyle(
                size: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget salaryRow(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextstyle(
            text: label,
            style: appStyle(
                size: 14,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500),
          ),
          AppTextstyle(
            text: amount,
            style: appStyle(
                size: 14, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget totalAmountRow(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextstyle(
            text: label,
            style: appStyle(
              size: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          AppTextstyle(
            text: amount,
            style: appStyle(
              size: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget netPayRow(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextstyle(
            text: label,
            style: appStyle(
              size: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          AppTextstyle(
            text: amount,
            style: appStyle(
              size: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
