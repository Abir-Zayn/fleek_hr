import 'package:flutter/material.dart';

// Enum for better status management and type safety
enum StatusType {
  accepted,
  pending,
  rejected,
}

// Optional: Helper function if you are getting status as a string
StatusType statusTypeFromString(String status) {
  switch (status.toLowerCase()) {
    case 'accepted':
      return StatusType.accepted;
    case 'pending':
      return StatusType.pending;
    case 'rejected':
      return StatusType.rejected;
    default:
      // Fallback to pending or throw an error, depending on desired behavior
      print('Warning: Unknown status string "$status", defaulting to pending.');
      return StatusType.pending;
  }
}

class StatusCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final StatusType status; // Changed to Enum
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  const StatusCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.status,
    this.leadingIcon,
    this.trailingIcon,
    this.height,
    this.width,
    this.borderRadius,
  });

  // Determines the card's background decoration based on the status
  BoxDecoration _getCardDecoration(BorderRadius effectiveBorderRadius) {
    List<Color> gradientColors = const [
      Color.fromARGB(255, 91, 165, 225),
      Color.fromARGB(255, 70, 40, 190),
    ];
    Color? solidColor;

    switch (status) {
      case StatusType.accepted:
        gradientColors = [
          Colors.green.shade400,
          Colors.green.shade600, // Darker green for contrast
        ];
        break;
      case StatusType.rejected:
        solidColor = Colors.red.shade500; // A clear red
        // For consistency, if we wanted a gradient for red:
        // gradientColors = [Colors.red.shade400, Colors.red.shade600];
        break;
      case StatusType.pending:
        gradientColors = const [
          Color.fromARGB(255, 91, 165, 225), // Default blueish gradient
          Color.fromARGB(255, 70, 40, 190),  // Slightly adjusted for depth
        ];
        break;
    }

    if (solidColor != null) {
      return BoxDecoration(
        color: solidColor,
        borderRadius: effectiveBorderRadius,
      );
    } else {
      return BoxDecoration(
        borderRadius: effectiveBorderRadius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
      );
    }
  }

  // Determines the text to display for the status
  String _getStatusText() {
    switch (status) {
      case StatusType.accepted:
        return 'Accepted';
      case StatusType.pending:
        return 'Pending';
      case StatusType.rejected:
        return 'Rejected';
      // Fallback text
    }
  }

  @override
  Widget build(BuildContext context) {
    // Default values for optional properties
    final double cardHeight = height ?? 125; // Slightly increased for better padding
    final double cardWidth = width ?? MediaQuery.of(context).size.width * 0.9;
    final BorderRadius effectiveBorderRadius = borderRadius ?? BorderRadius.circular(15.0);

    // Consistent text styles
    const TextStyle baseTextStyle = TextStyle(color: Colors.white);
    final TextStyle titleTextStyle = baseTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold);
    final TextStyle subtitleTextStyle = baseTextStyle.copyWith(fontSize: 14, color: Colors.white.withOpacity(0.9));
    final TextStyle dateTextStyle = baseTextStyle.copyWith(fontSize: 12, color: Colors.white.withOpacity(0.75));
    final TextStyle statusTextStyle = baseTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w500);

    return Container(
      height: cardHeight,
      width: cardWidth,
      decoration: BoxDecoration( // Outer container for shadow
        borderRadius: effectiveBorderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12), // Softened shadow
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0, // Shadow is handled by the outer container
        clipBehavior: Clip.antiAlias, // Ensures child respects border radius
        shape: RoundedRectangleBorder(
          borderRadius: effectiveBorderRadius,
        ),
        child: Container( // This container gets the conditional background
          decoration: _getCardDecoration(effectiveBorderRadius),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes space more evenly
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
                  children: [
                    Flexible( // To prevent title overflow
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (leadingIcon != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(
                                leadingIcon,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          Flexible( // Ensure title itself doesn't overflow
                            child: Text(
                              title,
                              style: titleTextStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25), // Slightly more opaque for status pill
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _getStatusText(), // Use helper for consistent status text
                        style: statusTextStyle,
                      ),
                    ),
                  ],
                ),
                Flexible( // Allow subtitle to take space and wrap
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0), // Add some vertical padding
                    child: Text(
                      subtitle,
                      style: subtitleTextStyle,
                      maxLines: 2, // Allow subtitle to wrap up to 2 lines
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end, // Align items to the bottom
                  children: [
                    Text(
                      date,
                      style: dateTextStyle,
                    ),
                    if (trailingIcon != null)
                      Icon(
                        trailingIcon,
                        color: Colors.white,
                        size: 20,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
