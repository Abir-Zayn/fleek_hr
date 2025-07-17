import 'package:fleekhr/presentation/Employee/Request/widget/requestcard.dart';
import 'package:fleekhr/presentation/Employee/Request/constants/request_page_constants.dart';
import 'package:flutter/material.dart';

/// Model class for request category data
class RequestCategoryData {
  final IconData icon;
  final String text;
  final Color color;
  final String description;
  final String? route;

  const RequestCategoryData({
    required this.icon,
    required this.text,
    required this.color,
    required this.description,
    this.route,
  });
}

/// Widget for displaying the grid of request categories
/// Contains all request types in a responsive grid layout
class RequestDashboardWidget extends StatelessWidget {
  final Function(BuildContext, Map<String, dynamic>) onNavigate;

  const RequestDashboardWidget({
    super.key,
    required this.onNavigate,
  });

  /// Static list of request categories from constants
  static const List<RequestCategoryData> _requestCategories =
      RequestPageConstants.requestCategories;

  /// Converts RequestCategoryData to Map for backward compatibility
  Map<String, dynamic> _categoryToMap(RequestCategoryData category) {
    return {
      'icon': category.icon,
      'text': category.text,
      'color': category.color,
      'description': category.description,
      'route': category.route,
    };
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: RequestPageConstants.containerAnimationDuration,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(), // Disable grid scrolling
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: RequestPageConstants.gridCrossAxisCount,
          crossAxisSpacing: RequestPageConstants.cardSpacing,
          mainAxisSpacing: RequestPageConstants.cardSpacing,
          childAspectRatio: RequestPageConstants.gridAspectRatio,
        ),
        itemCount: _requestCategories.length,
        itemBuilder: (context, index) {
          final category = _requestCategories[index];

          // Add staggered animation for better visual appeal
          return AnimatedContainer(
            duration: Duration(
              milliseconds:
                  RequestPageConstants.staggerAnimationBase.inMilliseconds +
                      (index * RequestPageConstants.staggerAnimationIncrement),
            ),
            curve: Curves.easeOutBack,
            child: Requestcard(
              icon: category.icon,
              text: category.text,
              description: category.description,
              iconColor: category.color,
              onTap: () => onNavigate(context, _categoryToMap(category)),
            ),
          );
        },
      ),
    );
  }
}
