// audio_event.dart
part of 'audio_bloc.dart';

abstract class AudioEvent extends Equatable {
  const AudioEvent();

  @override
  List<Object> get props => [];
}

class PickAudioFromFilesEvent extends AudioEvent {}

class RecordAudioEvent extends AudioEvent {}

class GenerateAudioThumbnailEvent extends AudioEvent {
  final String audioPath;

  const GenerateAudioThumbnailEvent(this.audioPath);

  @override
  List<Object> get props => [audioPath];
}

class ToggleAudioPlaybackEvent extends AudioEvent {}

class IsStoragePermissionGrantedForAudio extends AudioEvent {}

class IsMicrophonePermissionGrantedForAudio extends AudioEvent {}

class ResetPermissionDialogForAudio extends AudioEvent {}
