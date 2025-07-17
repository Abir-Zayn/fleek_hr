import 'package:fleekhr/common/widgets/page_background.dart';
import 'package:fleekhr/presentation/Employee/Profile/Widget/attendance_section.dart';
import 'package:fleekhr/presentation/Employee/Profile/Widget/contact_info.dart';
import 'package:fleekhr/presentation/Employee/Profile/Widget/profile_header.dart';
import 'package:fleekhr/presentation/Employee/Profile/Widget/profile_page_optional.dart';
import 'package:fleekhr/presentation/Employee/Profile/cubit/profile_cubit.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return BlocProvider(
      create: (context) => sl<ProfileCubit>()..getUser(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProfileError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading profile',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.red.shade700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.failure.message,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<ProfileCubit>().refreshProfile();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (state is ProfileLoaded) {
                final user = state.user;
                return PageBackground(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ProfileHeader(
                          name: user.name,
                          role: user.designation,
                          imageUrl:
                              'https://images.unsplash.com/photo-1683029096295-7680306aa37d?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        ),
                        ContactInfoSection(
                          email: user.email,
                          phone: user.phone,
                          department: user.department,
                        ),
                        AttendanceSection(monthlyAttendance: monthlyAttendance),
                        const ProfileActionsSection(),
                      ],
                    ),
                  ),
                );
              }

              // ProfileInitial state
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
