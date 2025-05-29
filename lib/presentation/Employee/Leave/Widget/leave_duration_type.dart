import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';

class LeaveDurationType extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeChanged;

  const LeaveDurationType({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextstyle(
          text: 'Leave Duration Type',
          style: appStyle(
              color: Colors.black, size: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: Text('Full Day'),
                value: 'Full Day',
                groupValue: selectedType,
                onChanged: (value) {
                  onTypeChanged(value!);
                },
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text('Half Day'),
                value: 'Half Day',
                groupValue: selectedType,
                onChanged: (value) {
                  onTypeChanged(value!);
                },
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
