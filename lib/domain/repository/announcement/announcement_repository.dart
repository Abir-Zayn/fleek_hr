import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/domain/entities/announcement/announcement_entities.dart';


abstract class AnnouncementRepository {
  Future<Either<Failure, List<AnnouncementEntity>>> getAnnouncements();
}
