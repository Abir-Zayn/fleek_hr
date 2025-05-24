import 'package:fleekhr/presentation/Admin/Attendence/Widgets/check_in/check_in_btn.dart';
import 'package:fleekhr/presentation/Admin/Attendence/Widgets/check_in/check_in_info.dart';
import 'package:fleekhr/presentation/Admin/Attendence/Widgets/check_in/greet_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckInTab extends StatefulWidget {
  const CheckInTab({super.key});

  @override
  State<CheckInTab> createState() => _CheckInTabState();
}

class _CheckInTabState extends State<CheckInTab> {
  bool isCheckedIn = false;
  TimeOfDay? checkInTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30.h,
          ),
          GreetSection(),
          const SizedBox(height: 24),
          CheckInBtn(
            isCheckedIn: isCheckedIn,
            onPressed: isCheckedIn
                ? null
                : () {
                    setState(() {
                      isCheckedIn = true;
                      checkInTime = TimeOfDay.now();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Check In Successfully")),
                    );
                  },
          ),
          const SizedBox(height: 24),
          CheckInInfo(checkInTime: checkInTime),
        ],
      ),
    );
  }
}
