import 'package:fleekhr/presentation/Employee/Request/widget/requestcard.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Requestpage extends StatelessWidget {
  const Requestpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Enhanced gradient background for modern appeal
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                // Enhanced header section with improved typography
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What would you like to request?",
                      style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).textTheme.bodyLarge?.color ??
                            Colors.black87,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Select a category to submit your request",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Request cards grid with enhanced scrolling
                Expanded(
                  child: SingleChildScrollView(
                    physics:
                        const BouncingScrollPhysics(), // iOS-style bouncing scroll
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        requestPageDashboard(context),
                        const SizedBox(height: 40), // Extra bottom padding
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget requestPageDashboard(BuildContext context) {
    // Request categories with concise descriptions
    final List<Map<String, dynamic>> reqList = [
      {
        'icon': Icons.laptop_mac,
        'text': "Work From Home",
        'color': Colors.blue,
        'description': 'Remote work request',
        'route': '/workfromhome',
      },
      {
        'icon': Icons.event_busy_rounded,
        'text': "Leave Request",
        'color': Colors.pink,
        'description': 'Apply for time off',
        'route': '/leave-history',
      },
      {
        'icon': Icons.receipt_long_outlined,
        'text': "Expense Claim",
        'color': Colors.teal,
        'description': 'Submit expenses',
        'route': '/expense',
      },
      {
        'icon': Icons.assignment_outlined,
        'text': "Task Request",
        'color': Colors.orange,
        'description': 'Request assignments',
        'route': '/dailyactivities',
      },
      {
        'icon': Icons.headset_mic_outlined,
        'text': 'IT Support',
        'color': Colors.purple,
        'description': 'Get tech support',
        'route': null,
      },
      {
        'icon': Icons.access_time_filled,
        'text': "Attendance",
        'color': Colors.green,
        'description': 'View attendance',
        'route': '/attendance',
      },
      {
        'icon': Icons.account_balance_wallet_outlined,
        'text': "Salary Request",
        'color': Colors.amber,
        'description': 'Salary inquiries',
        'route': '/salary-overview',
      },
      {
        'icon': Icons.group_outlined,
        'text': "Manage Employees",
        'color': Colors.cyan,
        'description': 'HR management',
        'route': '/manage-employees',
      },
    ];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(), // Disable grid scrolling
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1, // Increased aspect ratio to prevent overflow
        ),
        itemCount: reqList.length,
        itemBuilder: (context, index) {
          // Add staggered animation for better visual appeal
          return AnimatedContainer(
            duration: Duration(milliseconds: 300 + (index * 100)),
            curve: Curves.easeOutBack,
            child: Requestcard(
              icon: reqList[index]['icon'],
              text: reqList[index]['text'],
              description: reqList[index]['description'],
              iconColor: reqList[index]['color'],
              onTap: () => _handleNavigation(context, reqList[index]),
            ),
          );
        },
      ),
    );
  }

  // Simplified navigation handling
  void _handleNavigation(BuildContext context, Map<String, dynamic> item) {
    final route = item['route'] as String?;

    if (route != null) {
      try {
        // Direct navigation without loading indicator
        context.push(route);
      } catch (e) {
        // Show error-specific message for navigation failures
        _showNavigationError(context, item['text']);
      }
    } else {
      // Show enhanced coming soon dialog
      _showComingSoonDialog(context, item['text']);
    }
  }

  // Navigation error handler
  void _showNavigationError(BuildContext context, String feature) {
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

  // Enhanced coming soon dialog with better UX
  void _showComingSoonDialog(BuildContext context, String feature) {
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
