import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/domain/entities/announcement/announcement_entities.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnnouncementCard extends StatelessWidget {
  final AnnouncementEntity announcement;
  final VoidCallback? onTap;
  final bool isRead;

  const AnnouncementCard({
    super.key,
    required this.announcement,
    this.onTap,
    this.isRead = false, // For now, all are unread by default
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isRead ? 1 : 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isRead
            ? BorderSide.none
            : BorderSide(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                width: 1,
              ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isRead
                ? null
                : Theme.of(context).primaryColor.withOpacity(0.02),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with announcement icon and date
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.campaign_outlined,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppTextstyle(
                        text: announcement.title,
                        style: appStyle(
                          size: 16,
                          fontWeight:
                              isRead ? FontWeight.w500 : FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyLarge?.color ??
                              Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Date and unread indicator
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppTextstyle(
                          text: _formatDate(announcement.publishedAt ??
                              announcement.createdAt),
                          style: appStyle(
                            size: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        if (!isRead) ...[
                          const SizedBox(height: 4),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Content preview
                AppTextstyle(
                  text: announcement.content,
                  style: appStyle(
                    size: 14,
                    fontWeight: FontWeight.w400,
                    color: isRead ? Colors.grey.shade600 : Colors.grey.shade700,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                // Attachment indicator
                if (_hasAttachments()) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_file,
                        size: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 4),
                      AppTextstyle(
                        text:
                            '${_getAttachmentCount()} attachment${_getAttachmentCount() > 1 ? 's' : ''}',
                        style: appStyle(
                          size: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],

                // Published status indicator
                if (announcement.isPublished) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 12,
                              color: Colors.green.shade700,
                            ),
                            const SizedBox(width: 4),
                            AppTextstyle(
                              text: 'Published',
                              style: appStyle(
                                size: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }

  bool _hasAttachments() {
    if (announcement.attachments == null) return false;
    if (announcement.attachments is List) {
      return (announcement.attachments as List).isNotEmpty;
    }
    if (announcement.attachments is Map) {
      return (announcement.attachments as Map).isNotEmpty;
    }
    return false;
  }

  int _getAttachmentCount() {
    if (announcement.attachments == null) return 0;
    if (announcement.attachments is List) {
      return (announcement.attachments as List).length;
    }
    if (announcement.attachments is Map) {
      return (announcement.attachments as Map).length;
    }
    return 0;
  }
}
