import 'package:fleekhr/common/widgets/apptextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Input field for WFH request reason with common reasons option
class ReasonInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onCommonReasonsTap;

  const ReasonInput({
    super.key,
    required this.controller,
    required this.onCommonReasonsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Reason for WFH",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            TextButton.icon(
              onPressed: onCommonReasonsTap,
              icon: Icon(
                CupertinoIcons.text_quote,
                size: 16.sp,
              ),
              label: Text(
                "Common Reasons",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Apptextfield(
          controller: controller,
          height: 100.h,
          width: double.infinity,
          borderRadius: 12,
          contentPadding: const EdgeInsets.all(16.0),
          hintText: "Describe your reason for working from home...",
          maxLines: 4,
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }
}
