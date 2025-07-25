import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/data/models/announcement/annoucement_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AnnouncementService {
  Future<Either<Failure, List<AnnouncementModel>>> getAnnouncements();
}

class AnnouncementServiceImpl implements AnnouncementService {
  final SupabaseClient supabaseClient;
  AnnouncementServiceImpl(this.supabaseClient);

  @override
  Future<Either<Failure, List<AnnouncementModel>>> getAnnouncements() async {
    try {
      final response = await supabaseClient
          .from('announcements')
          .select()
          .eq('is_published', true)
          .order('published_at', ascending: false);

      final announcements = (response as List)
          .map((json) => AnnouncementModel.fromJson(json))
          .toList();

      return Right(announcements);
    } catch (e) {
      return Left(
          ServerFailure('Failed to fetch announcements: ${e.toString()}'));
    }
  }
}
