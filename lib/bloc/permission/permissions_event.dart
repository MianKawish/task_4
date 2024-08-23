part of 'permissions_bloc.dart';

sealed class PermissionsEvent extends Equatable {
  const PermissionsEvent();
}

class GetCameraPermissionEvent extends PermissionsEvent {
  @override
  List<Object?> get props => [];
}

class GetGalleryPermissionEvent extends PermissionsEvent {
  @override
  List<Object?> get props => [];
}

class GetStoragePermissionEvent extends PermissionsEvent {
  @override
  List<Object?> get props => [];
}
