import 'package:fleekhr/domain/entities/attendance/daily_attendance_entity.dart';
import 'package:fleekhr/domain/entities/attendance/monthly_attendance_entity.dart';

import 'package:fleekhr/presentation/Employee/attendence/components/daily_reports_selection.dart';
import 'package:fleekhr/presentation/Employee/attendence/components/monthly_stats_selection.dart';
import 'package:fleekhr/presentation/Employee/attendence/cubit/attendance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../components/month_selector.dart';

/// History Tab UI Components:
/// - Month selector with navigation arrows
/// - Monthly statistics cards (Working Days, On Time, Late, etc.)
/// - Daily reports list with IN/OUT times and status

class AttendanceStatusHelper {
  final bool isAbsent;
  final String status;

  AttendanceStatusHelper({required this.isAbsent, required this.status});
}

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  DateTime selectedMonth =
      DateTime.now(); // Currently selected month for viewing

  @override
  void initState() {
    super.initState();
    _loadAttendanceData();
  }

  void _loadAttendanceData() {
    final monthKey = DateFormat('yyyy-MM').format(selectedMonth);
    context.read<AttendanceCubit>().loadHistoryTabData(monthKey);
  }

  // Navigate to previous month
  void _onPreviousMonth() {
    setState(() {
      selectedMonth = DateTime(selectedMonth.year, selectedMonth.month - 1);
    });
    _loadAttendanceData();
  }

  // Navigate to next month
  void _onNextMonth() {
    setState(() {
      selectedMonth = DateTime(selectedMonth.year, selectedMonth.month + 1);
    });
    _loadAttendanceData();
  }

  Map<String, int> _generateMonthlyStats(MonthlyAttendanceEntity? monthlyData) {
    if (monthlyData == null) {
      return {
        'Working Days': 0,
        'On Time': 0,
        'Late': 0,
        'Left Timely': 0,
        'Left Early': 0,
        'On Leave': 0,
        'Absent': 0,
      };
    }

    return {
      'Working Days': monthlyData.workingDays,
      'On Time': monthlyData.onTime,
      'Late': monthlyData.late,
      'Left Timely': monthlyData.leftTimely,
      'Left Early': monthlyData.leftEarly,
      'On Leave': monthlyData.onLeave,
      'Absent': monthlyData.absent,
    };
  }

  List<Map<String, dynamic>> _generateDailyReports(
      List<DailyAttendanceEntity> dailyData) {
    return dailyData.map((attendance) {
      final computedStatus = _computeAttendanceStatus(attendance);
      return {
        'date': attendance.workDay,
        'day': DateFormat('EEE').format(attendance.workDay),
        'inTime': attendance.hasCheckedIn
            ? DateFormat('HH:mm').format(attendance.checkIn!)
            : '--:--',
        'outTime': attendance.hasCheckedOut
            ? DateFormat('HH:mm').format(attendance.checkOut!)
            : '--:--',
        'isAbsent': computedStatus.isAbsent,
        'status': computedStatus.status,
      };
    }).toList();
  }

  AttendanceStatusHelper _computeAttendanceStatus(
      DailyAttendanceEntity attendance) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final workDay = DateTime(attendance.workDay.year, attendance.workDay.month,
        attendance.workDay.day);

    final lateTime = DateTime(attendance.workDay.year, attendance.workDay.month,
        attendance.workDay.day, 9, 30); // 9:30 AM

    if (!attendance.hasCheckedIn) {
      // If the workday is in the past and there's no check-in, mark as Absent
      if (workDay.isBefore(today)) {
        return AttendanceStatusHelper(isAbsent: true, status: 'Absent');
      }
      // For today, if it's past check-in time, show 'Not Checked In'
      return AttendanceStatusHelper(isAbsent: false, status: 'Not Checked In');
    } else if (attendance.checkIn!.isAfter(lateTime)) {
      return AttendanceStatusHelper(isAbsent: false, status: 'Late');
    }
    return AttendanceStatusHelper(isAbsent: false, status: attendance.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AttendanceCubit, AttendanceState>(
        builder: (context, state) {
          MonthlyAttendanceEntity? monthlyAttendance;
          List<DailyAttendanceEntity> dailyAttendance = [];

          if (state is AttendanceHistoryTabLoaded) {
            monthlyAttendance = state.monthlyAttendance;
            dailyAttendance = state.dailyAttendance;
          }

          final currentMonthStats = _generateMonthlyStats(monthlyAttendance);
          final dailyReports = _generateDailyReports(dailyAttendance);

          // If we don't have data yet, show loading or use fallback data

          if (state is AttendanceLoading) {
            return Center(
              child: Lottie.asset(
                'assets/animation/loadingAnimation.json',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            );
          }

          if (state is AttendanceError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadAttendanceData,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => context.read<AttendanceCubit>().loadHistoryTabData(
                DateFormat('yyyy-MM').format(selectedMonth)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Month Selector
                  MonthSelector(
                    selectedMonth: selectedMonth,
                    onPreviousMonth: _onPreviousMonth,
                    onNextMonth: _onNextMonth,
                  ),

                  // Monthly Stats Cards
                  MonthlyStatsSection(monthlyStats: currentMonthStats),

                  const SizedBox(height: 24),

                  // Daily Reports
                  DailyReportsSection(dailyReports: dailyReports),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
