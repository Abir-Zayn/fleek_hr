import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/data/models/wfh_request/wfh_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class WorkFromHomeReqCard extends StatelessWidget {
  final bool isAdmin;
  final VoidCallback? onTap;
  final WfhModel wfhData;
  const WorkFromHomeReqCard(
      {super.key, this.isAdmin = false, this.onTap, required this.wfhData});

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  Color _getStatusColor() {
    switch (wfhData.status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            // Navigate to details screen with the WFH ID
            Navigator.pushNamed(
              context,
              '/wfh-details/${wfhData.id}',
              arguments: {'isAdmin': isAdmin},
            );
          },
      child: Card(
        elevation: 4,
        // color: Color(0xFFD1D5DB),
        color: Colors.white,
        shadowColor: Colors.black12,
        margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.deepOrange.shade100,
              Colors.deepOrange.shade200,
              Colors.deepOrange.shade300,
            ]),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              top: 12.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextstyle(
                  text: wfhData.employeeName,
                  style: appStyle(
                    size: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 8.h),
                dateValidation(
                  wfhData.startDate.toString(),
                  Icons.calendar_today,
                  Colors.grey.shade700,
                  'Starting',
                ),
                SizedBox(height: 4.h),
                dateValidation(
                  wfhData.endDate.toString(),
                  Icons.calendar_today,
                  Colors.grey.shade700,
                  'Ending',
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.description,
                      size: 16.sp,
                      color: Colors.grey.shade700,
                    ),
                    SizedBox(width: 8.w),
                    AppTextstyle(
                      text: 'Reason: ${wfhData.reason}',
                      style: appStyle(
                        size: 16.sp,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 6.h,
                      horizontal: 10.w,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                      ),
                    ),
                    child: AppTextstyle(
                      text: wfhData.status,
                      style: appStyle(
                        size: 15.sp,
                        color: _getStatusColor(),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dateValidation(
      String date, IconData icon, Color iconColor, String headingTxt) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: iconColor,
        ),
        SizedBox(width: 8.w),
        AppTextstyle(
          text: '$headingTxt: ${_formatDate(DateTime.parse(date))}',
          style: appStyle(
            size: 14.sp,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
