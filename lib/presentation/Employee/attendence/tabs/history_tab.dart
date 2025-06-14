import 'package:fleekhr/presentation/Employee/attendence/Utities/reporting_data.dart';
import 'package:fleekhr/presentation/Employee/attendence/components/daily_reports_selection.dart';
import 'package:fleekhr/presentation/Employee/attendence/components/monthly_stats_selection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/month_selector.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  DateTime selectedMonth = DateTime.now();

  void _onPreviousMonth() {
    setState(() {
      selectedMonth = DateTime(selectedMonth.year, selectedMonth.month - 1);
    });
  }

  void _onNextMonth() {
    setState(() {
      selectedMonth = DateTime(selectedMonth.year, selectedMonth.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    String monthKey = DateFormat('yyyy-MM').format(selectedMonth);
    Map<String, int> currentMonthStats =
        ReportDataGenerator.monthlyData[monthKey] ??
            ReportDataGenerator.monthlyData['2025-06']!;

    List<Map<String, dynamic>> dailyReports =
        ReportDataGenerator.generateDailyReports(selectedMonth);

    return Scaffold(
     
      body: SingleChildScrollView(
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
  }
}
