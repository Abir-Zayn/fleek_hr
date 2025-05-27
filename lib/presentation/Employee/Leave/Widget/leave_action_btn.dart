import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveActionBtn extends StatelessWidget {
  final String headingText;
  final Color? headingColor;
  final Color? cardColor;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onPressed;

  const LeaveActionBtn({
    super.key,
    required this.headingText,
    required this.icon,
    this.onPressed,
    this.headingColor,
    this.cardColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        height: 160.h,
        width: 170.w,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: cardColor ?? theme.cardColor,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: iconColor ?? headingColor ?? theme.primaryColor,
            ),
            const SizedBox(height: 16),
            AppTextstyle(
              text: headingText,
              style: appStyle(
                size: 18,
                color: headingColor ??
                    theme.textTheme.bodyLarge?.color ??
                    Colors.black,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
