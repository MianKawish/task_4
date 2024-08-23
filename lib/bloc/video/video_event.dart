// video_event.dart
part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object?> get props => [];
}

class PickVideoFromGalleryEvent extends VideoEvent {}

class RecordVideoEvent extends VideoEvent {}

class GenerateThumbnailEvent extends VideoEvent {
  final String videoPath;

  const GenerateThumbnailEvent(this.videoPath);

  @override
  List<Object?> get props => [videoPath];
}

class ToggleVideoPlaybackEvent extends VideoEvent {}

class IsGalleryPermissionGrantedForVideo extends VideoEvent {}

class IsCameraPermissionGrantedForVideo extends VideoEvent {}

class ResetPermissionDialogForVideo extends VideoEvent {}

class PickNewVideoEvent extends VideoEvent {
  final XFile newVideo;

  PickNewVideoEvent(this.newVideo);
  @override
  List<Object?> get props => [newVideo];
}
