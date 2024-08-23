part of 'images_bloc.dart';

sealed class ImagesEvent extends Equatable {
  const ImagesEvent();
}

class PickImageFromGalleryEvent extends ImagesEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PickImageFromCameraEvent extends ImagesEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class IsGalleryPermissionGranted extends ImagesEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class IsCameraPermissionGranted extends ImagesEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ResetPermissionDialog extends ImagesEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
