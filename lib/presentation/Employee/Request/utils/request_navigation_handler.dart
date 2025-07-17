import 'package:flutter/material.dart';

/// Utility class for handling request page navigation
/// Contains methods for navigation, error handling, and dialog management
class RequestNavigationHandler {
  /// Handles navigation based on the request item
  /// Shows coming soon dialog for items without routes
  static void handleNavigation(
    BuildContext context,
    Map<String, dynamic> item,
    Function(String) pushRoute,
  ) {
    final route = item['route'] as String?;

    if (route != null) {
      try {
        // Direct navigation without loading indicator
        pushRoute(route);
      } catch (e) {
        // Show error-specific message for navigation failures
        _showNavigationError(context, item['text']);
      }
    } else {
      // Show enhanced coming soon dialog
      _showComingSoonDialog(context, item['text']);
    }
  }

  /// Shows navigation error SnackBar
  static void _showNavigationError(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Text('Failed to open $feature. Please try again.'),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Retry',
          textColor: Colors.white,
          onPressed: () {
            // Retry navigation logic could be added here
          },
        ),
      ),
    );
  }

  /// Shows coming soon dialog for features under development
  static void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.construction,
                color: Colors.orange,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Coming Soon',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          content: Text(
            '$feature is currently under development and will be available in future updates.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'Got it',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}
