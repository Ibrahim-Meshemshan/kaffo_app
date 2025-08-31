part of 'photo_cubit.dart';

class PhotoState {
  final Status photoState;
  final String? photoError;
  final List<PhotoResponseModel> photos;

  const PhotoState({
    this.photoState = Status.initial,
    this.photoError,
    this.photos = const [],
  });

  PhotoState copyWith({
    Status? photoState,
    String? photoError,
    List<PhotoResponseModel>? photos,
  }) {
    return PhotoState(
      photoState: photoState ?? this.photoState,
      photoError: photoError ?? this.photoError,
      photos: photos ?? this.photos,
    );
  }
}


