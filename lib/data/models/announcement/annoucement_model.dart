import 'package:fleekhr/domain/entities/announcement/announcement_entities.dart';

class AnnouncementModel extends AnnouncementEntity {
  const AnnouncementModel({
    required super.id,
    required super.title,
    required super.content,
    required super.createdAt,
    super.publishedAt,
    super.authorId,
    super.isPublished,
    super.attachments,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    try {
      // Handle attachments field - it can be null, array, or object
      dynamic attachments;
      if (json['attachments'] != null) {
        // Keep the original structure - could be array, object, or other type
        attachments = json['attachments'];
      }

      return AnnouncementModel(
        id: json['id']?.toString() ?? '',
        title: json['title']?.toString() ?? '',
        content: json['content']?.toString() ?? '',
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'].toString())
            : DateTime.now(),
        publishedAt: json['published_at'] != null
            ? DateTime.parse(json['published_at'].toString())
            : null,
        authorId: json['author_id']?.toString(),
        isPublished: json['is_published'] ?? false,
        attachments: attachments,
      );
    } catch (e) {
      print('Error parsing announcement: $e');
      print('JSON data: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'published_at': publishedAt?.toIso8601String(),
      'author_id': authorId,
      'is_published': isPublished,
      'attachments': attachments,
    };
  }

  factory AnnouncementModel.fromEntity(AnnouncementEntity entity) {
    return AnnouncementModel(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      createdAt: entity.createdAt,
      publishedAt: entity.publishedAt,
      authorId: entity.authorId,
      isPublished: entity.isPublished,
      attachments: entity.attachments,
    );
  }

  AnnouncementEntity toEntity() {
    return AnnouncementEntity(
      id: id,
      title: title,
      content: content,
      createdAt: createdAt,
      publishedAt: publishedAt,
      authorId: authorId,
      isPublished: isPublished,
      attachments: attachments,
    );
  }
}
