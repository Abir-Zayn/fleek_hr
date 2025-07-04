import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';

/// A widget that displays detailed information about a leave request.
/// It includes the title and a list of child widgets that represent various details
class LeaveDetailsInfo extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const LeaveDetailsInfo(
      {super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: AppTextstyle(
              text: title,
              style: appStyle(
                  size: 15,
                  color: Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.black87,
                  fontWeight: FontWeight.bold)),
        ),
        ...children,
        SizedBox(height: 16), // Add some spacing after the children
      ],
    );
  }
}
