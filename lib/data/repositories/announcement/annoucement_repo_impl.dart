

import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/error/failure.dart';
import 'package:fleekhr/data/models/announcement/annoucement_model.dart';
import 'package:fleekhr/data/service/announcement/announcement_service.dart';
import 'package:fleekhr/domain/repository/announcement/announcement_repository.dart';
import 'package:get_it/get_it.dart';

class AnnoucementRepoImpl implements AnnouncementRepository{
  final AnnouncementService _service = GetIt.I<AnnouncementService>();

  @override
  Future<Either<Failure, List<AnnouncementModel>>> getAnnouncements() async {
    return await _service.getAnnouncements();  }
}