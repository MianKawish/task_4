import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task_4/utils/utils.dart';

part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  ImagesBloc(this._utils) : super(const ImagesState()) {
    on<PickImageFromGalleryEvent>(_pickImageFromGalleryEvent);
    on<PickImageFromCameraEvent>(_pickImageFromCameraEvent);
    on<IsCameraPermissionGranted>(_isCameraPermissionGranted);
    on<IsGalleryPermissionGranted>(_isGalleryPermissionGranted);
    on<ResetPermissionDialog>(_resetPermissionDialog);
  }
  final Utils _utils;

  FutureOr<void> _pickImageFromGalleryEvent(
      PickImageFromGalleryEvent event, Emitter<ImagesState> emit) async {
    if (state.isGalleryPermissionGranted) {
      XFile? file = await _utils.pickImageFromGallery();
      emit(state.copyWith(file: file));
    } else {
      add(IsGalleryPermissionGranted());
    }
  }

  FutureOr<void> _pickImageFromCameraEvent(
      PickImageFromCameraEvent event, Emitter<ImagesState> emit) async {
    if (state.isGalleryPermissionGranted) {
      XFile? file = await _utils.cameraCapture();
      emit(state.copyWith(file: file));
    } else {
      add(IsCameraPermissionGranted());
    }
  }

  FutureOr<void> _isCameraPermissionGranted(
      IsCameraPermissionGranted event, Emitter<ImagesState> emit) async {
    PermissionStatus status = await Permission.camera.request();
    if (status.isGranted) {
      emit(state.copyWith(isCameraPermissionGranted: true));
      add(PickImageFromCameraEvent());
    } else if (status.isDenied || status.isPermanentlyDenied) {
      emit(state.copyWith(
        showPermissionDialog: true,
        dialogTitle: "Camera Permission Required",
        dialogContent:
            "Please enable the camera permission in settings to use this feature.",
      ));
    }
  }

  FutureOr<void> _isGalleryPermissionGranted(
      IsGalleryPermissionGranted event, Emitter<ImagesState> emit) async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      emit(state.copyWith(isGalleryPermissionGranted: true));
      add(PickImageFromGalleryEvent());
    } else if (status.isDenied) {
      emit(state.copyWith(isGalleryPermissionGranted: false));
    } else if (status.isDenied || status.isPermanentlyDenied) {
      emit(state.copyWith(
        showPermissionDialog: true,
        dialogTitle: "Gallery Permission Required",
        dialogContent:
            "Please enable the gallery permission in settings to use this feature.",
      ));
    }
  }

  FutureOr<void> _resetPermissionDialog(
      ResetPermissionDialog event, Emitter<ImagesState> emit) {
    emit(state.copyWith(showPermissionDialog: false));
  }
}
