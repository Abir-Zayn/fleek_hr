import 'package:fleekhr/presentation/Employee/Request/widget/requestcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class Requestpage extends StatelessWidget {
  const Requestpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // Header section - Use safe text styles
              Text(
                "What would you like to request?",
                style: TextStyle(
                  fontSize: 20.clamp(16.0, 24.0).toDouble(), // ✅ Safe font size
                  color: Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                "Select a category to submit your request",
                style: TextStyle(
                  fontSize: 14.clamp(12.0, 16.0).toDouble(), // ✅ Safe font size
                  color: Colors.grey.shade600,
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
        'description': 'Request to work remotely',
        'route': '/workfromhome'
      },
      {
        'icon': Icons.event_busy,
        'text': "Leave Request",
        'color': Colors.pink,
        'description': 'Apply for days off',
        'route': '/leave-history'
      },
      {
        'icon': Icons.receipt_long,
        'text': "Expense Claim",
        'color': Colors.teal,
        'description': 'Submit expense reports',
        'route': '/expense'
      },
      {
        'icon': Icons.assignment,
        'text': "Task Request",
        'color': Colors.orange,
        'description': 'Request new assignments',
        'route': '/dailyactivities'
      },
      {
        'icon': Icons.headset_mic,
        'text': 'IT Support',
        'color': Colors.purple,
        'description': 'Get help with issues',
        'route': null
      },
      {
        'icon': Icons.access_time,
        'text': "Attendance",
        'color': Colors.green,
        'description': 'View or report attendance',
        'route': '/attendance'
      },
      {
        'icon': Icons.account_balance_wallet,
        'text': "Salary Request",
        'color': Colors.amber,
        'description': 'Salary and payment requests',
        'route': '/salary-overview'
      },
      //Manage Employee
      {
        'icon': Icons.group,
        'text': "Manage Employees",
        'color': Colors.cyan,
        'description': 'Manage team members',
        'route': '/manage-employees'
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
          onTap: () => _handleNavigation(context, reqList[index]),
        );
      },
    );
  }

  // ✅ Centralized navigation handling
  void _handleNavigation(BuildContext context, Map<String, dynamic> item) {
    final route = item['route'] as String?;

    if (route != null) {
      try {
        context.push(route);
      } catch (e) {
        _showComingSoon(context, item['text']);
      }
    } else {
      _showComingSoon(context, item['text']);
    }
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature coming soon'),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
