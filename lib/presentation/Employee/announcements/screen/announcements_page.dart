part of 'announcements_imports.dart';

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch announcements when the page loads
    context.read<AnnouncementCubit>().loadAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FleekAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: 'Announcements',
        onBackButtonPressed: () => context.pop(),
      ),
      body: PageBackground(
        child: BlocBuilder<AnnouncementCubit, AnnouncementState>(
            builder: (context, state) {
          if (state is AnnouncementLoading) {
            return Center(
              child: Lottie.asset(
                'assets/animation/loadingAnimation.json',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            );
          } else if (state is AnnouncementError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextstyle(
                    text: 'Error: ${state.message}',
                    style: appStyle(
                      size: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 3,
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<AnnouncementCubit>().loadAnnouncements(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is AnnouncementLoaded) {
            if (state.announcements.isEmpty) {
              return _buildEmptyState();
            } else {
              return _buildAnnouncementsList(
                  state.announcements, state.readStatus);
            }
          }
          // Initial state or fallback
          return _buildEmptyState(); // Or a loading skeleton
        }),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty state icon
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.campaign_outlined,
                size: 64,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 24),

            // Empty state title
            AppTextstyle(
              text: 'There is no announcements',
              style: appStyle(
                size: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Empty state description
            AppTextstyle(
              text:
                  'No announcements have been posted yet. Check back later for company updates and important notices.',
              style: appStyle(
                size: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementsList(
      List<AnnouncementEntity> announcements, Map<String, bool> readStatus) {
    return RefreshIndicator(
      onRefresh: () async {
        final cubit = context.read<AnnouncementCubit>();
        await cubit.loadAnnouncements();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: announcements.length,
        itemBuilder: (context, index) {
          final announcement = announcements[index];
          final isRead =
              readStatus[announcement.id] ?? false; // Default to unread

          return AnnouncementCard(
            announcement: announcement,
            isRead: isRead,
            onTap: () {
              // Mark as read when tapped
              context.read<AnnouncementCubit>().markAsRead(announcement.id);
              _showAnnouncementDetails(announcement, context); // Pass context
            },
          );
        },
      ),
    );
  }

  // Future<void> _refreshAnnouncements() async {
  //   // Simulate network call
  //   await Future.delayed(const Duration(milliseconds: 800));
  //   // TODO: Replace with actual state management call
  //   if (mounted) {
  //     setState(() {
  //       // This would be replaced with actual data fetching
  //     });
  //   }
  // }

  // Modify _showAnnouncementDetails to accept context for cubit access if needed inside bottom sheet
  void _showAnnouncementDetails(
      AnnouncementEntity announcement, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _buildAnnouncementDetailSheet(
          announcement, context), // Pass original context
    );
  }

  Widget _buildAnnouncementDetailSheet(
      AnnouncementEntity announcement, BuildContext context) {
    return StatefulBuilder(
      // Use StatefulBuilder to update button inside modal
      builder: (BuildContext context, StateSetter setState) {
        final cubit = context.read<AnnouncementCubit>();
        final isRead =
            (cubit.state as AnnouncementLoaded).readStatus[announcement.id] ??
                false;

        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.campaign_outlined,
                        color: Theme.of(context).primaryColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextstyle(
                            text: announcement.title,
                            style: appStyle(
                              size: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 4),
                          AppTextstyle(
                            text: DateFormat('MMMM dd, yyyy • hh:mm a').format(
                              announcement.publishedAt ??
                                  announcement.createdAt,
                            ),
                            style: appStyle(
                              size: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextstyle(
                        text: announcement.content,
                        style: appStyle(
                          size: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade800,
                          height: 1.6,
                        ),
                      ),
                      if (_hasAttachments(announcement.attachments)) ...[
                        const SizedBox(height: 20),
                        AppTextstyle(
                          text: "Attachments:",
                          style: appStyle(
                            size: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.attach_file,
                                color: Colors.grey.shade600,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              AppTextstyle(
                                text:
                                    "${_getAttachmentCount(announcement.attachments)} attachment(s) available",
                                style: appStyle(
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              // Seen/Unseen Toggle Button at the bottom of the sheet
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton.icon(
                  onPressed: () {
                    cubit.toggleReadStatus(announcement.id);
                    // Update the button state within the modal
                    setState(() {});
                  },
                  icon: Icon(isRead ? Icons.visibility_off : Icons.visibility),
                  label: Text(isRead ? 'Mark as Unread' : 'Mark as Read'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isRead ? Colors.grey : Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool _hasAttachments(dynamic attachments) {
    if (attachments == null) return false;
    if (attachments is List) return attachments.isNotEmpty;
    if (attachments is Map) return attachments.isNotEmpty;
    return false;
  }

  int _getAttachmentCount(dynamic attachments) {
    if (attachments == null) return 0;
    if (attachments is List) return attachments.length;
    if (attachments is Map) return attachments.length;
    return 0;
  }
}
