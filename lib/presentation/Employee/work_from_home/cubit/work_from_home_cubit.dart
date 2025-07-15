import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/domain/entities/work_from_home/work_from_home_entity.dart';
import 'package:fleekhr/domain/usecase/work_from_home/createWorkFromHomeRequest_usecase.dart';
import 'package:fleekhr/domain/usecase/work_from_home/deleteWorkFromHomeRequest_usecase.dart';
import 'package:fleekhr/domain/usecase/work_from_home/getWorkFromHomeALL_usecase.dart';
import 'package:fleekhr/domain/usecase/work_from_home/getWorkFromHomeRequest_ID_usecase.dart';

part 'work_from_home_state.dart';

class WorkFromHomeCubit extends Cubit<WorkFromHomeState> {
  WorkFromHomeCubit() : super(WorkFromHomeInitial());

  Future<void> createWorkFromHomeRequest(WorkFromHomeEntity request) async {
    emit(WorkFromHomeLoading());
    final result =
        await sl<CreateworkfromhomerequestUsecase>().call(params: request);

    result.fold(
      (failure) => emit(WorkFromHomeError(failure.message)),
      (workFromHome) => emit(WorkFromHomeSuccess(workFromHome)),
    );
  }

  Future<void> getAllWorkFromHomeRequests(String employeeId) async {
    // Only emit loading if we don't have cached data to prevent flickering
    if (_lastWorkFromHomeList == null || _lastWorkFromHomeList!.isEmpty) {
      emit(WorkFromHomeLoading());
    }

    final result =
        await sl<GetworkfromhomeallUsecase>().call(params: employeeId);

    result.fold(
      (failure) => emit(WorkFromHomeError(failure.message)),
      (workFromHomeList) {
        // Cache the list for future use
        _lastWorkFromHomeList = workFromHomeList;
        emit(WorkFromHomeListSuccess(workFromHomeList));
      },
    );
  }

  // Keep track of the last retrieved list
  List<WorkFromHomeEntity>? _lastWorkFromHomeList;

  Future<void> getWorkFromHomeRequestById(String id) async {
    // Store the current state to preserve any existing list data
    final currentState = state;

    // Don't emit loading state to avoid flickering on the details page
    final result = await sl<GetworkfromhomerequestIdUsecase>().call(params: id);

    result.fold(
      (failure) => emit(WorkFromHomeError(failure.message)),
      (workFromHome) {
        // Get list data from different possible sources
        List<WorkFromHomeEntity>? listToPreserve;

        if (currentState is WorkFromHomeListSuccess) {
          listToPreserve = currentState.workFromHomeList;
          _lastWorkFromHomeList = currentState.workFromHomeList;
        } else if (currentState is WorkFromHomeDetailSuccess) {
          listToPreserve = currentState.workFromHomeList;
          _lastWorkFromHomeList = currentState.workFromHomeList;
        } else if (_lastWorkFromHomeList != null) {
          // Use cached list if available
          listToPreserve = _lastWorkFromHomeList;
        }

        if (listToPreserve != null) {
          // This allows us to maintain the list while showing details
          emit(WorkFromHomeDetailSuccess(
            workFromHome: workFromHome,
            workFromHomeList: listToPreserve,
          ));
        } else {
          // Regular details success without list preservation
          emit(WorkFromHomeSuccess(workFromHome));
        }
      },
    );
  }

  Future<void> deleteWorkFromHomeRequest(String id) async {
    // Store current state to potentially restore list data after deletion
    final currentState = state;
    List<WorkFromHomeEntity>? previousList;

    // Capture list from current state if available
    if (currentState is WorkFromHomeListSuccess) {
      previousList = currentState.workFromHomeList;
    } else if (currentState is WorkFromHomeDetailSuccess) {
      previousList = currentState.workFromHomeList;
    } else if (_lastWorkFromHomeList != null) {
      previousList = _lastWorkFromHomeList;
    }

    emit(WorkFromHomeLoading());
    final result =
        await sl<DeleteworkfromhomerequestUsecase>().call(params: id);

    result.fold(
      (failure) => emit(WorkFromHomeError(failure.message)),
      (_) {
        // If we had a previous list, restore it (with the deleted item removed)
        if (previousList != null) {
          final updatedList =
              previousList.where((item) => item.id != id).toList();

          // Update our cache
          _lastWorkFromHomeList = updatedList;

          emit(WorkFromHomeListSuccess(updatedList));
        } else {
          emit(WorkFromHomeInitial());
        }
      },
    );
  }

  // Method to directly restore list state without making API calls
  void restoreListState(List<WorkFromHomeEntity> list) {
    _lastWorkFromHomeList = list;
    emit(WorkFromHomeListSuccess(list));
  }

  // Getter to safely access the cached list
  List<WorkFromHomeEntity>? get cachedWorkFromHomeList => _lastWorkFromHomeList;
}
