part of 'annualleave_page_imports.dart';

/// AnnualleavePage displays employee leave information and history
/// Allows users to view available leave balances and request new leave
class AnnualleavePage extends StatelessWidget {
  const AnnualleavePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Function to show leave request form dialog
    void showFormDialog() {
      final activityDialog = LeaveFormDialog(
        context: context,
        onSubmitSuccess: () {
          // Callback for successful form submission
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Leave request submitted successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        },
      );
      activityDialog.show();
    }

    return Scaffold(
      // App Bar with rounded bottom corners
      appBar: AppBar(
        toolbarHeight: 60.h,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Leave Request",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),

      // Main body content
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary card showing leave balance overview
              _buildLeaveSummaryCard(context),

              SizedBox(height: 24.h),

              // Leave balance table
              _buildLeaveBalanceTable(context),

              SizedBox(height: 32.h),

              // Leave history section title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Leave History",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    // Filter option
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.filter_list, size: 18.sp),
                      label: Text(
                        "Filter",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // List of leave history
              _buildLeaveHistoryList(context),
            ],
          ),
        ),
      ),

      // Floating action button to request new leave
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showFormDialog,
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          "Request Leave",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// Builds a card showing summary of available leave
  Widget _buildLeaveSummaryCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextstyle(
                  text: "Available Leave",
                  style: appStyle(
                    size: 18.sp,
                    color: Theme.of(context).textTheme.titleLarge?.color ??
                        Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppTextstyle(
                  text: "2025",
                  style: appStyle(
                    size: 14.sp,
                    color: Theme.of(context).textTheme.bodyMedium?.color ??
                        Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Leave balance indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LeaveIndicatorWidget(
                  title: "Annual leave",
                  total: "12",
                  used: "2",
                  color: Colors.blue,
                ),
                LeaveIndicatorWidget(
                  title: "Sick leave",
                  total: "12",
                  used: "5",
                  color: Colors.deepOrangeAccent,
                ),
                LeaveIndicatorWidget(
                  title: "Leave without pay",
                  total: "12",
                  used: "9",
                  color: Colors.deepPurple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a table showing detailed leave balance
  Widget _buildLeaveBalanceTable(BuildContext context) {
    // Table styling
    final BorderSide borderSide = BorderSide(
      color: Colors.grey.shade300,
      width: 1,
    );

    final BoxDecoration headerDecoration = BoxDecoration(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      border: Border(
        bottom: borderSide,
      ),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1.5),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            // Table header
            TableRow(
              decoration: headerDecoration,
              children: [
                _buildTableCell(context, "Leave Type", isHeader: true),
                _buildTableCell(context, "Used", isHeader: true),
                _buildTableCell(context, "Available", isHeader: true),
              ],
            ),

            // Data rows
            _buildTableRow(context, "Annual Leave", "0", "12 Days"),
            _buildTableRow(context, "Sick Leave", "2", "8 Days"),

            _buildTableRow(context, "Leave Without Pay", "0", "12 Days"),
          ],
        ),
      ),
    );
  }

  /// Helper method to build table cells
  Widget _buildTableCell(BuildContext context, String text,
      {bool isHeader = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      child: Center(
        child: AppTextstyle(
          text: text,
          textAlign: TextAlign.center,
          style: appStyle(
            size: isHeader ? 15.sp : 14.sp,
            fontWeight: isHeader ? FontWeight.w600 : FontWeight.w400,
            color:
                Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
          ),
        ),
      ),
    );
  }

  /// Helper method to build table rows
  TableRow _buildTableRow(
      BuildContext context, String type, String used, String total) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      children: [
        _buildTableCell(context, type),
        _buildTableCell(context, used),
        _buildTableCell(context, total),
      ],
    );
  }

  /// Builds the list of leave history items
  Widget _buildLeaveHistoryList(BuildContext context) {
    return Column(
      children: [
        StatusCard(
          title: "Maternity Leave",
          subtitle: "5 days",
          date: "12/10/2025",
          status: StatusType.pending,
        ),
        SizedBox(height: 12.h),
        StatusCard(
          title: "Annual Leave",
          subtitle: "5 days",
          date: "12/10/2025",
          status: StatusType.accepted,
        ),
        SizedBox(height: 12.h),
        StatusCard(
          title: "Annual Leave",
          subtitle: "5 days",
          date: "12/10/2025",
          status: StatusType.rejected,
        ),
        SizedBox(height: 12.h),
        StatusCard(
          title: "Sick Leave",
          subtitle: "2 days",
          date: "05/09/2025",
          status: StatusType.accepted,
        ),
      ],
    );
  }
}
