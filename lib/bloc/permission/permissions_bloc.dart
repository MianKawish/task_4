import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'permissions_event.dart';
part 'permissions_state.dart';

class PermissionsBloc extends Bloc<PermissionsEvent, PermissionsState> {
  PermissionsBloc() : super(PermissionsInitial()) {
    on<GetCameraPermissionEvent>(_getCameraPermissionEvent);
    on<GetGalleryPermissionEvent>(_getGalleryPermissionEvent);
    on<GetStoragePermissionEvent>(_getStoragePermissionEvent);
  }

  FutureOr<void> _getStoragePermissionEvent(
      GetStoragePermissionEvent event, Emitter<PermissionsState> emit) {}

  FutureOr<void> _getGalleryPermissionEvent(
      GetGalleryPermissionEvent event, Emitter<PermissionsState> emit) {}

  FutureOr<void> _getCameraPermissionEvent(
      GetCameraPermissionEvent event, Emitter<PermissionsState> emit) {}
}
