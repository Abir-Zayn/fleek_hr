import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DaterangetopBar extends StatelessWidget {
  final DateTime startDate;
  final String TopHead;
  final double fontSize;

  const DaterangetopBar(
      {super.key,
      required this.startDate,

      required this.TopHead,
      this.fontSize = 13.00});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        AppTextstyle(
          text: TopHead,
          style: appStyle(
              size: 15.sp, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 5.h,
        ),
        AppTextstyle(
          text: "${startDate.day}/${startDate.month}/${startDate.year}",
          style: appStyle(
              size: fontSize, color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
