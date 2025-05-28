part of 'annualleave_page_imports.dart';

/// AnnualleavePage displays employee leave information and history
/// Allows users to view available leave balances and request new leave
class AnnualleavePage extends StatelessWidget {
  const AnnualleavePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Function to show leave request form dialog

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
              LeaveSummaryCard(
                year: "2025",
                title:
                    "Leave Summary", // Optional, defaults to "Available Leave"
                leaveIndicators: [
                  LeaveIndicatorData(
                    title: "Total leave",
                    used: "30",
                    color: Colors.blue,
                  ),
                  LeaveIndicatorData(
                    title: "Leave Granted",
                    used: "15",
                    color: Colors.deepOrangeAccent,
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // // Leave balance table
              // LeaveBalanceTable(
              //   leaveBalances: [
              //     LeaveBalanceData(type: "Annual Leave", total: "12 Days"),
              //     LeaveBalanceData(type: "Sick Leave", total: "8 Days"),
              //     LeaveBalanceData(type: "Leave Without Pay", total: "12 Days"),
              //   ],
              //   // Optional customizations:
              //   borderColor: Colors.blueGrey.shade100,
              //   headerBackgroundColor:
              //       Theme.of(context).primaryColor.withOpacity(0.1),
              //   borderRadius: 16,
              //   headerTextStyle: TextStyle(
              //     fontSize: 16.sp,
              //     fontWeight: FontWeight.bold,
              //     color: Theme.of(context).textTheme.titleLarge?.color ??
              //         Colors.black,
              //   ),
              // ),
              SizedBox(height: 40.h),

              //Leave request and history section
              Text(
                "Leave Request",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.titleLarge?.color ??
                      Colors.black,
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Column(
                  children: [
                    // Row(
                    //   children: [
                    //     LeaveActionBtn(
                    //       headingText: "Add Leave",
                    //       icon: Icons.add_circle_outline,
                    //       onPressed: () {
                    //         context.push('/add-leave');
                    //       },
                    //       cardColor: Theme.of(context).scaffoldBackgroundColor,
                    //       headingColor: Theme.of(context).primaryColor,
                    //     ),
                    //     SizedBox(width: 20.w),
                    //     LeaveActionBtn(
                    //       headingText: "Leave History",
                    //       icon: Icons.history,
                    //       onPressed: () {},
                    //       cardColor: Colors.blue,
                    //       headingColor: Colors.white,
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 20.h),
                    // Row(
                    //   children: [
                    //     LeaveActionBtn(
                    //       headingText: "Approved Leave",
                    //       icon: Icons.check_circle_outline,
                    //       onPressed: () {
                    //         context.push('/add-leave');
                    //       },
                    //       cardColor: Theme.of(context).primaryColor,
                    //       headingColor: Colors.white,
                    //     ),
                    //     SizedBox(width: 20.w),
                    //     LeaveActionBtn(
                    //       headingText: "Rejected Leave",
                    //       icon: Icons.history,
                    //       onPressed: () {},
                    //       cardColor: Colors.purple[700],
                    //       headingColor: Colors.white,
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
