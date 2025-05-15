import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/presentation/Profile/Widget/attendence_bar_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    final monthlyAttendance = [
      25.0,
      28.0,
      20.0,
      15.0,
      22.0,
      27.0,
      30.0,
      18.0,
      26.0,
      29.0,
      24.0,
      21.0
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header Section
              _buildProfileHeader(context),

              // User Info Section
              _buildUserInfoSection(context),

              // Attendance Section
              _buildAttendanceSection(context, monthlyAttendance),

              // Actions Section
              _buildActionsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  // Profile Header with Image and Name
  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
      child: Column(
        children: [
          _profilePicture(
              'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
          SizedBox(height: 15.h),
          Text(
            "Muhammad Yunus",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          SizedBox(height: 5.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              "Employee",
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  // User Information Cards
  Widget _buildUserInfoSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.w, bottom: 12.h),
            child: Text(
              "Contact Information",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.titleLarge?.color ??
                    Colors.black,
              ),
            ),
          ),

          // Email Card
          _buildInfoCard(context,
              icon: CupertinoIcons.mail,
              title: "Email",
              value: "abirzayn561@gmail.com"),

          SizedBox(height: 12.h),

          // Phone Card
          _buildInfoCard(context,
              icon: CupertinoIcons.phone,
              title: "Phone",
              value: "xxx-xxxx-xxxx"),

          SizedBox(height: 12.h),

          // Department Card
          _buildInfoCard(context,
              icon: CupertinoIcons.building_2_fill,
              title: "Department",
              value: "Engineering"),
        ],
      ),
    );
  }

  // Info Card Widget
  Widget _buildInfoCard(BuildContext context,
      {required IconData icon, required String title, required String value}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 22.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Attendance Chart Section
  Widget _buildAttendanceSection(
      BuildContext context, List<double> monthlyAttendance) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.w, bottom: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextstyle(
                  text: "Attendance",
                  style: appStyle(
                    size: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.titleLarge?.color ??
                        Colors.black,
                  ),
                ),
                AppTextstyle(
                  text: "2025",
                  style: appStyle(
                    size: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 250.h,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
            padding: EdgeInsets.all(16.w),
            child: AnimatedOpacity(
              opacity: monthlyAttendance.isNotEmpty ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastLinearToSlowEaseIn,
              child: AttendenceBarChart(
                monthlyAttendence: monthlyAttendance,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Actions Section
  Widget _buildActionsSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Card(
            elevation: 0,
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              leading: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  CupertinoIcons.money_dollar,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
              title: AppTextstyle(
                text: "View Salary Details",
                style: appStyle(
                  size: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.titleLarge?.color ??
                      Colors.black,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
              ),
              onTap: () {
                // Navigate to salary details
              },
            ),
          ),
          SizedBox(height: 12.h),
          //add edit profile button
          Card(
            elevation: 0,
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              leading: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  CupertinoIcons.pencil,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
              title: AppTextstyle(
                text: "Edit Profile",
                style: appStyle(
                  size: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.titleLarge?.color ??
                      Colors.black,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
              ),
              onTap: () {
                // Show bottom sheet for profile options
                _showProfileOptionsSheet(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Profile Picture Widget
  Widget _profilePicture(String profileURL) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 4.0,
        ),
      ),
      child: CircleAvatar(
        radius: 55.r,
        backgroundColor: Colors.white,
        child: ClipOval(
          child: Image.network(
            profileURL,
            width: 110.w,
            height: 110.h,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Bottom Sheet for Profile Options
  void _showProfileOptionsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 20.h),
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.edit, color: Colors.blue),
                ),
                title: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  context.push('/profileupdate');
                },
              ),
              ListTile(
                leading: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.logout, color: Colors.red),
                ),
                title: Text(
                  'Log out',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  context.go('/login');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
