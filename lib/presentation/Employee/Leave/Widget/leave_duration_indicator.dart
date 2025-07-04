import 'package:flutter/material.dart';

import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';

class LeaveDurationIndicator extends StatelessWidget {
  final int duration;
  final String durationType;

  const LeaveDurationIndicator({
    super.key,
    required this.duration,
    required this.durationType,
  });

  @override
  Widget build(BuildContext context) {
    if (duration <= 0) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Theme.of(context).primaryColor),
          SizedBox(width: 8),
          Expanded(
            child: AppTextstyle(
              text:
                  'Duration: ${durationType == 'Half Day' ? '0.5' : duration} day${duration > 1 ? 's' : ''}',
              style: appStyle(
                  color: Theme.of(context).primaryColor,
                  size: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
