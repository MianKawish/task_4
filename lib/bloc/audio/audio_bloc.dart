import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc() : super(const AudioState()) {
    on<PickAudioFromFilesEvent>(_pickAudioFromFilesEvent);
    on<ToggleAudioPlaybackEvent>(_toggleAudioPlaybackEvent);
    on<IsStoragePermissionGrantedForAudio>(_isStoragePermissionGranted);
    on<ResetPermissionDialogForAudio>(_resetPermissionDialog);
  }

  FutureOr<void> _pickAudioFromFilesEvent(
      PickAudioFromFilesEvent event, Emitter<AudioState> emit) async {
    if (state.isStoragePermissionGranted) {
      // Stop and dispose the previous audio player
      state.audioPlayer?.stop();
      state.audioPlayer?.dispose();

      final result = await FilePicker.platform.pickFiles(type: FileType.audio);
      if (result != null) {
        final pickedFile = File(result.files.single.path!);
        final player = AudioPlayer();

        emit(state.copyWith(
            audioFile: pickedFile, audioPlayer: player, isPlaying: false));
        await player.setSource(DeviceFileSource(pickedFile.path));
        emit(state.copyWith(
            isPlaying: false)); // Ensure initial state is stopped

        // Optionally, auto-start playback here
        // await player.play();
      }
    } else {
      add(IsStoragePermissionGrantedForAudio());
    }
  }

  FutureOr<void> _toggleAudioPlaybackEvent(
      ToggleAudioPlaybackEvent event, Emitter<AudioState> emit) async {
    if (state.audioFile == null) return;

    final player = state.audioPlayer ?? AudioPlayer();
    if (state.isPlaying) {
      await player.pause();
      emit(state.copyWith(isPlaying: false, audioPlayer: player));
    } else {
      await player.play(DeviceFileSource(state.audioFile!.path));
      emit(state.copyWith(isPlaying: true, audioPlayer: player));
    }
  }

  FutureOr<void> _isStoragePermissionGranted(
      IsStoragePermissionGrantedForAudio event,
      Emitter<AudioState> emit) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      emit(state.copyWith(isStoragePermissionGranted: true));
      add(PickAudioFromFilesEvent());
    } else if (status.isDenied || status.isPermanentlyDenied) {
      emit(state.copyWith(
        showPermissionDialog: true,
        dialogTitle: "Storage Permission Required",
        dialogContent:
            "Please enable the storage permission in settings to use this feature.",
      ));
    }
  }

  FutureOr<void> _resetPermissionDialog(
      ResetPermissionDialogForAudio event, Emitter<AudioState> emit) {
    emit(state.copyWith(showPermissionDialog: false));
  }
}
