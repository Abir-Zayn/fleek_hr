import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/data/models/leave_request/leave_type.dart';

class LeaveBalanceDisplay extends StatelessWidget {
  final LeaveType leaveType;

  const LeaveBalanceDisplay({
    super.key,
    required this.leaveType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextstyle(
            text: '${leaveType.name} left :',
            style: appStyle(
                color: Colors.black, size: 14.sp, fontWeight: FontWeight.w500),
          ),
          AppTextstyle(
            text: '${leaveType.remainingDays}/${leaveType.availableDays} days',
            style: appStyle(
                color: Theme.of(context).primaryColor,
                size: 14.sp,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
