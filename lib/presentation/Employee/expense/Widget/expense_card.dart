import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/data/models/expense/expense_model.dart';
import 'package:fleekhr/domain/entities/expense/expense_entities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ExpenseCardWidget extends StatelessWidget {
  final ExpenseModel expense;
  final VoidCallback onTap;

  const ExpenseCardWidget({
    super.key,
    required this.expense,
    required this.onTap,
  });

  IconData _getExpenseIcon(String purpose) {
    purpose = purpose.toLowerCase();
    if (purpose.contains("rickshaw") || purpose.contains("taxi")) {
      return CupertinoIcons.car_detailed;
    } else if (purpose.contains("bus") ||
        purpose.contains("train") ||
        purpose.contains("metro")) {
      return CupertinoIcons.bus;
    } else if (purpose.contains("food") ||
        purpose.contains("lunch") ||
        purpose.contains("pizza")) {
      return CupertinoIcons.flame;
    } else if (purpose.contains("office") || purpose.contains("supplies")) {
      return CupertinoIcons.doc_text;
    } else {
      return CupertinoIcons.money_dollar_circle;
    }
  }

  Color _getExpenseColor(String purpose) {
    purpose = purpose.toLowerCase();
    if (purpose.contains("rickshaw") ||
        purpose.contains("taxi") ||
        purpose.contains("bus")) {
      return Colors.blue;
    } else if (purpose.contains("food") ||
        purpose.contains("lunch") ||
        purpose.contains("pizza")) {
      return Colors.orange;
    } else if (purpose.contains("office") || purpose.contains("supplies")) {
      return Colors.green;
    } else {
      return Colors.blue; // Fallback to a default color
    }
  }

  Color _getStatusColor(StatusType status) {
    switch (status) {
      case StatusType.pending:
        return Colors.orange;
      case StatusType.accepted:
        return Colors.green;
      case StatusType.rejected:
        return Colors.red;
    }
  }

  String _getStatusText(StatusType status) {
    switch (status) {
      case StatusType.pending:
        return "Pending";
      case StatusType.accepted:
        return "Approved";
      case StatusType.rejected:
        return "Rejected";
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(symbol: '\$');
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: _getExpenseColor(expense.purpose).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  _getExpenseIcon(expense.purpose),
                  color: _getExpenseColor(expense.purpose),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.purpose,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Date: ${expense.date}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: _getStatusColor(expense.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      _getStatusText(expense.status),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: _getStatusColor(expense.status),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  AppTextstyle(
                    text: formatter.format(expense.amount),
                    style: appStyle(
                      size: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
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
