import 'package:equatable/equatable.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/domain/entities/work_from_home/work_from_home_entity.dart';
import 'package:fleekhr/domain/usecase/work_from_home/createWorkFromHomeRequest_usecase.dart';
import 'package:fleekhr/domain/usecase/work_from_home/deleteWorkFromHomeRequest_usecase.dart';
import 'package:fleekhr/domain/usecase/work_from_home/getWorkFromHomeALL_usecase.dart';
import 'package:fleekhr/domain/usecase/work_from_home/getWorkFromHomeRequest_ID_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'work_from_home_state.dart';

class WorkFromHomeCubit extends Cubit<WorkFromHomeState> {
  WorkFromHomeCubit() : super(WorkFromHomeInitial());

  List<WorkFromHomeEntity>? _cachedList;

  Future<void> createWorkFromHomeRequest(WorkFromHomeEntity request) async {
    emit(WorkFromHomeLoading());
    final result = await sl<CreateworkfromhomerequestUsecase>().call(params: request);
    
    result.fold(
      (failure) => emit(WorkFromHomeError(failure.message)),
      (workFromHome) => emit(WorkFromHomeSuccess(workFromHome)),
    );
  }

  Future<void> getAllWorkFromHomeRequests(String employeeId) async {
    if (_cachedList == null || _cachedList!.isEmpty) {
      emit(WorkFromHomeLoading());
    }

    final result = await sl<GetworkfromhomeallUsecase>().call(params: employeeId);

    result.fold(
      (failure) => emit(WorkFromHomeError(failure.message)),
      (workFromHomeList) {
        _cachedList = workFromHomeList;
        emit(WorkFromHomeListSuccess(workFromHomeList));
      },
    );
  }

  Future<void> getWorkFromHomeRequestById(String id) async {
    final result = await sl<GetworkfromhomerequestIdUsecase>().call(params: id);

    result.fold(
      (failure) => emit(WorkFromHomeError(failure.message)),
      (workFromHome) {
        if (_cachedList != null) {
          emit(WorkFromHomeDetailSuccess(
            workFromHome: workFromHome,
            workFromHomeList: _cachedList!,
          ));
        } else {
          emit(WorkFromHomeSuccess(workFromHome));
        }
      },
    );
  }

  Future<void> deleteWorkFromHomeRequest(String id) async {
    emit(WorkFromHomeLoading());
    final result = await sl<DeleteworkfromhomerequestUsecase>().call(params: id);

    result.fold(
      (failure) => emit(WorkFromHomeError(failure.message)),
      (_) {
        if (_cachedList != null) {
          _cachedList = _cachedList!.where((item) => item.id != id).toList();
          emit(WorkFromHomeListSuccess(_cachedList!));
        } else {
          emit(WorkFromHomeInitial());
        }
      },
    );
  }

  void restoreListState() {
    if (_cachedList != null) {
      emit(WorkFromHomeListSuccess(_cachedList!));
    }
  }

  List<WorkFromHomeEntity>? get cachedWorkFromHomeList => _cachedList;
}