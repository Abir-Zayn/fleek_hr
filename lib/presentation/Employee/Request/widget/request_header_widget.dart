import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/presentation/Employee/Request/constants/request_page_constants.dart';
import 'package:fleekhr/presentation/Employee/announcements/cubit/announcement_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Widget for displaying the request page header section
/// Contains the main title and subtitle for the request page, plus notification icon
class RequestHeaderWidget extends StatelessWidget {
  const RequestHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Title and subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main title with enhanced typography
              AppTextstyle(
                text: RequestPageConstants.pageTitle,
                style: appStyle(
                  size: RequestPageConstants.titleFontSize,
                  color: Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.black87,
                  fontWeight: RequestPageConstants.titleFontWeight,
                  letterSpacing: RequestPageConstants.titleLetterSpacing,
                ),
              ),
              const SizedBox(height: 4),

              // Subtitle with descriptive text
              AppTextstyle(
                text: RequestPageConstants.pageSubtitle,
                style: appStyle(
                  size: RequestPageConstants.subtitleFontSize,
                  color: Colors.grey.shade600,
                  fontWeight: RequestPageConstants.subtitleFontWeight,
                  height: RequestPageConstants.subtitleLineHeight,
                ),
              ),
            ],
          ),
        ),

        // Right side - Notification icon with badge
        BlocBuilder<AnnouncementCubit, AnnouncementState>(
          builder: (context, state) {
            int unreadCount = 0;
            if (state is AnnouncementLoaded) {
              unreadCount = state.readStatus.entries
                  .where((entry) => entry.value == false)
                  .length;
            }

            return Container(
              margin: const EdgeInsets.only(top: 8),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.notifications_outlined,
                        color: Theme.of(context).primaryColor,
                        size: 30,
                      ),
                      onPressed: () {
                        context.push('/announcements');
                      },
                      tooltip: 'View Announcements',
                    ),
                  ),
                  // Badge indicator for new announcements
                  if (unreadCount > 0) // Only show if there are unread
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 12,
                          minHeight: 10,
                        ),
                        child: Text(
                          '$unreadCount', // Dynamic count
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
