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
      print('🔍 Fetching announcements from Supabase...');

      final response = await supabaseClient
          .from('announcements')
          .select()
          .eq('is_published', true)
          .order('published_at', ascending: false);

      print('📡 Supabase response: $response');
      print('📊 Response type: ${response.runtimeType}');
      print('📝 Found ${response.length} announcements');

      final announcements = <AnnouncementModel>[];

      for (var item in response) {
        print('🔄 Processing item: $item (type: ${item.runtimeType})');

        try {
          final announcement = AnnouncementModel.fromJson(item);
          announcements.add(announcement);
          print('✅ Successfully parsed announcement: ${announcement.title}');
        } catch (e) {
          print('❌ Failed to parse announcement: $e');
          print('📄 Raw data: $item');
          // Continue processing other items instead of failing completely
        }
      }

      print('✅ Successfully parsed ${announcements.length} announcements');
      return Right(announcements);
    } catch (e, stackTrace) {
      print('💥 Error fetching announcements: $e');
      print('📚 Stack trace: $stackTrace');
      return Left(
          ServerFailure('Failed to fetch announcements: ${e.toString()}'));
    }
  }
}
