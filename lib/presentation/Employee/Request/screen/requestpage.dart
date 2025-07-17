import 'package:fleekhr/common/widgets/page_background.dart';
import 'package:fleekhr/presentation/Employee/Request/widget/request_header_widget.dart';
import 'package:fleekhr/presentation/Employee/Request/widget/request_dashboard_widget.dart';

import 'package:fleekhr/presentation/Employee/Request/utils/request_navigation_handler.dart';
import 'package:fleekhr/presentation/Employee/Request/constants/request_page_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main request page widget that displays request categories
/// Uses modular components for better code organization and maintainability
class Requestpage extends StatelessWidget {
  const Requestpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: RequestPageConstants.defaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: RequestPageConstants.headerSpacing),

                // Header section with title and subtitle
                const RequestHeaderWidget(),

                const SizedBox(height: RequestPageConstants.sectionSpacing),

                // Request cards grid with scrolling
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Dashboard with request categories
                        RequestDashboardWidget(
                          onNavigate: _handleNavigation,
                        ),
                        const SizedBox(
                            height: RequestPageConstants.bottomPadding),
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

  /// Handles navigation using the RequestNavigationHandler utility
  void _handleNavigation(BuildContext context, Map<String, dynamic> item) {
    RequestNavigationHandler.handleNavigation(
      context,
      item,
      (route) => context.push(route),
    );
  }
}
