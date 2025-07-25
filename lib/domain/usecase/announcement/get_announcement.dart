import 'package:dartz/dartz.dart';
import 'package:fleekhr/core/usecase/usecase.dart';
import 'package:fleekhr/domain/repository/announcement/announcement_repository.dart';
import 'package:get_it/get_it.dart';

class GetAnnouncementsUseCase
    implements Usecase<Either, void> {
  final AnnouncementRepository repository = GetIt.I<AnnouncementRepository>();

  @override
  Future<Either> call({required void params}) async {
    return await repository.getAnnouncements();
  }
}