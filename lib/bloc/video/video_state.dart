// video_state.dart
part of 'video_bloc.dart';

class VideoState extends Equatable {
  final XFile? videoFile;
  final String? thumbnailPath;
  final VideoPlayerController? videoPlayerController;
  final bool isGalleryPermissionGranted;
  final bool isCameraPermissionGranted;
  final bool showPermissionDialog;
  final String? dialogTitle;
  final String? dialogContent;
  final bool isPlaying;

  const VideoState({
    this.videoFile,
    this.thumbnailPath,
    this.videoPlayerController,
    this.isGalleryPermissionGranted = false,
    this.isCameraPermissionGranted = false,
    this.showPermissionDialog = false,
    this.dialogTitle,
    this.dialogContent,
    this.isPlaying = false,
  });

  VideoState copyWith({
    XFile? videoFile,
    String? thumbnailPath,
    VideoPlayerController? videoPlayerController,
    bool? isGalleryPermissionGranted,
    bool? isCameraPermissionGranted,
    bool? showPermissionDialog,
    String? dialogTitle,
    String? dialogContent,
    bool? isPlaying,
  }) {
    return VideoState(
      videoFile: videoFile ?? this.videoFile,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      videoPlayerController:
          videoPlayerController ?? this.videoPlayerController,
      isGalleryPermissionGranted:
          isGalleryPermissionGranted ?? this.isGalleryPermissionGranted,
      isCameraPermissionGranted:
          isCameraPermissionGranted ?? this.isCameraPermissionGranted,
      showPermissionDialog: showPermissionDialog ?? this.showPermissionDialog,
      dialogTitle: dialogTitle ?? this.dialogTitle,
      dialogContent: dialogContent ?? this.dialogContent,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object?> get props => [
        videoFile,
        thumbnailPath,
        videoPlayerController,
        isGalleryPermissionGranted,
        isCameraPermissionGranted,
        showPermissionDialog,
        dialogTitle,
        dialogContent,
        isPlaying,
      ];
}
