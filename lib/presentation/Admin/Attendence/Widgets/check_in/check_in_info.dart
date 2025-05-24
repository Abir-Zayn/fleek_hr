import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckInInfo extends StatelessWidget {
  final TimeOfDay? checkInTime;
  const CheckInInfo({super.key, this.checkInTime});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoRow("Check In Time",
                    checkInTime != null ? checkInTime!.format(context) : "--"),
                const SizedBox(height: 8),
                _buildInfoRow("Check Out Time", "--"),
              ],
            ),
            SizedBox(height: 15.h),
            Center(
              child: _buildInfoRow("Total Hours Worked", "--"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Builder(
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppTextstyle(
                text: label,
                style: appStyle(
                    size: 20.sp,
                    color: Theme.of(context).textTheme.bodyMedium?.color ??
                        Colors.black,
                    fontWeight: FontWeight.w600)),
            AppTextstyle(
              text: value,
              style: appStyle(
                  color:
                      Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
                  size: 20.sp,
                  fontWeight: FontWeight.w400),
            ),
          ],
        );
      }
    );
  }
}
