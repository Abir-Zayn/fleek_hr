import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/data/models/leave_request/leave_data_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class LeaveRequestCard extends StatelessWidget {
  final LeaveDataCard leave;
  final bool isAdmin;
  final VoidCallback? onTap;
  final Function(bool)? onStatusChange;

  const LeaveRequestCard({
    super.key,
    required this.leave,
    this.isAdmin = false,
    this.onTap,
    this.onStatusChange,
  });

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  Color _getStatusColor() {
    switch (leave.status.toLowerCase()) {
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
            // Navigate to details screen with the leave ID
            context.push(
              '/leave-details/${leave.id}',
              extra: {'isAdmin': isAdmin},
            );
          },
      child: Card(
        elevation: 4,
        color: Theme.of(context).primaryColor.withOpacity(0.15),
        shadowColor: Colors.black12,
        margin: EdgeInsets.symmetric(vertical: 6.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          // side: BorderSide(
          //   color: Theme.of(context).textTheme.bodyMedium?.color ??
          //       Colors.grey.shade300,
          //   width: 1.1.w,
          // ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with employee name and status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            leave.employeeName,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: _getStatusColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: AppTextstyle(
                      text: leave.status,
                      style: appStyle(
                        color: _getStatusColor(),
                        fontWeight: FontWeight.w600,
                        size: 11.sp,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              // Leave type with attractive styling
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                child: AppTextstyle(
                  text: leave.leaveType,
                  style: appStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                    size: 12.sp,
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              // Date information with divider
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextstyle(
                          text: "Start Date",
                          style: appStyle(
                            size: 11.sp,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 12.sp,
                              color: Colors.grey.shade700,
                            ),
                            SizedBox(width: 4.w),
                            AppTextstyle(
                              text: _formatDate(leave.startDate),
                              style: appStyle(
                                  fontWeight: FontWeight.w600,
                                  size: 12.sp,
                                  color: Colors.black87),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 25.h,
                    width: 1,
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "End Date",
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 12.sp,
                                color: Colors.grey.shade700,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                _formatDate(leave.endDate),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
