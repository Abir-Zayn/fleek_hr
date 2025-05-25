import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class UserIdCard extends StatelessWidget {
  final String division;
  final String joinedDate;
  final int totalPresentDays;
  final int lateDays;
  final int absentDays;
  final Color backgroundColor;
  final Color textColor;
  final Color secondaryTextColor;

  const UserIdCard({
    super.key,
    required this.division,
    required this.joinedDate,
    required this.totalPresentDays,
    required this.lateDays,
    required this.absentDays,
    this.backgroundColor = const Color(0xFF0C1713),
    this.textColor = Colors.white,
    this.secondaryTextColor = Colors.grey,
  });

  // Factory constructor for creating a card with default values
  factory UserIdCard.defaultCard() {
    return const UserIdCard(
      division: 'Engineering',
      joinedDate: '2020-01-01',
      totalPresentDays: 20,
      lateDays: 2,
      absentDays: 1,
    );
  }

  // Convert string date to formatted display date
  String get formattedJoinDate {
    try {
      final DateTime date = DateTime.parse(joinedDate);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return joinedDate; // Return original if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextstyle(
                    text: 'Division',
                    style: appStyle(
                      size: 15.sp,
                      color: secondaryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AppTextstyle(
                    text: division,
                    style: appStyle(
                      size: 20.sp,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              _buildJoinedDateWidget(),
            ],
          ),
          SizedBox(height: 30.h),
          _buildUserDetailsWidget()
        ],
      ),
    );
  }

  Widget _buildJoinedDateWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: secondaryTextColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, size: 16, color: secondaryTextColor),
          const SizedBox(width: 5),
          Text(
            formattedJoinDate,
            style: TextStyle(
              fontSize: 14,
              color: secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserDetailsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildUserDetailItem('Total Present', totalPresentDays.toString()),
        _buildUserDetailItem('Late', lateDays.toString()),
        _buildUserDetailItem('Absent', absentDays.toString()),
      ],
    );
  }

  Widget _buildUserDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextstyle(
          text: title,
          style: appStyle(
            size: 14.sp,
            color: secondaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppTextstyle(
          text: "$value days",
          style: appStyle(
            size: 18.sp,
            color: secondaryTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
