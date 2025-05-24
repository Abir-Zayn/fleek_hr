import 'package:fleekhr/presentation/Admin/Attendence/Widgets/history/summary_item.dart';
import 'package:fleekhr/presentation/Admin/Attendence/Widgets/history/summary_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SummaryCard extends StatelessWidget {
  final List<SummaryItem> items;

  const SummaryCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            for (int i = 0; i < items.length; i++) ...[
              SummaryRow(
                item: items[i],
                isLast: i == items.length - 1,
              ),
              if (i < items.length - 1)
                Divider(
                  height: 24.h,
                  thickness: 1,
                  color: Colors.grey.withOpacity(0.3),
                ),
            ],
          ],
        ),
      ),
    );
  }
}