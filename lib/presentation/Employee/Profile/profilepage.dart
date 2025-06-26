import 'package:fleekhr/presentation/Employee/Profile/Widget/attendance_section.dart';
import 'package:fleekhr/presentation/Employee/Profile/Widget/contact_info.dart';
import 'package:fleekhr/presentation/Employee/Profile/Widget/profile_header.dart';
import 'package:fleekhr/presentation/Employee/Profile/Widget/profile_page_optional.dart';
import 'package:flutter/material.dart';


class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    final monthlyAttendance = [
      25.0, 28.0, 20.0, 15.0, 22.0, 27.0,
      30.0, 18.0, 26.0, 29.0, 24.0, 21.0
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ProfileHeader(
                name: "Muhammad Yunus",
                role: "Employee",
                imageUrl: 'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              ),
              const ContactInfoSection(
                email: "abirzayn561@gmail.com",
                phone: "xxx-xxxx-xxxx",
                department: "Engineering",
              ),
              AttendanceSection(monthlyAttendance: monthlyAttendance),
              const ProfileActionsSection(),
            ],
          ),
        ),
      ),
    );
  }
}