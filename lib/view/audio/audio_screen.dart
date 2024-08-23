import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task_4/res/app_strings/app_strings.dart';

import '../../bloc/audio/audio_bloc.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  @override
  void dispose() {
    context.read<AudioBloc>().state.audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          AppStrings.audioScreenTitleText,
          style: TextStyle(
            color: Colors.white70,
            fontStyle: FontStyle.italic,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocListener<AudioBloc, AudioState>(
        listener: (context, state) {
          if (state.showPermissionDialog) {
            _showPermissionDialog(
              context,
              state.dialogTitle ?? '',
              state.dialogContent ?? '',
            );
          }
        },
        child: BlocBuilder<AudioBloc, AudioState>(
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                if (state.audioFile != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Playing: ${state.audioFile!.path.split('/').last}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: Icon(
                          state.isPlaying ? Icons.pause : Icons.play_arrow,
                        ),
                        onPressed: () {
                          context
                              .read<AudioBloc>()
                              .add(ToggleAudioPlaybackEvent());
                        },
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<AudioBloc>()
                            .add(PickAudioFromFilesEvent());
                      },
                      child: const Text(AppStrings.pickAudioText),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showPermissionDialog(
      BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                context.read<AudioBloc>().add(ResetPermissionDialogForAudio());
                Navigator.of(context).pop();
              },
              child: const Text(AppStrings.cancelText),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
                context.read<AudioBloc>().add(ResetPermissionDialogForAudio());
                Navigator.of(context).pop();
              },
              child: const Text(AppStrings.allowText),
            ),
          ],
        );
      },
    );
  }
}
