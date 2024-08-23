part of 'images_bloc.dart';

class ImagesState extends Equatable {
  final XFile? file;
  final bool isGalleryPermissionGranted;
  final bool isCameraPermissionGranted;
  final bool showPermissionDialog;
  final String? dialogTitle;
  final String? dialogContent;
  const ImagesState({
    this.file,
    this.isCameraPermissionGranted = false,
    this.isGalleryPermissionGranted = false,
    this.showPermissionDialog = false,
    this.dialogTitle,
    this.dialogContent,
  });
  ImagesState copyWith({
    XFile? file,
    bool? isCameraPermissionGranted,
    bool? isGalleryPermissionGranted,
    bool? showPermissionDialog,
    String? dialogTitle,
    String? dialogContent,
  }) {
    return ImagesState(
      file: file ?? this.file,
      isCameraPermissionGranted:
          isCameraPermissionGranted ?? this.isCameraPermissionGranted,
      isGalleryPermissionGranted:
          isGalleryPermissionGranted ?? this.isGalleryPermissionGranted,
      showPermissionDialog: showPermissionDialog ?? this.showPermissionDialog,
      dialogTitle: dialogTitle ?? this.dialogTitle,
      dialogContent: dialogContent ?? this.dialogContent,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        file,
        isGalleryPermissionGranted,
        isCameraPermissionGranted,
        showPermissionDialog,
        dialogTitle,
        dialogContent
      ];
}
