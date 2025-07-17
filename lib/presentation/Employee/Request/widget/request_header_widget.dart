import 'package:fleekhr/presentation/Employee/Request/constants/request_page_constants.dart';
import 'package:flutter/material.dart';

/// Widget for displaying the request page header section
/// Contains the main title and subtitle for the request page
class RequestHeaderWidget extends StatelessWidget {
  const RequestHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main title with enhanced typography
        Text(
          RequestPageConstants.pageTitle,
          style: TextStyle(
            fontSize: RequestPageConstants.titleFontSize,
            color:
                Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87,
            fontWeight: RequestPageConstants.titleFontWeight,
            letterSpacing: RequestPageConstants.titleLetterSpacing,
          ),
        ),
        const SizedBox(height: 4),

        // Subtitle with descriptive text
        Text(
          RequestPageConstants.pageSubtitle,
          style: TextStyle(
            fontSize: RequestPageConstants.subtitleFontSize,
            color: Colors.grey.shade600,
            fontWeight: RequestPageConstants.subtitleFontWeight,
            height: RequestPageConstants.subtitleLineHeight,
          ),
        ),
      ],
    );
  }
}
