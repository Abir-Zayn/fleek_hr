import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/domain/entities/announcement/announcement_entities.dart';
import 'package:fleekhr/domain/usecase/announcement/get_announcement.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  final GetAnnouncementsUseCase getAnnouncementsUseCase;

  // Key for storing read status in shared preferences
  static const String _readStatusKey = 'announcement_read_status';

  AnnouncementCubit({required this.getAnnouncementsUseCase})
      : super(AnnouncementInitial());

  /// Fetches announcements and loads read status from local storage
  Future<void> loadAnnouncements() async {
    emit(AnnouncementLoading());
    try {
      // Add 1100ms delay for loading animation
      await Future.delayed(const Duration(milliseconds: 1100));

      final result =
          await getAnnouncementsUseCase(params: null); // params is void

      result.fold(
        (failure) {
          emit(AnnouncementError(message: _mapFailureToMessage(failure)));
        },
        (announcements) async {
          final readStatus = await _loadReadStatus();
          // Initialize read status for new announcements if not present
          final updatedReadStatus = Map<String, bool>.from(readStatus);
          bool statusChanged = false;
          for (var announcement in announcements) {
            if (!updatedReadStatus.containsKey(announcement.id)) {
              updatedReadStatus[announcement.id] = false; // Default to unread
              statusChanged = true;
            }
          }
          if (statusChanged) {
            await _saveReadStatus(updatedReadStatus);
          }
          emit(AnnouncementLoaded(
              announcements: announcements, readStatus: updatedReadStatus));
        },
      );
    } catch (e) {
      emit(AnnouncementError(message: 'An unexpected error occurred: $e'));
    }
  }

  /// Marks an announcement as read/unread and saves the status
  Future<void> toggleReadStatus(String announcementId) async {
    final currentState = state;
    if (currentState is AnnouncementLoaded) {
      final currentReadStatus = Map<String, bool>.from(currentState.readStatus);
      currentReadStatus[announcementId] =
          !(currentReadStatus[announcementId] ?? false);

      await _saveReadStatus(currentReadStatus);
      emit(currentState.copyWith(readStatus: currentReadStatus));
    }
  }

  /// Marks an announcement as read (helper method)
  Future<void> markAsRead(String announcementId) async {
    final currentState = state;
    if (currentState is AnnouncementLoaded) {
      if (currentState.readStatus[announcementId] == true)
        return; // Already read
      final currentReadStatus = Map<String, bool>.from(currentState.readStatus);
      currentReadStatus[announcementId] = true;
      await _saveReadStatus(currentReadStatus);
      emit(currentState.copyWith(readStatus: currentReadStatus));
    }
  }

  /// Loads read status from shared preferences
  Future<Map<String, bool>> _loadReadStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_readStatusKey) ?? '{}';
    // Simple JSON parsing - consider using a proper JSON library for complex structures
    final map = <String, bool>{};
    if (jsonString.startsWith('{') && jsonString.endsWith('}')) {
      final content = jsonString.substring(1, jsonString.length - 1);
      if (content.isNotEmpty) {
        final pairs = content.split(',');
        for (var pair in pairs) {
          final keyValue = pair.split(':');
          if (keyValue.length == 2) {
            final key = keyValue[0].replaceAll('"', '').trim();
            final value = keyValue[1].trim() == 'true';
            map[key] = value;
          }
        }
      }
    }
    return map;
  }

  /// Saves read status to shared preferences
  Future<void> _saveReadStatus(Map<String, bool> readStatus) async {
    final prefs = await SharedPreferences.getInstance();
    // Simple JSON creation - consider using a proper JSON library for complex structures
    final buffer = StringBuffer();
    buffer.write('{');
    final entries = readStatus.entries.toList();
    for (int i = 0; i < entries.length; i++) {
      final entry = entries[i];
      buffer.write('"${entry.key}":${entry.value}');
      if (i < entries.length - 1) {
        buffer.write(',');
      }
    }
    buffer.write('}');
    await prefs.setString(_readStatusKey, buffer.toString());
  }

  /// Maps Failure to a user-friendly message
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      case NetworkFailure:
        return (failure as NetworkFailure).message;
      case CacheFailure:
        return (failure as CacheFailure).message;
      default:
        return 'An unexpected error occurred.';
    }
  }

  /// Calculates the number of unread announcements
  int getUnreadCount() {
    if (state is AnnouncementLoaded) {
      final loadedState = state as AnnouncementLoaded;
      return loadedState.readStatus.entries
          .where((entry) => entry.value == false)
          .length;
    }
    return 0;
  }
}
