part of 'announcement_cubit.dart';

@immutable
abstract class AnnouncementState {}

class AnnouncementInitial extends AnnouncementState {}

class AnnouncementLoading extends AnnouncementState {}

class AnnouncementLoaded extends AnnouncementState {
  final List<AnnouncementEntity> announcements;
  final Map<String, bool> readStatus; // Map of announcement ID to read status

  AnnouncementLoaded({required this.announcements, required this.readStatus});

  AnnouncementLoaded copyWith({
    List<AnnouncementEntity>? announcements,
    Map<String, bool>? readStatus,
  }) {
    return AnnouncementLoaded(
      announcements: announcements ?? this.announcements,
      readStatus: readStatus ?? this.readStatus,
    );
  }
}

class AnnouncementError extends AnnouncementState {
  final String message;

  AnnouncementError({required this.message});
}
