// video_bloc.dart
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task_4/res/app_strings/app_strings.dart';
import 'package:task_4/utils/utils.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc(this._utils) : super(const VideoState()) {
    on<PickVideoFromGalleryEvent>(_pickVideoFromGalleryEvent);
    on<RecordVideoEvent>(_recordVideoEvent);
    on<GenerateThumbnailEvent>(_generateThumbnailEvent);
    on<ToggleVideoPlaybackEvent>(_toggleVideoPlaybackEvent);
    on<IsGalleryPermissionGrantedForVideo>(_isGalleryPermissionGranted);
    on<IsCameraPermissionGrantedForVideo>(_isCameraPermissionGranted);
    on<ResetPermissionDialogForVideo>(_resetPermissionDialog);
  }

  final Utils _utils;

  FutureOr<void> _pickVideoFromGalleryEvent(
      PickVideoFromGalleryEvent event, Emitter<VideoState> emit) async {
    if (state.isGalleryPermissionGranted) {
      final pickedFile = await _utils.pickVideoFromGallery();
      if (pickedFile != null) {
        emit(state.copyWith(videoFile: pickedFile));
        add(GenerateThumbnailEvent(pickedFile.path));
      }
    } else {
      add(IsGalleryPermissionGrantedForVideo());
    }
  }

  FutureOr<void> _recordVideoEvent(
      RecordVideoEvent event, Emitter<VideoState> emit) async {
    if (state.isCameraPermissionGranted) {
      final recordedFile = await _utils.recordVideo();
      if (recordedFile != null) {
        emit(state.copyWith(videoFile: recordedFile));
        add(GenerateThumbnailEvent(recordedFile.path));
      }
    } else {
      add(IsCameraPermissionGrantedForVideo());
    }
  }

  FutureOr<void> _generateThumbnailEvent(
      GenerateThumbnailEvent event, Emitter<VideoState> emit) async {
    // Generate the video thumbnail
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: event.videoPath,
      thumbnailPath: null,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 75,
    );

    // Update the state with the generated thumbnail path
    emit(state.copyWith(thumbnailPath: thumbnailPath));

    // Initialize the video player controller after the file has been picked
    if (event.videoPath.isNotEmpty) {
      final VideoPlayerController controller =
          VideoPlayerController.file(File(event.videoPath));
      await controller.initialize();
      state.videoPlayerController?.dispose();
      emit(state.copyWith(videoPlayerController: controller));
    }
  }

  FutureOr<void> _toggleVideoPlaybackEvent(
      ToggleVideoPlaybackEvent event, Emitter<VideoState> emit) async {
    if (state.videoPlayerController == null) return;

    final controller = state.videoPlayerController!;
    if (controller.value.isPlaying) {
      controller.pause();
      emit(state.copyWith(isPlaying: false));
    } else {
      controller.play();
      emit(state.copyWith(isPlaying: true));
    }
  }

  FutureOr<void> _isGalleryPermissionGranted(
      IsGalleryPermissionGrantedForVideo event,
      Emitter<VideoState> emit) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      emit(state.copyWith(isGalleryPermissionGranted: true));
      add(PickVideoFromGalleryEvent());
    } else if (status.isDenied || status.isPermanentlyDenied) {
      emit(state.copyWith(
        showPermissionDialog: true,
        dialogTitle: AppStrings.galleryPermissionRequiredText,
        dialogContent: AppStrings.galleryPermissionContentText,
      ));
    }
  }

  FutureOr<void> _isCameraPermissionGranted(
      IsCameraPermissionGrantedForVideo event, Emitter<VideoState> emit) async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      emit(state.copyWith(isCameraPermissionGranted: true));
      add(RecordVideoEvent());
    } else if (status.isDenied || status.isPermanentlyDenied) {
      emit(state.copyWith(
        showPermissionDialog: true,
        dialogTitle: AppStrings.cameraPermissionRequiredText,
        dialogContent:
            "Please enable the camera permission in settings to use this feature.",
      ));
    }
  }

  FutureOr<void> _resetPermissionDialog(
      ResetPermissionDialogForVideo event, Emitter<VideoState> emit) {
    emit(state.copyWith(showPermissionDialog: false));
  }
}
