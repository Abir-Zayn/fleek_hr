import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/data/models/expense/expense_model.dart';
import 'package:fleekhr/domain/entities/expense/expense_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpenseSummaryWidget extends StatelessWidget {
  final List<ExpenseModel> expenses;

  const ExpenseSummaryWidget({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    final totalExpenses = expenses.length;
    final pendingCount =
        expenses.where((e) => e.status == StatusType.pending).length;
    final approvedCount =
        expenses.where((e) => e.status == StatusType.accepted).length;
    final rejectedCount =
        expenses.where((e) => e.status == StatusType.rejected).length;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextstyle(
              text: "Expense Overview",
              style: appStyle(
                size: 18.sp,
                color: Theme.of(context).textTheme.bodyMedium?.color ??
                    Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem("Total", totalExpenses.toString(), Colors.blue),
                _buildStatItem(
                    "Pending", pendingCount.toString(), Colors.orange),
                _buildStatItem(
                    "Approved", approvedCount.toString(), Colors.green),
                _buildStatItem(
                    "Rejected", rejectedCount.toString(), Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: AppTextstyle(
            text: count,
            style: appStyle(
              size: 18.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        AppTextstyle(
          text: label,
          style:
              appStyle(size: 14.sp, fontWeight: FontWeight.w500, color: color),
        ),
      ],
    );
  }
}
