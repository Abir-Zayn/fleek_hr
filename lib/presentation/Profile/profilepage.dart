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
    final monthlyAttendence = [
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
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.pencil),
            onPressed: () {
              //Show two dropdown menu 1. Edit Profile 2. LogOut
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 200.h,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.edit),
                          title: AppTextstyle(
                            text: 'Edit Profile',
                            style: appStyle(
                                size: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          onTap: () {
                            // Handle edit profile action
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: AppTextstyle(
                            text: 'Log out',
                            style: appStyle(
                                size: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          onTap: () {
                            // Handle log out action
                            context.go('/login');
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProfilePicture(
                      'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                  SizedBox(height: 20),
                  AppTextstyle(
                    text: "Welcome, Muhammad Yunus 👋",
                    style: appStyle(
                        size: 22.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  AppTextstyle(
                    text: "Last Logged In 1 - 5 - 2025 , 10:05 AM",
                    style: appStyle(
                        size: 15.sp,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(
                    height: 45,
                  ),
                  AppTextstyle(
                    text: "Present Sheet",
                    style: appStyle(
                        size: 22.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  // Bar Chart represent the attendance of the user
                  // package that used is fl_chart
                  SizedBox(
                    height: 250.h,
                    width: MediaQuery.of(context).size.width - 50,
                    child: AnimatedOpacity(
                      opacity: monthlyAttendence.isNotEmpty ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: AttendenceBarChart(
                        monthlyAttendence: monthlyAttendence,
                      ),
                    ),
                  )
                ],
              )
              // Add more widgets here as needed

              ),
        ),
      ),
    );
  }

  Widget ProfilePicture(String profileURL) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blue.shade900,
          width: 3.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.white,
        child: ClipOval(
          child: Image.network(
            profileURL,
            width: 94,
            height: 94,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
