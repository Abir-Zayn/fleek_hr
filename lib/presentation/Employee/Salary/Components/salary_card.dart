import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';

class SalaryCard extends StatelessWidget {
  final String? id;
  final String month;
  final double basic;
  final double grossPay;
  final int totalLeave;
  final double netPay;
  final VoidCallback? onTap;

  const SalaryCard({
    this.id,
    super.key,
    this.month = "",
    required this.basic,
    required this.grossPay,
    required this.totalLeave,
    required this.netPay,
    this.onTap,
  });

  // Converting the month string to a more readable format
  String getFormattedMonth() {
    final parts = month.split('/');
    if (parts.length == 2) {
      final monthNumber = int.tryParse(parts[0]);
      final year = parts[1];
      if (monthNumber != null && monthNumber >= 1 && monthNumber <= 12) {
        return "${getMonthName(monthNumber)} $year";
      }
    }
    return month; // Fallback to original if parsing fails
  }

  String getMonthName(int monthNumber) {
    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return monthNames[monthNumber - 1];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Theme.of(context).cardColor,
          border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.4),
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 14.0, left: 15.0),
              child: AppTextstyle(
                text: getFormattedMonth(),
                style: appStyle(
                  size: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 8),
            buildSalaryDetailRow(
              context,
              "Basic Salary",
              "${basic.toStringAsFixed(2)} TK",
              Icons.monetization_on_outlined,
            ),
            buildSalaryDetailRow(
              context,
              "Gross Pay",
              "${grossPay.toStringAsFixed(2)} TK",
              Icons.account_balance_wallet_outlined,
            ),
            buildSalaryDetailRow(
              context,
              "Total Leave",
              "$totalLeave days",
              Icons.event_available_outlined,
            ),
            buildSalaryDetailRow(
              context,
              "Net Pay",
              "${netPay.toStringAsFixed(2)} TK",
              Icons.payments_outlined,
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.visibility_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  AppTextstyle(
                    text: "View Details",
                    style: appStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      size: 16.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSalaryDetailRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 15.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Theme.of(context).primaryColor.withOpacity(0.7),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppTextstyle(
              text: label,
              style: appStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyMedium?.color ??
                    Colors.black,
                size: 14.0,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color:
                  Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
