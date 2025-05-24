import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GreetSection extends StatelessWidget {
  const GreetSection({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour;
    String greeting;

    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

    final formattedTime = DateFormat('hh:mm a').format(now);
    final formattedDate = DateFormat('EEE, MMM d, y').format(now);

    return Column(
      children: [
        AppTextstyle(
          text: "$greeting! ",
          style: appStyle(
              size: 22,
              color:
                  Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        AppTextstyle(
          text: "$formattedTime, $formattedDate",
          style: appStyle(
              size: 18,
              color:
                  Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
