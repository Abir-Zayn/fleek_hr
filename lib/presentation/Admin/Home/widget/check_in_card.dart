import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';

class CheckInCard extends StatelessWidget {
  final String headingText;
  final String timeText;
  final String statusText;
  final IconData? icon;

  const CheckInCard({
    super.key,
    required this.headingText,
    required this.timeText,
    required this.statusText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color ?? Colors.black;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon ?? Icons.access_time_rounded,
                  color: theme.primaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppTextstyle(
                  text: headingText,
                  style: appStyle(
                    size: 18,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppTextstyle(
            text: timeText,
            style: appStyle(
              size: 16,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          statusTextWidget(context),
        ],
      ),
    );
  }

  Widget statusTextWidget(BuildContext context) {
    final theme = Theme.of(context);

    // Determine status color based on text (assuming "On Time" is good, others might be warnings)
    Color statusColor;
    if (statusText.toLowerCase().contains("on time")) {
      statusColor = Colors.green.shade700;
    } else if (statusText.toLowerCase().contains("late")) {
      statusColor = Colors.orange.shade700;
    } else if (statusText.toLowerCase().contains("absent")) {
      statusColor = Colors.red.shade700;
    } else {
      statusColor = theme.textTheme.bodyMedium?.color ?? Colors.black54;
    }

    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: statusColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        AppTextstyle(
          text: statusText,
          style: appStyle(
            size: 14,
            color: statusColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
