import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveBalanceTable extends StatelessWidget {
  final List<LeaveBalanceData> leaveBalances;
  final Map<int, TableColumnWidth>? columnWidths;
  final Color? borderColor;
  final Color? headerBackgroundColor;
  final double? borderRadius;
  final TextStyle? headerTextStyle;
  final TextStyle? bodyTextStyle;

  const LeaveBalanceTable({
    super.key,
    required this.leaveBalances,
    this.columnWidths,
    this.borderColor,
    this.headerBackgroundColor,
    this.borderRadius,
    this.headerTextStyle,
    this.bodyTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBorderSide = BorderSide(
      color: borderColor ?? Colors.grey.shade300,
      width: 1,
    );

    final headerDecoration = BoxDecoration(
      color: headerBackgroundColor ?? theme.primaryColor.withOpacity(0.1),
      border: Border(bottom: defaultBorderSide),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular((borderRadius ?? 12).r),
        border: Border.all(color: borderColor ?? Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular((borderRadius ?? 12).r),
        child: Table(
          columnWidths: columnWidths ??
              const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1.5),
              },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            // Table header
            TableRow(
              decoration: headerDecoration,
              children: [
                leaveTableCell(context, "Leave Type", isHeader: true),
                leaveTableCell(context, "Used", isHeader: true),
                leaveTableCell(context, "Available", isHeader: true),
              ],
            ),
            // Data rows
            ...leaveBalances.map((balance) => tableRow(
                  context,
                  balance.type,
                  balance.used,
                  balance.total,
                )),
          ],
        ),
      ),
    );
  }

  Widget leaveTableCell(BuildContext context, String text,
      {bool isHeader = false}) {
    final defaultStyle = isHeader
        ? headerTextStyle ??
            TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            )
        : bodyTextStyle ??
            TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: defaultStyle,
        ),
      ),
    );
  }

  TableRow tableRow(
      BuildContext context, String type, String used, String total) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom:
              BorderSide(color: borderColor ?? Colors.grey.shade300, width: 1),
        ),
      ),
      children: [
        leaveTableCell(context, type),
        leaveTableCell(context, used),
        leaveTableCell(context, total),
      ],
    );
  }
}

class LeaveBalanceData {
  final String type;
  final String used;
  final String total;

  LeaveBalanceData({
    required this.type,
    required this.used,
    required this.total,
  });
}
