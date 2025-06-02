import 'package:fleekhr/common/widgets/app_bar.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/presentation/Employee/Request/widget/requestcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class Requestpage extends StatelessWidget {
  const Requestpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: "Requests",
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // Header section
              AppTextstyle(
                text: "What would you like to request?",
                style: appStyle(
                  size: 20.sp,
                  color: Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8.h),

              AppTextstyle(
                text: "Select a category to submit your request",
                style: appStyle(
                  color: Colors.grey.shade600,
                  size: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 24.h),

              // Request cards grid
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      requestPageDashboard(context),

                      SizedBox(height: 32.h),

                      // Recent activity section
                      AppTextstyle(
                        text: "Recent Activity",
                        style: appStyle(
                          size: 18.sp,
                          color: Theme.of(context).textTheme.bodyLarge?.color ??
                              Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget requestPageDashboard(BuildContext context) {
    final List<Map<String, dynamic>> reqList = [
      {
        'icon': Icons.laptop,
        'text': "Work From Home",
        'color': Colors.blue,
        'description': 'Request to work remotely'
      },
      {
        'icon': Icons.event_busy,
        'text': "Leave Request",
        'color': Colors.pink,
        'description': 'Apply for days off'
      },
      {
        'icon': Icons.receipt_long,
        'text': "Expense Claim",
        'color': Colors.teal,
        'description': 'Submit expense reports'
      },
      {
        'icon': Icons.assignment,
        'text': "Task Request",
        'color': Colors.orange,
        'description': 'Request new assignments'
      },
      {
        'icon': Icons.headset_mic,
        'text': 'IT Support',
        'color': Colors.purple,
        'description': 'Get help with issues'
      },
      {
        'icon': Icons.access_time,
        'text': "Attendance",
        'color': Colors.green,
        'description': 'View or report attendance'
      },
      {
        'icon': Icons.account_balance_wallet,
        'text': "Payroll",
        'color': Colors.amber,
        'description': 'Salary and payment requests'
      }
    ];

    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 1.1,
        ),
        itemCount: reqList.length,
        itemBuilder: (context, index) {
          return Requestcard(
            icon: reqList[index]['icon'],
            text: reqList[index]['text'],
            description: reqList[index]['description'],
            iconColor: reqList[index]['color'],
            onTap: () {
              // Handle navigation based on card type
              if (reqList[index]['text'] == "Work From Home") {
                context.push('/workfromhome');
              } else if (reqList[index]['text'] == 'Leave Request') {
                context.push('/leave-history');
              } else if (reqList[index]['text'] == 'Expense Claim') {
                context.push('/expense');
              } else {
                // Placeholder for other routes
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${reqList[index]['text']} coming soon')));
              }
            },
          );
        });
  }
}
