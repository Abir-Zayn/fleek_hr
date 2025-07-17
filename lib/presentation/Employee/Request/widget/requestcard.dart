import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:flutter/material.dart';

class Requestcard extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? description;
  final Color iconColor;
  final VoidCallback? onTap;

  const Requestcard({
    super.key,
    required this.icon,
    required this.text,
    this.description,
    this.iconColor = Colors.black,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: iconColor.withOpacity(0.08),
              spreadRadius: 0,
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.all(12), // Reduced padding to prevent overflow
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.center, // Everything centered
            children: [
              // Icon container with gradient
              Container(
                padding: const EdgeInsets.all(12), // Reduced icon padding
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      iconColor.withOpacity(0.1),
                      iconColor.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: iconColor.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 28, // Slightly reduced icon size
                ),
              ),
              const SizedBox(height: 12), // Reduced spacing

              // Title with typography
              AppTextstyle(
                text: text,
                style: appStyle(
                  size: 15, // Slightly reduced font size
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),

              // Description with styling
              if (description != null) ...[
                const SizedBox(height: 6), // Reduced spacing
                Flexible(
                  // Use Flexible to prevent overflow
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 2), // Reduced padding
                    child: Text(
                      description!,
                      style: TextStyle(
                        fontSize: 11, // Reduced font size
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        height: 1.2, // Reduced line height
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
