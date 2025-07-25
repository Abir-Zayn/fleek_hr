import 'package:equatable/equatable.dart';

class AnnouncementEntity extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime? publishedAt;
  final String? authorId;
  final bool isPublished;
  final Map<String, dynamic>? attachments;

  const AnnouncementEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.publishedAt,
    this.authorId,
    this.isPublished = false,
    this.attachments,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        createdAt,
        publishedAt,
        authorId,
        isPublished,
        attachments,
      ];
}
