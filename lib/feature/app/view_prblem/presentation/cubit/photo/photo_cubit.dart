import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/models/result.dart';
import '../../../../../../core/utils/status.dart';
import '../../../data/model/photo_response_model.dart';
import '../../../data/repo/photo_repo.dart';

part 'photo_state.dart';

// photo_cubit.dart
@injectable
class PhotoCubit extends Cubit<PhotoState> {
  final PhotoRepo _repo;

  PhotoCubit(this._repo) : super(const PhotoState());

  Future<void> getProblemPhotos(int problemId) async {
    if (problemId <= 0) return;

    emit(state.copyWith(photoState: Status.loading));

    final result = await _repo.getProblemPhotos(problemId);

    switch (result) {
      case ApiSuccessResult<List<PhotoResponseModel>>():
        emit(
          state.copyWith(
            photos: result.data,
            photoState: Status.success,
          ),
        );
      case ApiErrorResult<List<PhotoResponseModel>>():
        emit(
          state.copyWith(
            photoError: result.failures.toString(),
            photoState: Status.error,
          ),
        );
    }
  }

  Future<void> deletePhoto(int problemId, int photoId) async {
    final result = await _repo.deleteProblemPhoto(problemId, photoId);

    switch (result) {
      case ApiSuccessResult<void>():
      // Remove the photo from local state
        final updatedPhotos = state.photos.where((p) => p.id != photoId).toList();
        emit(state.copyWith(photos: updatedPhotos));

    // Show success message (you can use a toast package)
    // Fluttertoast.showToast(msg: 'تم حذف الصورة بنجاح');

      case ApiErrorResult<void>():
      // Show error message
      // Fluttertoast.showToast(msg: 'فشل في حذف الصورة');
        break;
    }
  }

  Future<void> deleteAllPhotos(int problemId) async {
    final result = await _repo.deleteAllProblemPhotos(problemId);

    switch (result) {
      case ApiSuccessResult<void>():
        emit(state.copyWith(photos: []));
    // Fluttertoast.showToast(msg: 'تم حذف جميع الصور بنجاح');

      case ApiErrorResult<void>():
      // Fluttertoast.showToast(msg: 'فشل في حذف صور المشكلة');
        break;
    }
  }
}

