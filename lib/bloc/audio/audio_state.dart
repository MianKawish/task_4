// audio_state.dart
part of 'audio_bloc.dart';

class AudioState extends Equatable {
  final File? audioFile;
  final AudioPlayer? audioPlayer;
  final bool isPlaying;
  final bool isStoragePermissionGranted;
  final bool isMicrophonePermissionGranted;
  final bool showPermissionDialog;
  final String? dialogTitle;
  final String? dialogContent;

  const AudioState({
    this.audioFile,
    this.audioPlayer,
    this.isPlaying = false,
    this.isStoragePermissionGranted = false,
    this.isMicrophonePermissionGranted = false,
    this.showPermissionDialog = false,
    this.dialogTitle,
    this.dialogContent,
  });

  AudioState copyWith({
    File? audioFile,
    AudioPlayer? audioPlayer,
    bool? isPlaying,
    bool? isStoragePermissionGranted,
    bool? isMicrophonePermissionGranted,
    bool? showPermissionDialog,
    String? dialogTitle,
    String? dialogContent,
  }) {
    return AudioState(
      audioFile: audioFile ?? this.audioFile,
      audioPlayer: audioPlayer ?? this.audioPlayer,
      isPlaying: isPlaying ?? this.isPlaying,
      isStoragePermissionGranted:
          isStoragePermissionGranted ?? this.isStoragePermissionGranted,
      isMicrophonePermissionGranted:
          isMicrophonePermissionGranted ?? this.isMicrophonePermissionGranted,
      showPermissionDialog: showPermissionDialog ?? this.showPermissionDialog,
      dialogTitle: dialogTitle ?? this.dialogTitle,
      dialogContent: dialogContent ?? this.dialogContent,
    );
  }

  @override
  List<Object?> get props => [
        audioFile,
        audioPlayer,
        isPlaying,
        isStoragePermissionGranted,
        isMicrophonePermissionGranted,
        showPermissionDialog,
        dialogTitle,
        dialogContent,
      ];
}
